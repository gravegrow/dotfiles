local lsputils = require "core.utils.lsp"
local M = {}

M.ensure_installed = {
  "pyright",
  "lua_ls",
  "jsonls",
  "omnisharp_mono",
  "clangd",
}

M.servers = {}

M.servers.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
        checkThirdParty = false,
      },
    },
  },
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

M.servers.omnisharp_mono = {
  on_attach = function(client, bufnr)
    local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
    for i, v in ipairs(tokenModifiers) do
      tokenModifiers[i] = v:gmatch "[^_ ]*" ()
    end
    local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
    for i, v in ipairs(tokenTypes) do
      tokenTypes[i] = v:gmatch "[^_ ]*" ()
    end
  end,
  capabilities = lsputils.capabilities_with_dynamic_registration,
  flags = { debounce_text_changes = 150 },
}

M.config = function()
  require("mason").setup()
  local lspconfig = require "lspconfig"
  local mason_lsp = require "mason-lspconfig"

  M.servers.omnisharp_mono.handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {}),
    ["textDocument/definition"] = require("omnisharp_extended").handler,
  }

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
      "Hoffs/omnisharp-extended-lsp.nvim",
      {
        "ray-x/lsp_signature.nvim",
        opts = {
          hint_enable = true,
          hint_prefix = "",
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          handler_opts = {
            border = "single",
          },
          toggle_key = "<M-k>",
          doc_lines = 0,
          floating_window = false,
        },
      },
    },
  },
}
