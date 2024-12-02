local servers = {
  pyright = {},
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

          keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          keymap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          keymap("<leader>ci", toggle_inlay_hints, "[C]ode [I]nlay Toggle")
          keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        end,
      })

      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then
      --       return
      --     end
      --
      --     if client.name == "basedpyright" then
      --       vim.highlight.priorities.semantic_tokens = 95
      --     end
      --   end,
      -- })

      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        float = { border = "single" },
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰰁" })

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local status, cmp_lsp = pcall(require, "cmp_nvim_lsp")

      if status then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
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

  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      config = {
        settings = {
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      },
    },
  },
}
