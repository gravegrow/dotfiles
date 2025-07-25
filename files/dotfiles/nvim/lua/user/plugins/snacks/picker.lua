return {
  "snacks.nvim",
  opts = {
    explorer = {},
    picker = {
      prompt = "  ",
      layout = {
        preset = function()
          return vim.o.columns > 100 and "horizontal" or "vertical"
        end,
      },
      layouts = {
        sidebar = {
          layout = {
            width = 40,
            min_width = 40,
            height = 0,
            position = "left",
            border = "none",
            box = "vertical",
            { win = "input", height = 1, border = "none" },
            { win = "list", border = "none" },
            { win = "preview" },
          },
        },
        ivy = {
          layout = {
            backdrop = false,
            box = "vertical",
            row = -1,
            width = 0,
            height = 8,
            { win = "input", height = 1, border = "none" },
            { win = "list", border = "none" },
            { win = "preview" },
          },
        },
        horizontal = {
          layout = {
            backdrop = false,
            box = "horizontal",
            width = 0.8,
            height = 0.8,
            {
              box = "vertical",
              min_width = 50,
              width = 50,
              { win = "input", height = 1, border = "none" },
              { win = "list", border = "solid" },
            },
            { win = "preview", border = "left" },
          },
        },
        vertical = {
          preview = false,
          layout = {
            backdrop = false,
            box = "vertical",
            width = 0.8,
            height = 0.8,
            { win = "input", height = 1, border = "none" },
            {
              box = "vertical",
              { win = "list", border = "solid" },
              { win = "preview", border = "top", height = 0.65 },
            },
          },
        },
        select = {
          preview = false,
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.6,
            box = "vertical",
            { win = "input", height = 1, border = "top", title = "{title}" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
      },
      sources = {
        lsp_symbols = { layout = { preset = "sidebar" } },
        lsp_references = { layout = { preview = "main", preset = "ivy" } },
        lines = { layout = { preview = false, preset = "ivy" } },
        diagnostics = { layout = { preview = "main", preset = "ivy" } },
        diagnostics_buffer = { layout = { preview = "main", preset = "ivy" } },
        undo = { layout = { preview = "main", preset = "sidebar" } },
        colorschemes = { layout = { preview = "input", preset = "select" } },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 60,
        },
      },
      win = {
        input = {
          keys = {
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          },
        },
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    -- stylua: ignore start
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader><space>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>u", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- find
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fF", function() Snacks.picker.files({hidden = true}) end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fo", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ft", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>fW", function() Snacks.picker.grep_word({search = function () return vim.fn.expand("<cWORD>") end}) end,
      desc = "cWORD", mode = { "n", "x" } },
    { "<leader>fl", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- stylua: ignore end
  },
}
