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
    ".mpeg", ".ogv", ".asset"
}
-- stylua: ignore end

local minipick = require("mini.pick")
local miniextra = require("mini.extra")
miniextra.setup()

minipick.setup({
    window = {
        config = function()
            return { height = math.max(math.floor(vim.o.lines * 0.3), 5) }
        end,
    },
    mappings = {
        quickfix = {
            char = "<C-q>",
            func = function()
                local matches = minipick.get_picker_matches()
                if not matches then
                    return true
                end

                local targets = #matches.marked ~= 0 and matches.marked or matches.all
                minipick.default_choose_marked(targets, { list_type = "quickfix" })
                return true
            end,
        },
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
