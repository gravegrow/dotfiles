local lsputils = require "core.utils.lsp"
local M = {}

M.ensure_installed = {
  "pyright",
  "lua_ls",
  "jsonls",
  "yamlls",
}

M.servers = {}

M.servers.lua_ls = {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
  -- settings = {
  --   Lua = {
  --     runtime = {
  --       version = "LuaJIT",
  --     },
  --     diagnostics = {
  --       globals = { "vim" },
  --     },
  --     workspace = {
  --       library = {
  --         vim.api.nvim_get_runtime_file("", true),
  --         [vim.fn.expand "$VIMRUNTIME/lua"] = true,
  --         [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
  --       },
  --       maxPreload = 100000,
  --       preloadFileSize = 10000,
  --       checkThirdParty = false,
  --     },
  --   },
  -- },
}

local maya_completions = "/media/storage/dev/maya/devkitBase/devkit/other/Python27/pymel/extras/completion/"
M.servers.pyright = {
  settings = {
    python = {
      analysis = {
        extraPaths = {
          maya_completions .. "py",
        },
        stubPath = maya_completions .. "pyi",
      },
    },
  },
}

M.config = function()
  require("mason").setup()
  local lspconfig = require "lspconfig"
  local mason_lsp = require "mason-lspconfig"

  lspconfig.gdscript.setup {}

  mason_lsp.setup { ensure_installed = M.ensure_installed }

  mason_lsp.setup_handlers {
    function(server_name)
      local config = {}
      config.on_attach = lsputils.on_attach
      config.handlers = lsputils.handlers
      config.capabilities = lsputils.capabilities

      if M.servers[server_name] ~= nil then
        config = vim.tbl_deep_extend("force", config, M.servers[server_name])
      end

      lspconfig[server_name].setup(config)
    end,
  }
end

return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  cmd = "Mason",
  config = M.config,
  dependencies = {
    {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
}
