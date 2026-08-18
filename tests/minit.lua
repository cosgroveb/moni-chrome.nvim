local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fs.dirname(vim.fs.dirname(vim.fs.abspath(source)))
vim.opt.runtimepath:prepend(root)

local failed = 0
local total = 0
local contexts = {}

function describe(name, fn)
  print(name)
  contexts[#contexts + 1] = { before_each = {} }
  local ok, err = pcall(fn)
  contexts[#contexts] = nil
  if not ok then
    error(err)
  end
end

function before_each(fn)
  local context = contexts[#contexts]
  assert(context, "before_each must be called inside describe")
  context.before_each[#context.before_each + 1] = fn
end

function it(name, fn)
  total = total + 1
  local hooks = {}
  for _, context in ipairs(contexts) do
    for _, hook in ipairs(context.before_each) do
      hooks[#hooks + 1] = hook
    end
  end

  local ok, err = pcall(function()
    for _, hook in ipairs(hooks) do
      hook()
    end
    fn()
  end)
  if not ok then
    failed = failed + 1
    print("FAIL: " .. name .. " - " .. tostring(err))
  end
end

function eq(expected, actual, message)
  if not vim.deep_equal(expected, actual) then
    error((message or "values differ") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual))
  end
end

function raises(pattern, fn)
  local ok, err = pcall(fn)
  if ok then
    error("expected an error matching " .. pattern)
  end
  if not tostring(err):match(pattern) then
    error("error did not match " .. pattern .. ": " .. tostring(err))
  end
end

dofile(root .. "/tests/colors_spec.lua")
dofile(root .. "/tests/colorscheme_spec.lua")

local function walk(path, files)
  for name, kind in vim.fs.dir(path) do
    local child = path .. "/" .. name
    if kind == "directory" then
      walk(child, files)
    elseif kind == "file" and name:match("%.lua$") then
      files[#files + 1] = child
    end
  end
end

it("has valid clean Lua source files", function()
  local files = {}
  for _, directory in ipairs({ "lua", "colors", "tests" }) do
    walk(root .. "/" .. directory, files)
  end
  table.sort(files)
  for _, path in ipairs(files) do
    local chunk, load_error = loadfile(path)
    assert(chunk, path .. ": " .. tostring(load_error))
    local handle = assert(io.open(path, "rb"))
    local contents = handle:read("*a")
    handle:close()
    assert(contents:sub(-1) == "\n", path .. ": missing final newline")
    assert(not contents:find("\t"), path .. ": contains a tab")
    local line_number = 0
    for line in (contents .. "\n"):gmatch("(.-)\n") do
      line_number = line_number + 1
      assert(not line:find("%s+$"), path .. ":" .. line_number .. ": trailing whitespace")
    end
  end
end)

it("generates help tags from the documentation", function()
  local temporary = vim.fn.tempname()
  local doc = temporary .. "/doc"
  vim.fn.mkdir(doc, "p")
  vim.fn.writefile(vim.fn.readfile(root .. "/doc/moni-chrome.txt"), doc .. "/moni-chrome.txt")
  vim.cmd("helptags " .. vim.fn.fnameescape(doc))
  assert(vim.uv.fs_stat(doc .. "/tags"), "helptags did not create a tags file")
  vim.fn.delete(temporary, "rf")
end)

if failed > 0 then
  print(string.format("%d of %d tests failed", failed, total))
  vim.cmd("cquit 1")
end

print(string.format("%d tests passed", total))
vim.cmd("cquit 0")
