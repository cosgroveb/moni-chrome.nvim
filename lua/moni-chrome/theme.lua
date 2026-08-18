local M = {}

local current_colors

function M.build(opts)
  local colors_module = require("moni-chrome.colors")
  local colors = colors_module.get(opts)

  if opts.on_colors then
    opts.on_colors(colors)
  end

  colors.terminal = colors_module.terminal(colors)
  local highlights = require("moni-chrome.groups").get(colors, opts)

  if opts.on_highlights then
    opts.on_highlights(highlights, colors)
  end

  current_colors = colors
  return highlights, colors
end

function M.get_colors()
  return current_colors or require("moni-chrome.colors").get(require("moni-chrome.config").resolve())
end

return M
