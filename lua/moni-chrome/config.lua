local M = {}

M.defaults = {
  transparent = false,
  dim_inactive_windows = true,
  on_colors = nil,
  on_highlights = nil,
}

local options

local validators = {
  transparent = "boolean",
  dim_inactive_windows = "boolean",
  on_colors = "function",
  on_highlights = "function",
}

function M.resolve(opts)
  if opts ~= nil and type(opts) ~= "table" then
    error("moni-chrome: options must be a table or nil")
  end

  for key, value in pairs(opts or {}) do
    local expected = validators[key]
    if not expected then
      error("moni-chrome: unknown option '" .. key .. "'")
    end
    if value ~= nil and type(value) ~= expected then
      error("moni-chrome: option '" .. key .. "' must be a " .. expected)
    end
  end

  return vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

function M.setup(opts)
  options = M.resolve(opts)
  return options
end

function M.get()
  return options or M.resolve()
end

return M
