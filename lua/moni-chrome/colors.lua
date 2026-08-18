local M = {}

local base = {
  screen = "#050301",
  screen_lifted = "#0a0602",
  phosphor = "#ff9e2c",
  phosphor_soft = "#f08a22",
  phosphor_dim = "#c66a1a",
  phosphor_faint = "#b85d14",
}

local derived = {
  phosphor_bright = "#ffb156",
  phosphor_ghost = "#794110",
  glow_low = "#170e04",
  glow_medium = "#281907",
  glow_high = "#3c250b",
  none = "NONE",
}

function M.get(opts)
  opts = opts or {}
  local colors = vim.tbl_deep_extend("force", {}, base, derived)
  colors.screen_solid = base.screen
  colors.screen_lifted_solid = base.screen_lifted

  if opts.transparent then
    colors.screen = colors.none
    colors.screen_lifted = colors.none
  end

  return colors
end

function M.terminal(colors)
  return {
    colors.screen_solid,
    colors.phosphor_faint,
    colors.phosphor_dim,
    colors.phosphor_soft,
    colors.phosphor_ghost,
    colors.phosphor_faint,
    colors.phosphor_dim,
    colors.phosphor,
    colors.phosphor_ghost,
    colors.phosphor_dim,
    colors.phosphor_soft,
    colors.phosphor,
    colors.phosphor_faint,
    colors.phosphor_dim,
    colors.phosphor_soft,
    colors.phosphor_bright,
  }
end

return M
