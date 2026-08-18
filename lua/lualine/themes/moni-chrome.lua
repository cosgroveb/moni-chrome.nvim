local c = require("moni-chrome.theme").get_colors()

local function mode(accent)
  return {
    a = { fg = c.screen_solid, bg = accent, gui = "bold" },
    b = { fg = accent, bg = c.glow_medium },
  }
end

local theme = {
  normal = mode(c.phosphor),
  insert = mode(c.phosphor_soft),
  command = mode(c.phosphor_bright),
  visual = mode(c.phosphor_dim),
  replace = mode(c.phosphor_faint),
  terminal = mode(c.phosphor_bright),
  inactive = {
    a = { fg = c.phosphor_ghost, bg = c.screen_lifted },
    b = { fg = c.phosphor_ghost, bg = c.screen_lifted },
    c = { fg = c.phosphor_ghost, bg = c.screen_lifted },
  },
}

theme.normal.c = { fg = c.phosphor, bg = c.screen_lifted }

return theme
