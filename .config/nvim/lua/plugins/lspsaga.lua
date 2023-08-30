return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  opts = {
    rename = {
      quit = "<ESC>",
      in_select = false,
    },
    symbol_in_winbar = {
      enable = false,
    },
    code_action = {
      keys = {
        quit = { "q", "<ESC>" },
      },
    },
    lightbulb = {
      enable_in_insert = false,
      sign = true,
      sign_priority = 40,
      virtual_text = false,
    },
    ui = {
      title = false,
      border = "single",
      code_action = " ",
    },
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
    local keymap = vim.keymap.set

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    -- keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

    -- Rename all occurrences of the hovered word for the selected files
    -- keymap("n", "<leader>rn", "<cmd>Lspsaga rename ++project<CR>")

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Go to type definition
    keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>dd", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Toggle outline
    keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
    -- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

    -- Call hierarchy
    keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    -- Floating terminal
    keymap({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<CR>")
  end,
}
