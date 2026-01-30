return {
    "saghen/blink.cmp",
    dependencies = {
        "xzbdmw/colorful-menu.nvim",
        "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ["<C-L>"] = { "snippet_forward", "fallback" },
            ["<C-H>"] = { "snippet_backward", "fallback" },
            ["<C-U>"] = { "scroll_documentation_up", "fallback" },
            ["<C-D>"] = { "scroll_documentation_down", "fallback" },
            ["<C-A>"] = { "show_signature", "hide_signature" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        cmdline = {
            keymap = { preset = "inherit" },
            completion = {
                menu = { auto_show = true },
            },
        },
        signature = { enabled = true },
        completion = {
            keyword = {
                range = "full",
            },
            documentation = { auto_show = false },
            menu = {
                border = "none",
                draw = {
                    -- padding = { 0, 1 },
                    components = {
                        -- kind_icon = {
                        --     text = function(ctx)
                        --         return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                        --     end,
                        -- },
                        label = {
                            width = { fill = true, min = 35, max = 60 },
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                buffer = {
                    max_items = 3,
                    min_keyword_length = 4,
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
