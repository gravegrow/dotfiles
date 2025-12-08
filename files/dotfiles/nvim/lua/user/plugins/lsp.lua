local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        typeCheckingMode = "standard",
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
  cssls = {},
  yamlls = {},
  jsonls = {},
  bashls = {},
  qmlls = {},
  neocmake = {},
  glsl_analyzer = {},
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
          keymap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
          keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          -- keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          keymap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          keymap("<leader>ci", toggle_inlay_hints, "[C]ode [I]nlay Toggle")
          keymap("K", vim.lsp.buf.hover, "Hover Documentation")

          keymap("<leader>dd", function()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
            vim.diagnostic.open_float()
            vim.api.nvim_create_autocmd("CursorMoved", {
              group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
              callback = function()
                vim.diagnostic.config({
                  virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
                })
                return true
              end,
            })
          end, "Show [D]iagnostic [D]isplay")
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        float = { border = "solid", header = "" },
        virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
        signs = {
          text = {
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰰁",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
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

      for name, server in pairs(servers) do
        server = server or {}

        lspconfig[name].setup({
          cmd = server.cmd,
          settings = server.settings,
          filetypes = server.filetypes,
          capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
        })
      end
    end,
  },
}
