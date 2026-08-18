local colors_module = require("moni-chrome.colors")
local config = require("moni-chrome.config")

describe("palette", function()
  it("defines the CRT palette keys", function()
    local colors = colors_module.get({})
    eq({
      screen = "#050301",
      screen_lifted = "#0a0602",
      screen_solid = "#050301",
      screen_lifted_solid = "#0a0602",
      phosphor = "#ff9e2c",
      phosphor_soft = "#f08a22",
      phosphor_dim = "#c66a1a",
      phosphor_faint = "#b85d14",
      phosphor_bright = "#ffb156",
      phosphor_ghost = "#794110",
      glow_low = "#170e04",
      glow_medium = "#281907",
      glow_high = "#3c250b",
      none = "NONE",
    }, colors)

    for _, key in ipairs({
      "bg", "bg_soft", "bg_solid", "bg_soft_solid", "ink", "ink_soft", "ink_dim", "line",
      "ink_bright", "ink_muted", "surface_1", "surface_2", "surface_3", "canonical",
    }) do
      assert(colors[key] == nil, key .. " should not be exposed")
    end
  end)

  it("contains only valid color values", function()
    local colors = colors_module.get({})
    for key, value in pairs(colors) do
      if type(value) == "string" then
        assert(value == "NONE" or value:match("^#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$"), key)
      end
    end
  end)

  it("preserves solid anchors when transparent", function()
    local colors = colors_module.get({ transparent = true })
    eq("NONE", colors.screen)
    eq("NONE", colors.screen_lifted)
    eq("#050301", colors.screen_solid)
    eq("#0a0602", colors.screen_lifted_solid)
  end)
end)

describe("configuration", function()
  it("resolves fresh defaults", function()
    local first = config.resolve()
    local second = config.resolve(nil)
    eq(false, first.transparent)
    eq(true, first.dim_inactive_windows)
    assert(first ~= second)
  end)

  it("rejects invalid options", function()
    raises("options must be a table", function()
      config.resolve(true)
    end)
    raises("unknown option 'style'", function()
      config.resolve({ style = "retro" })
    end)
    raises("option 'transparent' must be a boolean", function()
      config.resolve({ transparent = "yes" })
    end)
    raises("option 'on_colors' must be a function", function()
      config.resolve({ on_colors = true })
    end)
  end)
end)

describe("theme composition", function()
  it("invokes callbacks once and uses their mutations", function()
    local color_calls = 0
    local highlight_calls = 0
    local opts = config.resolve({
      on_colors = function(colors)
        color_calls = color_calls + 1
        colors.phosphor = "#abcdef"
      end,
      on_highlights = function(highlights, colors)
        highlight_calls = highlight_calls + 1
        highlights.Comment = { fg = colors.phosphor, bold = true }
      end,
    })
    local highlights, colors = require("moni-chrome.theme").build(opts)
    eq(1, color_calls)
    eq(1, highlight_calls)
    eq("#abcdef", colors.phosphor)
    eq("#abcdef", colors.terminal[8])
    eq("#abcdef", colors.terminal[12])
    eq({ fg = "#abcdef", bold = true }, highlights.Comment)
  end)
end)
