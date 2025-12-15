return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        "xzbdmw/colorful-menu.nvim",
        "rafamadriz/friendly-snippets",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
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

        cmdline = { completion = { menu = { auto_show = true } } },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = false },
            menu = {
                border = "none",
                draw = {
                    padding = { 0, 1 },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                            end,
                        },
                        label = {
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
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
