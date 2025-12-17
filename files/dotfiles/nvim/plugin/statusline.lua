function icon()
    local icon = ""
    local hl = "Keyword"
    _, icon, hl, _ = pcall(_G.MiniIcons.get, "file", vim.fn.expand("%:p"))
    return string.format("%s%s# %s ", "%#", hl, icon)
end

local symbols = {
    modified = "[+]",
    readonly = "[-]",
    unnamed = "[No Name]",
    newfile = "[New]",
}

local function is_new_file()
    local filename = vim.fn.expand("%")
    return filename ~= ""
        and filename:match("^%a+://") == nil
        and vim.bo.buftype == ""
        and vim.fn.filereadable(filename) == 0
end

local function filename(hl)
    hl = hl or "Comment"
    local data = vim.fn.expand("%:~:.")
    if data == "" then
        data = symbols.unnamed
    end

    local file_status = {}
    if vim.bo.modified then
        table.insert(file_status, symbols.modified)
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        table.insert(file_status, symbols.readonly)
    end

    if is_new_file() then
        table.insert(file_status, symbols.newfile)
    end

    return "%#" .. hl .. "# " .. data .. (#file_status > 0 and " " .. table.concat(file_status, "") or "")
end

local function lsp(hl)
    hl = hl or "Keyword"
    local client = "%#" .. hl .. "#"
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if next(clients) ~= nil then
        for _, c in ipairs(clients) do
            client = client .. c.name:gsub("_", "-")
            break
        end
    end

    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#DiagnosticSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#DiagnosticSignWarn# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#DiagnosticSignHint#󰰁 " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#DiagnosticSignInfo# " .. count["info"]
    end

    return client .. errors .. warnings .. hints .. info
end

local function lineinfo(hl)
    hl = hl or "Keyword"
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return "%#" .. hl .. "#" .. " %c:%l | %L %#Comment# "
end

local function fillspace()
    return "%="
end

Statusline = {}

Statusline.active = function()
    return table.concat({
        icon(),
        lsp("StatuslineText"),
        filename(),
        fillspace(),
        lineinfo("StatuslineText"),
    })
end

function Statusline.inactive()
    return table.concat({
        filename(),
    })
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("Statusline", { clear = true }),
    callback = function(buff)
        if buff.file == "" then
            vim.opt_local.statusline = "%#Statusline#"
            return
        end
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "Statusline",
    callback = function(buff)
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})
