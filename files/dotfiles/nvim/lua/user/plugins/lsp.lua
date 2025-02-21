local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          extraPaths = {
            "/media/storage/development/maya/devkit2020.3/devkit/other/Python27/pymel/extras/completion/py",
            "/media/storage/development/maya/devkit2020.3/devkit/other/Python27/pymel/extras/completion/pyi",
          },
        },
      },
    },
  },
  ruff = {},
  clangd = {},
  taplo = {},
  yamlls = {},
  jsonls = {},
  bashls = {},
  neocmake = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = { disable = { "missing-fields" } },
        format = { enable = false },
      },
    },
  },
}

local formatters = {
  "stylua",
  "gdtoolkit",
  "shfmt",
  "prettier",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("on-lsp-keybinds", { clear = true }),
        callback = function(event)
          local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local function toggle_inlay_hints()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end

          vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help, { buffer = event.buf })

          keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          keymap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
          keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          keymap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          keymap("<leader>ci", toggle_inlay_hints, "[C]ode [I]nlay Toggle")
          keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.name == "basedpyright" then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      local border = {
        { "", "FloatBorder" },
        { "", "FloatBorder" },
        { "", "FloatBorder" },
        { " ", "FloatBorder" },
        { "", "FloatBorder" },
        { "", "FloatBorder" },
        { "", "FloatBorder" },
        { " ", "FloatBorder" },
      }
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        float = { border = "solid", header = false },
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰰁" })

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local status, cmp_lsp = pcall(require, "cmp_nvim_lsp")

      if status then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end

      local status, blink_cmp = pcall(require, "blink.cmp")
      if status then
        capabilities = blink_cmp.get_lsp_capabilities(capabilities)
      end

      local lspconfig = require("lspconfig")

      lspconfig.gdscript.setup({ capabilities = capabilities })
      lspconfig.gdshader_lsp.setup({ capabilities = capabilities })

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, formatters)

      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            if server_name == "ruff" then
              lspconfig[server_name].setup(server)
              return
            end

            lspconfig[server_name].setup({
              cmd = server.cmd,
              settings = server.settings,
              handlers = handlers,
              filetypes = server.filetypes,
              capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
            })
          end,
        },
      })
    end,
  },
}
