---@type table<string, function>
local roslyn_handlers = {
    -- this means that `dotnet restore` has to be ran on the project/solution
    -- we can do that manually or, better, request the Roslyn LS instance to do it
    -- for us using the "workspace/_roslyn_restore" request which invokes the
    -- `dotnet restore <PATH-TO-SLN>` cmd
    ["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

        ---@diagnostic disable-next-line: param-type-mismatch
        client:request("workspace/_roslyn_restore", result, function(err, response)
            if err then
                vim.notify(err.message, vim.log.levels.ERROR)
            end
            if response then
                local log_lvl = vim.log.levels.INFO
                local t = {}
                for _, v in ipairs(response) do
                    t[#t + 1] = v.message
                    -- an error could be reported in the message string, if found then
                    -- change the log level accordingly
                    if string.find(v.message, "error%s*MSB%d%d%d%d") then
                        log_lvl = vim.log.levels.WARN
                    end
                end
                -- TODO: improve dotnet restore notification message
                -- bombard the user with a shitton of `dotnet restore` messages - this
                -- is actually better than remaining silent since this is only expected
                -- to run once
                vim.notify(table.concat(t, "\n"), log_lvl)
            end
        end)

        return vim.NIL
    end,
}

return {
    handlers = roslyn_handlers,
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
        },
        ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
        },
        ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
            dotnet_provide_regex_completions = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
        },
    },
}
