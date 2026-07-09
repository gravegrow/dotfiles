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

----------------------------------------
--            MINI PICK               --
----------------------------------------

-- stylua: ignore start
local exclude_filetypes = {
    ".meta", ".asmdef", ".inputactions", ".sln", ".slnx", ".csproj",
    ".uid", ".tscn", ".godot", ".import", ".png", ".jpg", ".jpeg",
    ".webp", ".svg", ".bmp", ".tga", ".gif", ".psd", ".psb", ".tiff",
    ".tif", ".iff", ".exr", ".hdr", ".dds", ".wav", ".mp3", ".ogg",
    ".aif", ".aiff", ".mod", ".it", ".s3m", ".xm", ".gltf", ".glb",
    ".fbx", ".obj", ".dae", ".3ds", ".dxf", ".blend", ".max", ".maya",
    ".mb", ".modo", ".mp4", ".mov", ".webm", ".avi", ".m4v", ".mpg",
    ".mpeg", ".ogv", ".asset", ".unity"
}
-- stylua: ignore end

local minipick = require("mini.pick")
local miniextra = require("mini.extra")
miniextra.setup()

minipick.setup({
    mappings = {
        choose = "<C-Y>",
        choose_y = {
            char = "<CR>",
            func = function()
                minipick.default_choose(minipick.get_picker_matches().current)
                return true
            end,
        },
    },
    window = {
        config = function()
            return { height = math.max(math.floor(vim.o.lines * 0.30), 5) }
        end,
        prompt_prefix = "  ",
    },
})

local show_with_icons = function(buf_id, items, query)
    return minipick.default_show(buf_id, items, query, { show_icons = true })
end

keymap("n", "<leader>ff", function()
    local cmd = { "rg", "--files" }

    for _, ext in ipairs(exclude_filetypes) do
        table.insert(cmd, "--glob")
        table.insert(cmd, "!*" .. ext)
    end

    minipick.builtin.cli({ command = cmd }, {
        source = {
            name = "Filtered Files",
            show = show_with_icons,
        },
    })
end, { desc = "Files" })

keymap("n", "<leader>fF", function()
    minipick.builtin.cli({ command = { "rg", "--hidden", "--files" } }, {
        source = {
            name = "All Files",
            show = show_with_icons,
        },
    })
end, { desc = "All Files" })

keymap("n", "<leader>fo", miniextra.pickers.oldfiles, { desc = "Oldfiles" })
keymap("n", "<leader>fb", minipick.builtin.buffers, { desc = "Buffers" })
keymap("n", "<leader>fg", minipick.builtin.grep_live, { desc = "Grep" })
keymap("n", "<leader>fd", miniextra.pickers.diagnostic, { desc = "Diagnostics" })
keymap("n", "<leader>fl", function()
    miniextra.pickers.buf_lines({ scope = "current" })
end, { desc = "Lines" })

local win_height

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniPickStop",
    callback = function()
        win_height = nil
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniPickMatch",
    callback = function()
        if win_height then
            return
        end

        local state = minipick.get_picker_state()
        if not state or not state.windows or not state.windows.main then
            return
        end

        local matches = minipick.get_picker_matches()
        if matches.all == nil then
            return
        end
        local item_count = #matches.all
        if item_count < 1 then
            return
        end

        local max_height = math.max(math.floor(vim.o.lines * 0.30), 5)
        win_height = math.min(item_count, max_height)

        vim.api.nvim_win_set_config(state.windows.main, {
            height = win_height,
        })
    end,
})

----------------------------------------
--            MINI FILES              --
----------------------------------------

local filtered_entries = {}

local apply_filter = function(fs_entry, func)
    local path = fs_entry.path
    if not filtered_entries[path] then
        if func(fs_entry) then
            filtered_entries[path] = true
        end
    end
end

local filter_dotfiles = function(fs_entry)
    apply_filter(fs_entry, function()
        return vim.startswith(fs_entry.name, ".")
    end)
end

local filter_filetypes = function(fs_entry)
    for _, ft in ipairs(exclude_filetypes) do
        apply_filter(fs_entry, function()
            return vim.endswith(fs_entry.name, ft)
        end)
    end
end

local filter_gitignore = function(fs_entry)
    apply_filter(fs_entry, function()
        return vim.system({ "git", "check-ignore", "-q", fs_entry.path }):wait().code == 0
    end)
end

local filter_hide = function(fs_entry)
    filter_dotfiles(fs_entry)
    filter_filetypes(fs_entry)
    filter_gitignore(fs_entry)
    if filtered_entries[fs_entry.path] ~= nil then
        return false
    end
    return true
end

local toggle = true

local filter_show = function()
    return true
end

local filter_toggle = function()
    toggle = not toggle
    MiniFiles.refresh({ content = { filter = toggle and filter_hide or filter_show } })
end

require("mini.files").setup({
    mappings = {
        close = "<ESC>",
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
    },
    content = { filter = filter_hide },
})

keymap("n", "<C-E>", function(...)
    if not MiniFiles.close() then
        MiniFiles.open(...)
        MiniFiles.refresh({ content = { filter = toggle and filter_hide or filter_show } })
    end
end)

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        keymap("n", "g.", filter_toggle, { buffer = buf_id })
        keymap("n", "<CR>", function()
            require("mini.files").go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = "Go in and close" })
    end,
})

----------------------------------------
--            MINI NOTIFY             --
----------------------------------------

require("mini.notify").setup({
    content = {
        format = function(notif)
            return " " .. notif.msg .. " "
        end,
        sort = function(notif_array)
            notif_array = vim.tbl_filter(function(notif)
                return notif.msg ~= "Not in bound"
            end, notif_array)

            return require("mini.notify").default_sort(notif_array)
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

local set_hl = _G.merge_set_hl

local highlights = {
    MiniPickNormal = { link = "@property", italic = true },
    MiniPickMatchCurrent = { bold = true },
    MiniPickMatchMarked = { link = "Search", bold = true },
    MiniPickMatchRanges = { link = "Search", bold = true },
    MiniPickPrompt = { link = "@property", bold = true },
    MiniPickPromptCaret = { link = "Search" },
    MiniPickPromptPrefix = { link = "Search" },
}

for hl, opts in pairs(highlights) do
    set_hl(hl, opts)
end
