local M = {}

local function merge(target, source)
  for group, spec in pairs(source) do
    target[group] = spec
  end
end

function M.get(colors, opts)
  local groups = {}
  merge(groups, require("moni-chrome.groups.base").get(colors, opts))
  merge(groups, require("moni-chrome.groups.treesitter").get(colors, opts))
  merge(groups, require("moni-chrome.groups.lsp").get(colors, opts))
  return groups
end

return M
