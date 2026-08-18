local moni_chrome = require("moni-chrome")
local config = require("moni-chrome.config")

local core_groups = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle", "ColorColumn", "Conceal", "Cursor",
  "lCursor", "CursorIM", "CursorColumn", "CursorLine", "CursorLineNr", "LineNr", "LineNrAbove",
  "LineNrBelow", "SignColumn", "FoldColumn", "Folded", "Directory", "EndOfBuffer", "NonText",
  "SpecialKey", "Whitespace", "WinSeparator", "VertSplit", "StatusLine", "StatusLineNC", "TabLine",
  "TabLineFill", "TabLineSel", "WinBar", "WinBarNC", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
  "PmenuMatch", "PmenuMatchSel", "WildMenu", "Visual", "VisualNOS", "Search", "IncSearch", "CurSearch",
  "Substitute", "MatchParen", "QuickFixLine", "Question", "MoreMsg", "ModeMsg", "MsgArea", "MsgSeparator",
  "ErrorMsg", "WarningMsg", "Title", "Bold", "Italic", "Underlined", "Ignore", "Error", "Todo", "SpellBad",
  "SpellCap", "SpellLocal", "SpellRare",
}

local plugin_groups = {
  "GitSignsAdd", "GitSignsChange", "GitSignsDelete", "GitSignsAddNr", "GitSignsChangeNr", "GitSignsDeleteNr",
  "GitSignsAddLn", "GitSignsChangeLn", "GitSignsDeleteLn", "GitSignsCurrentLineBlame", "GitSignsAddInline",
  "GitSignsChangeInline", "GitSignsDeleteInline", "GitSignsStagedAdd", "GitSignsStagedChange", "GitSignsStagedDelete",
  "TelescopeNormal", "TelescopeBorder", "TelescopeTitle", "TelescopePromptNormal", "TelescopePromptBorder",
  "TelescopePromptTitle", "TelescopePromptPrefix", "TelescopePromptCounter", "TelescopeResultsNormal",
  "TelescopeResultsBorder", "TelescopeResultsTitle", "TelescopePreviewNormal", "TelescopePreviewBorder",
  "TelescopePreviewTitle", "TelescopeSelection", "TelescopeSelectionCaret", "TelescopeMultiSelection", "TelescopeMatching",
  "CmpItemAbbr", "CmpItemAbbrDeprecated", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy", "CmpItemMenu", "CmpItemKind",
  "WhichKey", "WhichKeyGroup", "WhichKeyDesc", "WhichKeySeparator", "WhichKeySeperator", "WhichKeyFloat",
  "WhichKeyBorder", "WhichKeyValue", "WhichKeyIcon", "WhichKeyTitle", "WhichKeyFloatTitle", "WhichKeyNormal",
  "WhichKeyNormalNC", "WhichKeyWin", "FlashBackdrop", "FlashCurrent", "FlashLabel", "FlashMatch", "FlashPrompt",
  "FlashPromptIcon", "TreesitterContext", "TreesitterContextBottom", "TreesitterContextLineNumber",
  "TreesitterContextLineNumberBottom", "TreesitterContextSeparator",
}

