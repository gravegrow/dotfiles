local keymap = vim.keymap.set

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.cmdline").setup({ autocomplete = { enable = false } })
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.align").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.move").setup()
require("mini.notify").setup({
    content = {
        format = function(notif)
            return " " .. notif.msg .. " "
        end,
    },
    window = {
        max_width_share = 0.5,
        winblend = 0,
        config = function()
            local has_statusline = vim.o.laststatus > 0
            local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
            return {
                anchor = "SE",
                title = "",
                col = vim.o.columns,
                row = vim.o.lines - pad,
            }
        end,
    },
})

require("mini.files").setup({
    mappings = {
        close = "<ESC>",
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
    },
    content = {
        filter = function(fs_entry)
            return not vim.startswith(fs_entry.name, ".")
        end,
    },
})

keymap("n", "<C-E>", function(...)
    if not MiniFiles.close() then
        MiniFiles.open(...)
    end
end)

local show_dotfiles = false

local filter_show = function(_)
    return true
end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        keymap("n", "g.", toggle_dotfiles, { buffer = buf_id })
        keymap("n", "<CR>", function()
            require("mini.files").go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = "Go in and close" })
    end,
})
