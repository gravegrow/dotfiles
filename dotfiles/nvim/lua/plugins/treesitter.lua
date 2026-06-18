return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local languages = {
            "bash",
            "lua",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline",
            "python",
            "c_sharp",
            "ron",
        }

        local isnt_installed = function(lang)
            return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
        end

        local to_install = vim.tbl_filter(isnt_installed, languages)
        if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
        end
        local filetypes = {}
        for _, lang in ipairs(languages) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                table.insert(filetypes, ft)
            end
        end

        local ts_start = function(ev)
            vim.treesitter.start(ev.buf)
        end

        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("treesitter-group", { clear = true }),
            pattern = filetypes,
            callback = ts_start,
            desc = "Start treesitter",
        })
    end,
}
