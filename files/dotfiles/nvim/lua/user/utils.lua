function P(item)
  print(vim.inspect(item))
end

local hex = function(n)
  return string.format("#%06x", n)
end

local get_hl = function(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name })
  if vim.tbl_isempty(hl) then
    hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  end
  return hl
end

vim.g.get_fg = function(hl_name)
  return hex(get_hl(hl_name).fg or get_hl("Normal").fg)
end

vim.g.get_bg = function(hl_name)
  return hex(get_hl(hl_name).bg or get_hl("Normal").bg)
end
