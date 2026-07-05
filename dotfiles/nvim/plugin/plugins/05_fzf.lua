local keymap = vim.keymap.set

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
local fzf = require("fzf-lua")
fzf.setup({
    "telescope",
    fzf_opts = {
        ["--layout"] = "reverse",
    },
    defaults = {
        cwd_prompt = false,
        formatter = "path.filename_first",
    },
    file_ignore_patterns = {
        -- 2. Metadata files and target scripts
        "%.meta$", -- Unity's internal tracker assets
        "%.asset$", -- ScriptableObjects/Scenes (keep if you edit raw YAML, remove if not)
        "%.inputactions$",
        "%.unity$",
        "%.nuspec$",
        "%.asmdef$",

        -- 3. Audio & Video formats
        "%.mp3$",
        "%.wav$",
        "%.ogg$",
        "%.flac$",
        "%.aif$",
        "%.aiff$",
        "%.mp4$",
        "%.mov$",
        "%.avi$",
        "%.mkv$",

        -- 4. 3D Meshes, Animation rigs, and Sprites
        "%.fbx$",
        "%.obj$",
        "%.max$",
        "%.blend$",
        "%.blend1$",
        "%.png$",
        "%.jpg$",
        "%.jpeg$",
        "%.tga$",
        "%.psd$",
        "%.tiff$",
        "%.exr$",

        -- 5. Package Management & Compiler locks
        "%.dll$",
        "%.pdb$",
        "%.mdb$",
    },
    winopts = { backdrop = 100 },
    lsp = {
        code_actions = {
            previewer = false,
            winopts = { height = 0.40, width = 0.80 },
        },
    },
    undotree = {
        winopts = {
            fullscreen = true,
            preview = {
                layout = "horizontal",
            },
        },
    },
})

fzf.register_ui_select()

keymap("n", "<leader>ff", function()
    fzf.files({ hidden = false })
end, { desc = "Files" })

keymap("n", "<leader>fF", function()
    fzf.files({
        hidden = true,
        file_ignore_patterns = {},
        actions = {
            ["ctrl-g"] = { require("fzf-lua").actions.toggle_ignore },
        },
    })
end, { desc = "Files with Hidden" })

keymap("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
keymap("n", "<leader>f/", fzf.live_grep, { desc = "Grep" })
keymap("n", "<leader>fu", fzf.undotree, { desc = "Undootree" })
keymap("n", "<leader>fd", fzf.diagnostics_document, { desc = "Diagnostics Document" })
keymap("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "Diagnostics Workspace" })
