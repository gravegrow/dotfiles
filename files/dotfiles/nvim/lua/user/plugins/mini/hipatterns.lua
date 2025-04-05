return {
  "mini.nvim",
  config = function()
    local bordered_overlay = function(display, group, pattern)
      pattern = pattern or ("%f[%w]()" .. display .. "()%f[%W]")

      local hl = vim.api.nvim_get_hl(0, { name = group })
      local group_inv = group .. "Reverse"
      vim.api.nvim_set_hl(0, group_inv, { bg = hl.bg, fg = hl.fg, reverse = true })

      return {
        [display .. "Borders"] = {
          pattern = pattern,
          group = group_inv,
          extmark_opts = function(_, _, info)
            return {
              virt_text = { { "" .. display .. "", group_inv } },
              virt_text_pos = "overlay",
              virt_text_win_col = info.from_col - 2,
              priority = 200,
            }
          end,
        },
        [display] = {
          pattern = pattern,
          group = group,
          extmark_opts = function(_, _, info)
            return {
              virt_text = { { display, group } },
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

    require("mini.hipatterns").setup({
      highlighters = highlighters,
    })
  end,
}
