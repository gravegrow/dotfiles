local bordered_overlay = function(display, hl, pattern)
  pattern = pattern or ("%f[%w]()" .. display .. "()%f[%W]")
  local hl_border = hl .. "Border"

  return {
    [display .. "Borders"] = {
      pattern = pattern,
      group = hl_border,
      extmark_opts = function(_, _, info)
        return {
          virt_text = { { "" .. display .. "", hl_border } },
          virt_text_pos = "overlay",
          virt_text_win_col = info.from_col - 2,
          priority = 200,
        }
      end,
    },
    [display] = {
      pattern = pattern,
      group = hl,
      extmark_opts = function(_, _, info)
        return {
          virt_text = { { display, hl } },
          virt_text_pos = "overlay",
          virt_text_win_col = info.from_col - 1,
          priority = 201,
        }
      end,
    },
  }
end

local highlighters = {}

local bordered_overlays = {
  bordered_overlay("FIX", "MiniHipatternsFixme"),
  bordered_overlay("HACK", "MiniHipatternsHack"),
  bordered_overlay("TODO", "MiniHipatternsTodo"),
  bordered_overlay("NOTE", "MiniHipatternsNote"),
}

for _, v in ipairs(bordered_overlays) do
  highlighters = vim.tbl_extend("force", highlighters, v)
end

return {
  "mini.nvim",
  opts = {
    hipatterns = {
      highlighters = highlighters,
    },
  },
}
