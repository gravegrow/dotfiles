vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/xzbdmw/colorful-menu.nvim",
})
require("colorful-menu").setup({ max_width = 50 })

require("blink.cmp").setup({
    cmdline = {
        keymap = { preset = "inherit" },
        completion = {
            menu = { auto_show = true },
        },
    },
    signature = {
        enabled = true,
        window = { winhighlight = "FloatBorder:FloatBorder" },
    },
    completion = {
        accept = {
            auto_brackets = {
                enabled = false,
            },
        },
        menu = {
            border = "none",
            winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,BlinkCmpLabelMatch:Search",
            draw = {
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = require("colorful-menu").blink_components_text,
                        highlight = require("colorful-menu").blink_components_highlight,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            window = { winhighlight = "FloatBorder:FloatBorder" },
        },
    },
    sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        providers = {
            buffer = {
                name = "Buffer",
                module = "blink.cmp.sources.buffer",
                max_items = 3,
            },
            snippets = {
                name = "Snippets",
                module = "blink.cmp.sources.snippets",
                should_show_items = function(ctx)
                    local line = ctx.line
                    local col = ctx.cursor[2]

                    if col == 0 then
                        return true
                    end

                    local char_before = line:sub(col, col)
                    return char_before:match("%s") ~= nil
                end,
            },
        },
    },
})