for _, kind in ipairs({
  "Text", "Method", "Function", "Constructor", "Field", "Variable", "Class", "Interface", "Module", "Property",
  "Unit", "Value", "Enum", "Keyword", "Snippet", "Color", "File", "Reference", "Folder", "EnumMember", "Constant",
  "Struct", "Event", "Operator", "TypeParameter",
}) do
  plugin_groups[#plugin_groups + 1] = "CmpItemKind" .. kind
end

for _, name in ipairs({
  "NoiceCmdline", "NoiceCmdlineIcon", "NoiceCmdlineIconSearch", "NoiceCmdlinePopup", "NoiceCmdlinePopupBorder",
  "NoiceCmdlinePopupBorderSearch", "NoiceCmdlinePopupTitle", "NoiceConfirm", "NoiceConfirmBorder", "NoiceMini",
  "NoiceFormatConfirm", "NoiceFormatConfirmDefault", "NoiceFormatDate", "NoiceFormatEvent", "NoiceFormatKind",
  "NoiceFormatLevelDebug", "NoiceFormatLevelError", "NoiceFormatLevelInfo", "NoiceFormatLevelOff",
  "NoiceFormatLevelTrace", "NoiceFormatLevelWarn", "NoiceFormatProgressDone", "NoiceFormatProgressTodo", "NoiceFormatTitle",
  "NoiceLspProgressClient", "NoiceLspProgressSpinner", "NoiceLspProgressTitle", "NoiceVirtualText",
}) do
  plugin_groups[#plugin_groups + 1] = name
end

local treesitter_groups = {
  "@annotation", "@attribute", "@attribute.builtin", "@boolean", "@character", "@character.printf",
  "@character.special", "@comment", "@comment.documentation", "@comment.error", "@comment.warning", "@comment.todo",
  "@comment.note", "@comment.info", "@constant", "@constant.builtin", "@constant.macro", "@variable",
  "@variable.builtin", "@variable.parameter", "@variable.parameter.builtin", "@module", "@module.builtin", "@label",
  "@string", "@string.documentation", "@string.regexp", "@string.escape", "@string.special", "@number", "@number.float",
  "@type", "@type.builtin", "@type.definition", "@type.qualifier", "@property", "@function", "@function.builtin",
  "@function.call", "@function.macro", "@function.method", "@function.method.call", "@constructor", "@operator", "@keyword",
  "@keyword.conditional", "@keyword.coroutine", "@keyword.debug", "@keyword.directive", "@keyword.directive.define",
  "@keyword.exception", "@keyword.function", "@keyword.import", "@keyword.operator", "@keyword.repeat", "@keyword.return",
  "@keyword.storage", "@punctuation.bracket", "@punctuation.delimiter", "@punctuation.special", "@tag", "@tag.attribute",
  "@tag.builtin", "@tag.delimiter", "@diff.plus", "@diff.minus", "@diff.delta", "@markup.emphasis",
  "@markup.environment", "@markup.environment.name", "@markup.heading", "@markup.heading.1", "@markup.heading.2",
  "@markup.heading.3", "@markup.heading.4", "@markup.heading.5", "@markup.heading.6", "@markup.italic", "@markup.link",
  "@markup.link.label", "@markup.link.url", "@markup.list", "@markup.list.checked", "@markup.list.unchecked", "@markup.math",
  "@markup.raw", "@markup.raw.block", "@markup.raw.markdown_inline", "@markup.strikethrough", "@markup.strong", "@markup.underline",
}

local lsp_groups = {
  "@lsp.type.boolean", "@lsp.type.builtinType", "@lsp.type.class", "@lsp.type.comment", "@lsp.type.decorator",
  "@lsp.type.enum", "@lsp.type.enumMember", "@lsp.type.escapeSequence", "@lsp.type.event", "@lsp.type.formatSpecifier",
  "@lsp.type.function", "@lsp.type.generic", "@lsp.type.interface", "@lsp.type.keyword", "@lsp.type.lifetime",
  "@lsp.type.macro", "@lsp.type.method", "@lsp.type.modifier", "@lsp.type.namespace", "@lsp.type.number",
  "@lsp.type.operator", "@lsp.type.parameter", "@lsp.type.property", "@lsp.type.regexp", "@lsp.type.selfKeyword",
  "@lsp.type.selfTypeKeyword", "@lsp.type.string", "@lsp.type.struct", "@lsp.type.type", "@lsp.type.typeAlias",
  "@lsp.type.typeParameter", "@lsp.type.variable", "@lsp.type.unresolvedReference",
  "@lsp.typemod.class.defaultLibrary", "@lsp.typemod.enum.defaultLibrary", "@lsp.typemod.enumMember.defaultLibrary",
  "@lsp.typemod.function.defaultLibrary", "@lsp.typemod.interface.defaultLibrary", "@lsp.typemod.macro.defaultLibrary",
  "@lsp.typemod.method.defaultLibrary", "@lsp.typemod.struct.defaultLibrary", "@lsp.typemod.type.defaultLibrary",
  "@lsp.typemod.typeParameter.defaultLibrary", "@lsp.typemod.variable.defaultLibrary", "@lsp.typemod.keyword.async",
  "@lsp.typemod.keyword.injected", "@lsp.typemod.operator.injected", "@lsp.typemod.string.injected",
  "@lsp.typemod.variable.injected", "@lsp.typemod.variable.callable", "@lsp.typemod.variable.static",
  "@lsp.typemod.parameter.declaration", "@lsp.typemod.parameter.definition", "@lsp.typemod.parameter.readonly",
  "@lsp.typemod.variable.declaration", "@lsp.typemod.variable.definition", "@lsp.typemod.variable.readonly",
}

local compatibility_groups = {
  "@boolean.lua", "@comment.gitcommit", "@comment.hint", "@constant.lua", "@keyword.gitcommit",
  "@keyword.operator.lua", "@lsp.type.deriveHelper", "@lsp.type.namespace.python", "@lsp.type.parameter.lua",
  "@lsp.typemod.function.defaultLibrary.lua", "@lsp.typemod.parameter.declaration.lua", "@markup",
  "@markup.heading.1.markdown", "@markup.heading.2.markdown", "@markup.heading.3.markdown",
  "@markup.heading.4.markdown", "@markup.heading.5.markdown", "@markup.heading.6.markdown",
  "@markup.heading.gitcommit", "@markup.link.label.symbol", "@markup.list.markdown", "@namespace",
  "@namespace.builtin", "@none", "@parameter", "@preproc", "@punctuation.special.markdown",
  "@string.gitcommit", "@string.special.symbol", "@string.special.url", "@type.ruby",
  "@variable.parameter.lua", "CopilotAnnotation", "CopilotSuggestion", "DropBarCurrentContext",
  "DropBarCurrentContextName", "DropBarIconKindFolderNC", "DropBarIconUIPickPivot",
  "DropBarIconUISeparator", "DropBarIconUISeparatorMenu", "DropBarIconUISeparatorNC",
  "DropBarMenuFloatBorder", "DropBarMenuHoverEntry", "DropBarMenuHoverIcon", "DropBarMenuHoverSymbol",
  "LspReferenceRead", "LspReferenceText", "LspReferenceWrite", "WhichKeyFloatBorder", "WhichKeyFloatNC",
  "WhichKeyIconAzure", "WhichKeyIconBlue", "WhichKeyIconCyan", "WhichKeyIconGreen", "WhichKeyIconGrey",
  "WhichKeyIconOrange", "WhichKeyIconPurple", "WhichKeyIconRed", "WhichKeyIconYellow", "gitcommitBranch",
  "gitcommitComment", "gitcommitDiscarded", "gitcommitDiscardedFile", "gitcommitDiscardedType",
  "gitcommitFirst", "gitcommitHeader", "gitcommitNoBranch", "gitcommitOnBranch", "gitcommitOverflow",
  "gitcommitSelected", "gitcommitSelectedFile", "gitcommitSelectedType", "gitcommitSummary",
  "gitcommitUnmerged", "gitcommitUnmergedFile", "gitcommitUnmergedType", "gitcommitUntracked",
  "gitcommitUntrackedFile", "rubyInterpolation", "rubyPseudoVariable", "rubyStringDelimiter", "rubySymbol",
}

describe("highlight composition", function()
  it("defines every supported highlight group", function()
    local colors = require("moni-chrome.colors").get({})
    local groups = require("moni-chrome.groups").get(colors, config.resolve())
    for _, family in ipairs({ core_groups, plugin_groups, treesitter_groups, lsp_groups, compatibility_groups }) do
      for _, group in ipairs(family) do
        assert(groups[group] ~= nil, "missing highlight group " .. group)
      end
    end
  end)

  it("builds exact representative highlight specs", function()
    local colors = require("moni-chrome.colors").get({})
    local groups = require("moni-chrome.groups").get(colors, config.resolve())
    eq({ fg = "#f08a22", bg = "#170e04", underline = true }, groups.DiffAdd)
    eq({ fg = "#ffb156", bg = "#3c250b", bold = true }, groups.DiffText)
    eq({ fg = "#ffb156", bold = true }, groups["@function.builtin"])
    eq("String", groups["@string"])
    eq("@function", groups["@lsp.type.function"])
    eq({ fg = "#ffb156", undercurl = true, sp = "#ffb156" }, groups["@lsp.type.unresolvedReference"])
    eq({ link = "Added" }, groups.GitSignsAdd)
    eq({ fg = "#ffb156", bg = "#3c250b", bold = true }, groups.TelescopeSelection)
    eq({ fg = "#ffb156", bold = true }, groups.CmpItemAbbrMatch)
    eq("DiagnosticError", groups.NoiceFormatLevelError)
    eq({ fg = "#050301", bg = "#ffb156", bold = true }, groups.FlashLabel)
    eq({ bg = "#0a0602" }, groups.TreesitterContext)
    eq({ link = "Special" }, groups.rubySymbol)
    eq({ bg = "#3c250b", bold = true }, groups.LspReferenceWrite)
    eq({ fg = "#ffb156", bold = true, underline = true }, groups.gitcommitSummary)
    eq({ fg = "#794110", italic = true }, groups.CopilotSuggestion)
    eq({ bg = "#281907" }, groups.DropBarMenuHoverEntry)
    eq("WhichKeyIcon", groups.WhichKeyIconRed)
    eq("@markup.heading.3", groups["@markup.heading.3.markdown"])
    eq({}, groups["@none"])
    eq("gitcommitComment", groups["@comment.gitcommit"])
    eq("@variable.parameter.lua", groups["@lsp.typemod.parameter.declaration.lua"])
  end)
end)

describe("runtime loader", function()
  before_each(function()
    config.setup({})
  end)

  it("loads through the public setup function", function()
    moni_chrome.setup(nil)
    eq("moni-chrome", vim.g.colors_name)
    eq("dark", vim.o.background)
    eq(true, vim.o.termguicolors)
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    eq(0xff9e2c, normal.fg)
    eq(0x050301, normal.bg)
    local diagnostic = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderlineError" })
    eq(true, diagnostic.undercurl)
    eq(0xffb156, diagnostic.sp)
  end)

  it("applies exact representative highlight specs", function()
    moni_chrome.setup({})
    eq({
      bg = 0x170e04,
      cterm = { underline = true },
      fg = 0xf08a22,
      underline = true,
    }, vim.api.nvim_get_hl(0, { name = "DiffAdd", link = true }))
    eq({
      bg = 0x3c250b,
      bold = true,
      cterm = { bold = true },
      fg = 0xffb156,
    }, vim.api.nvim_get_hl(0, { name = "DiffText", link = true }))
    eq({
      bold = true,
      cterm = { bold = true },
      fg = 0xffb156,
    }, vim.api.nvim_get_hl(0, { name = "@function.builtin", link = true }))
    eq({ link = "String" }, vim.api.nvim_get_hl(0, { name = "@string", link = true }))
    eq({ link = "@function" }, vim.api.nvim_get_hl(0, { name = "@lsp.type.function", link = true }))
    eq({
      cterm = { undercurl = true },
      fg = 0xffb156,
      sp = 0xffb156,
      undercurl = true,
    }, vim.api.nvim_get_hl(0, { name = "@lsp.type.unresolvedReference", link = true }))
    eq({ link = "Added" }, vim.api.nvim_get_hl(0, { name = "GitSignsAdd", link = true }))
    eq({
      bg = 0x3c250b,
      bold = true,
      cterm = { bold = true },
      fg = 0xffb156,
    }, vim.api.nvim_get_hl(0, { name = "TelescopeSelection", link = true }))
    eq({
      bold = true,
      cterm = { bold = true },
      fg = 0xffb156,
    }, vim.api.nvim_get_hl(0, { name = "CmpItemAbbrMatch", link = true }))
    eq({ link = "DiagnosticError" }, vim.api.nvim_get_hl(0, { name = "NoiceFormatLevelError", link = true }))
    eq({
      bg = 0xffb156,
      bold = true,
      cterm = { bold = true },
      fg = 0x050301,
    }, vim.api.nvim_get_hl(0, { name = "FlashLabel", link = true }))
    eq({ bg = 0x0a0602 }, vim.api.nvim_get_hl(0, { name = "TreesitterContext", link = true }))
    eq({ link = "Special" }, vim.api.nvim_get_hl(0, { name = "rubySymbol", link = true }))
    eq({
      bg = 0x3c250b,
      bold = true,
      cterm = { bold = true },
    }, vim.api.nvim_get_hl(0, { name = "LspReferenceWrite", link = true }))
    eq({
      bold = true,
      cterm = { bold = true, underline = true },
      fg = 0xffb156,
      underline = true,
    }, vim.api.nvim_get_hl(0, { name = "gitcommitSummary", link = true }))
    eq({
      cterm = { italic = true },
      fg = 0x794110,
      italic = true,
    }, vim.api.nvim_get_hl(0, { name = "CopilotSuggestion", link = true }))
    eq({ bg = 0x281907 }, vim.api.nvim_get_hl(0, { name = "DropBarMenuHoverEntry", link = true }))
    eq({ link = "WhichKeyIcon" }, vim.api.nvim_get_hl(0, { name = "WhichKeyIconRed", link = true }))
    eq({ link = "@markup.heading.3" }, vim.api.nvim_get_hl(0, { name = "@markup.heading.3.markdown", link = true }))
    eq({}, vim.api.nvim_get_hl(0, { name = "@none", link = true }))
    eq({ link = "gitcommitComment" }, vim.api.nvim_get_hl(0, { name = "@comment.gitcommit", link = true }))
    eq({ link = "@variable.parameter.lua" }, vim.api.nvim_get_hl(0, {
      name = "@lsp.typemod.parameter.declaration.lua",
      link = true,
    }))
  end)

  it("assigns all ANSI terminal colors", function()
    moni_chrome.setup({})
    local expected = {
      "#050301", "#b85d14", "#c66a1a", "#f08a22", "#794110", "#b85d14", "#c66a1a", "#ff9e2c",
      "#794110", "#c66a1a", "#f08a22", "#ff9e2c", "#b85d14", "#c66a1a", "#f08a22", "#ffb156",
    }
    for index, color in ipairs(expected) do
      eq(color, vim.g["terminal_color_" .. (index - 1)])
    end
  end)

  it("loads through the colorscheme command", function()
    vim.cmd.colorscheme("moni-chrome")
    eq("moni-chrome", vim.g.colors_name)
  end)

  it("keeps window backgrounds transparent", function()
    moni_chrome.setup({ transparent = true })
    for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "FoldColumn", "StatusLine", "WinBar" }) do
      local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
      assert(highlight.bg == nil, group .. " should have no background")
    end
  end)

  it("passes the built palette to Lualine without another callback", function()
    assert(package.loaded["lualine.themes.moni-chrome"] == nil)
    local calls = 0
    moni_chrome.setup({
      on_colors = function(colors)
        calls = calls + 1
        colors.phosphor = "#abcdef"
      end,
    })
    local lualine = require("lualine.themes.moni-chrome")
    eq(1, calls)
    eq({
      normal = {
        a = { fg = "#050301", bg = "#abcdef", gui = "bold" },
        b = { fg = "#abcdef", bg = "#281907" },
        c = { fg = "#abcdef", bg = "#0a0602" },
      },
      insert = {
        a = { fg = "#050301", bg = "#f08a22", gui = "bold" },
        b = { fg = "#f08a22", bg = "#281907" },
      },
      command = {
        a = { fg = "#050301", bg = "#ffb156", gui = "bold" },
        b = { fg = "#ffb156", bg = "#281907" },
      },
      visual = {
        a = { fg = "#050301", bg = "#c66a1a", gui = "bold" },
        b = { fg = "#c66a1a", bg = "#281907" },
      },
      replace = {
        a = { fg = "#050301", bg = "#b85d14", gui = "bold" },
        b = { fg = "#b85d14", bg = "#281907" },
      },
      terminal = {
        a = { fg = "#050301", bg = "#ffb156", gui = "bold" },
        b = { fg = "#ffb156", bg = "#281907" },
      },
      inactive = {
        a = { fg = "#794110", bg = "#0a0602" },
        b = { fg = "#794110", bg = "#0a0602" },
        c = { fg = "#794110", bg = "#0a0602" },
      },
    }, lualine)
  end)
end)
