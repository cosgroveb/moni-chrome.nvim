local M = {}

function M.load()
  local highlights, colors = require("moni-chrome.theme").build(require("moni-chrome.config").get())

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "moni-chrome"

  for group, spec in pairs(highlights) do
    if type(spec) == "string" then
      spec = { link = spec }
    end
    vim.api.nvim_set_hl(0, group, spec)
  end

  for index, color in ipairs(colors.terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

function M.setup(opts)
  require("moni-chrome.config").setup(opts)
  M.load()
end

return M
