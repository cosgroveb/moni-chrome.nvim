local M = {}

local function link(groups, names, target)
  for _, name in ipairs(names) do
    groups[name] = target
  end
end

function M.get(c, opts)
  local inactive_bg = opts.dim_inactive_windows and c.screen_lifted or c.screen
  local groups = {
    Normal = { fg = c.phosphor, bg = c.screen },
    NormalNC = { fg = c.phosphor_dim, bg = inactive_bg },
    NormalFloat = { fg = c.phosphor, bg = c.screen_lifted },
    FloatBorder = { fg = c.phosphor_faint, bg = c.screen_lifted },
    FloatTitle = { fg = c.phosphor_bright, bg = c.screen_lifted, bold = true },
    ColorColumn = { bg = c.glow_low },
    Conceal = { fg = c.phosphor_ghost },
    Cursor = { fg = c.screen_solid, bg = c.phosphor },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    CursorColumn = { bg = c.glow_low },
    CursorLine = { bg = c.glow_low },
    CursorLineNr = { fg = c.phosphor_bright, bg = c.glow_low, bold = true },
    LineNr = { fg = c.phosphor_ghost },
    LineNrAbove = { fg = c.phosphor_ghost },
    LineNrBelow = { fg = c.phosphor_ghost },
    SignColumn = { fg = c.phosphor_dim, bg = c.screen },
    FoldColumn = { fg = c.phosphor_faint, bg = c.screen },
    Folded = { fg = c.phosphor_dim, bg = c.screen_lifted, italic = true },
    Directory = { fg = c.phosphor_bright, bold = true },
    EndOfBuffer = { fg = c.screen },
    NonText = { fg = c.phosphor_ghost },
    SpecialKey = { fg = c.phosphor_faint },
    Whitespace = { fg = c.phosphor_ghost },
    WinSeparator = { fg = c.phosphor_faint, bg = c.screen },
    VertSplit = { link = "WinSeparator" },
    StatusLine = { fg = c.phosphor, bg = c.screen_lifted },
    StatusLineNC = { fg = c.phosphor_ghost, bg = inactive_bg },
    TabLine = { fg = c.phosphor_dim, bg = c.screen_lifted },
    TabLineFill = { fg = c.phosphor_faint, bg = c.screen_lifted },
    TabLineSel = { fg = c.screen_solid, bg = c.phosphor, bold = true },
    WinBar = { fg = c.phosphor, bg = c.screen },
    WinBarNC = { fg = c.phosphor_ghost, bg = inactive_bg },
    Pmenu = { fg = c.phosphor, bg = c.screen_lifted },
    PmenuSel = { fg = c.phosphor_bright, bg = c.glow_high, bold = true },
    PmenuSbar = { bg = c.glow_low },
    PmenuThumb = { bg = c.phosphor_ghost },
    PmenuMatch = { fg = c.phosphor_bright, bold = true },
    PmenuMatchSel = { fg = c.phosphor_bright, bg = c.glow_high, bold = true },
    WildMenu = { fg = c.screen_solid, bg = c.phosphor, bold = true },
    Visual = { bg = c.glow_high },
    VisualNOS = { bg = c.glow_medium, underline = true },
    Search = { fg = c.screen_solid, bg = c.phosphor_soft },
    IncSearch = { fg = c.screen_solid, bg = c.phosphor_bright, bold = true },
    CurSearch = { fg = c.screen_solid, bg = c.phosphor_bright, bold = true },
    Substitute = { fg = c.screen_solid, bg = c.phosphor_bright },
    MatchParen = { fg = c.phosphor_bright, bg = c.glow_high, bold = true },
    QuickFixLine = { bg = c.glow_medium, bold = true },
    Question = { fg = c.phosphor_bright, bold = true },
    MoreMsg = { fg = c.phosphor_soft },
    ModeMsg = { fg = c.phosphor, bold = true },
    MsgArea = { fg = c.phosphor, bg = c.screen },
    MsgSeparator = { fg = c.phosphor_faint, bg = c.screen },
    ErrorMsg = { fg = c.phosphor_bright, bold = true },
    WarningMsg = { fg = c.phosphor, bold = true },
    Title = { fg = c.phosphor_bright, bold = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Underlined = { fg = c.phosphor_soft, underline = true },
    Ignore = { fg = c.phosphor_ghost },
    Error = { fg = c.phosphor_bright, bold = true, undercurl = true, sp = c.phosphor_bright },
    Todo = { fg = c.screen_solid, bg = c.phosphor, bold = true },
    SpellBad = { undercurl = true, sp = c.phosphor_bright },
    SpellCap = { underdouble = true, sp = c.phosphor },
    SpellLocal = { underline = true, sp = c.phosphor_soft },
    SpellRare = { underdotted = true, sp = c.phosphor_dim },

    Comment = { fg = c.phosphor_dim, italic = true },
    Constant = { fg = c.phosphor },
    String = { fg = c.phosphor_soft },
    Character = { fg = c.phosphor_soft },
    Number = { fg = c.phosphor },
    Boolean = { fg = c.phosphor_bright, bold = true },
    Float = { link = "Number" },
    Identifier = { fg = c.phosphor },
    Function = { fg = c.phosphor_bright },
    Statement = { fg = c.phosphor_soft, bold = true },
    Conditional = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { fg = c.phosphor_soft },
    Operator = { fg = c.phosphor_faint },
    Keyword = { fg = c.phosphor_soft, bold = true },
    Exception = { link = "Keyword" },
    PreProc = { fg = c.phosphor_dim },
    Include = { link = "PreProc" },
    Define = { link = "PreProc" },
    Macro = { fg = c.phosphor_dim, italic = true },
    PreCondit = { link = "PreProc" },
    Type = { fg = c.phosphor_bright },
    StorageClass = { link = "Type" },
    Structure = { link = "Type" },
    Typedef = { link = "Type" },
    Special = { fg = c.phosphor_soft },
    SpecialChar = { fg = c.phosphor_bright },
    Tag = { fg = c.phosphor_soft },
    Delimiter = { fg = c.phosphor_faint },
    SpecialComment = { fg = c.phosphor_dim, bold = true },
    Debug = { fg = c.phosphor_bright, bold = true },
    rubySymbol = { link = "Special" },
    rubyPseudoVariable = { link = "Special" },
    rubyStringDelimiter = { link = "String" },
    rubyInterpolation = { link = "Identifier" },

    DiagnosticError = { fg = c.phosphor_bright, bold = true },
    DiagnosticWarn = { fg = c.phosphor, bold = true },
    DiagnosticInfo = { fg = c.phosphor_soft },
    DiagnosticHint = { fg = c.phosphor_dim },
    DiagnosticOk = { fg = c.phosphor_soft },
    DiagnosticVirtualTextError = { fg = c.phosphor_bright, bg = c.glow_medium },
    DiagnosticVirtualTextWarn = { fg = c.phosphor, bg = c.glow_medium },
    DiagnosticVirtualTextInfo = { fg = c.phosphor_soft, bg = c.glow_low },
    DiagnosticVirtualTextHint = { fg = c.phosphor_dim, bg = c.glow_low },
    DiagnosticSignError = { fg = c.phosphor_bright, bg = c.screen },
    DiagnosticSignWarn = { fg = c.phosphor, bg = c.screen },
    DiagnosticSignInfo = { fg = c.phosphor_soft, bg = c.screen },
    DiagnosticSignHint = { fg = c.phosphor_dim, bg = c.screen },
    DiagnosticUnderlineError = { undercurl = true, sp = c.phosphor_bright },
    DiagnosticUnderlineWarn = { underdouble = true, sp = c.phosphor },
    DiagnosticUnderlineInfo = { underline = true, sp = c.phosphor_soft },
    DiagnosticUnderlineHint = { underdotted = true, sp = c.phosphor_dim },
    DiagnosticUnnecessary = { fg = c.phosphor_ghost, italic = true },
    DiagnosticDeprecated = { fg = c.phosphor_dim, strikethrough = true },
    LspReferenceText = { bg = c.glow_medium },
    LspReferenceRead = { bg = c.glow_medium },
    LspReferenceWrite = { bg = c.glow_high, bold = true },

    DiffAdd = { fg = c.phosphor_soft, bg = c.glow_low, underline = true },
    DiffChange = { fg = c.phosphor, bg = c.glow_medium },
    DiffDelete = { fg = c.phosphor_dim, bg = c.glow_low, strikethrough = true },
    DiffText = { fg = c.phosphor_bright, bg = c.glow_high, bold = true },
    Added = { fg = c.phosphor_soft, underline = true },
    Changed = { fg = c.phosphor, bold = true },
    Removed = { fg = c.phosphor_dim, strikethrough = true },
    diffAdded = { link = "Added" },
    diffChanged = { link = "Changed" },
    diffRemoved = { link = "Removed" },
    diffLine = { fg = c.phosphor_bright, bold = true },
    diffSubname = { fg = c.phosphor_dim, italic = true },
    diffFile = { fg = c.phosphor_bright, bold = true },
    diffNewFile = { link = "Added" },
    diffOldFile = { link = "Removed" },

    gitcommitSummary = { fg = c.phosphor_bright, bold = true, underline = true },
    gitcommitOverflow = { link = "DiagnosticError" },
    gitcommitComment = { link = "Comment" },
    gitcommitUntracked = { link = "Comment" },
    gitcommitDiscarded = { link = "Removed" },
    gitcommitSelected = { link = "Added" },
    gitcommitUnmerged = { link = "Changed" },
    gitcommitOnBranch = { link = "Label" },
    gitcommitBranch = { link = "Directory" },
    gitcommitNoBranch = { link = "DiagnosticError" },
    gitcommitHeader = { link = "Title" },
    gitcommitFirst = { link = "gitcommitSummary" },
    gitcommitSelectedType = { link = "Type" },
    gitcommitUnmergedType = { link = "Type" },
    gitcommitDiscardedType = { link = "Type" },
    gitcommitUntrackedFile = { link = "Added" },
    gitcommitUnmergedFile = { link = "Changed" },
    gitcommitDiscardedFile = { link = "Removed" },
    gitcommitSelectedFile = { link = "Added" },

    GitSignsAdd = { link = "Added" },
    GitSignsChange = { link = "Changed" },
    GitSignsDelete = { link = "Removed" },
    GitSignsAddLn = { link = "DiffAdd" },
    GitSignsChangeLn = { link = "DiffChange" },
    GitSignsDeleteLn = { link = "DiffDelete" },
    GitSignsAddInline = { link = "DiffAdd" },
    GitSignsChangeInline = { link = "DiffText" },
    GitSignsDeleteInline = { link = "DiffDelete" },
    GitSignsCurrentLineBlame = { fg = c.phosphor_ghost, italic = true },
    TelescopeNormal = { fg = c.phosphor, bg = c.screen_lifted },
    TelescopeBorder = { fg = c.phosphor_faint, bg = c.screen_lifted },
    TelescopeTitle = { fg = c.phosphor_bright, bg = c.screen_lifted, bold = true },
    TelescopeSelection = { fg = c.phosphor_bright, bg = c.glow_high, bold = true },
    TelescopeSelectionCaret = { fg = c.phosphor_bright, bg = c.glow_high },
    TelescopeMultiSelection = { fg = c.phosphor_soft, bg = c.glow_medium },
    TelescopeMatching = { fg = c.phosphor_bright, bold = true },
    CmpItemAbbr = { fg = c.phosphor },
    CmpItemAbbrDeprecated = { fg = c.phosphor_ghost, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.phosphor_bright, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.phosphor_soft, bold = true },
    CmpItemMenu = { fg = c.phosphor_dim, italic = true },
    CmpItemKind = { fg = c.phosphor_soft },
    WhichKey = { fg = c.phosphor_bright, bold = true },
    WhichKeyGroup = { fg = c.phosphor_soft, bold = true },
    WhichKeyDesc = { fg = c.phosphor },
    WhichKeySeparator = { fg = c.phosphor_faint },
    WhichKeySeperator = { fg = c.phosphor_faint },
    WhichKeyFloat = { bg = c.screen_lifted },
    WhichKeyBorder = { fg = c.phosphor_faint, bg = c.screen_lifted },
    WhichKeyValue = { fg = c.phosphor_dim },
    WhichKeyIcon = { fg = c.phosphor_soft },
    WhichKeyTitle = { fg = c.phosphor_bright, bg = c.screen_lifted, bold = true },
    WhichKeyFloatTitle = { link = "WhichKeyTitle" },
    WhichKeyNormal = { fg = c.phosphor, bg = c.screen_lifted },
    WhichKeyNormalNC = { fg = c.phosphor_dim, bg = c.screen_lifted },
    WhichKeyWin = { bg = c.screen_lifted },
    CopilotSuggestion = { fg = c.phosphor_ghost, italic = true },
    CopilotAnnotation = { link = "CopilotSuggestion" },
    DropBarIconUIPickPivot = { link = "DiagnosticError" },
    DropBarMenuHoverSymbol = { bold = true },
    DropBarMenuHoverEntry = { bg = c.glow_medium },
    DropBarMenuFloatBorder = { link = "FloatBorder" },
    DropBarMenuHoverIcon = { reverse = false },
    DropBarCurrentContext = { bold = true },
    DropBarCurrentContextName = { fg = c.phosphor_bright, bold = true },
    FlashBackdrop = { fg = c.phosphor_ghost },
    FlashCurrent = { fg = c.phosphor_bright, bg = c.glow_medium, bold = true },
    FlashLabel = { fg = c.screen_solid, bg = c.phosphor_bright, bold = true },
    FlashMatch = { fg = c.phosphor_soft, bg = c.glow_low, bold = true },
    FlashPrompt = { fg = c.phosphor, bg = c.screen_lifted },
    FlashPromptIcon = { fg = c.phosphor_bright, bg = c.screen_lifted },
    TreesitterContext = { bg = c.screen_lifted },
    TreesitterContextBottom = { underline = true, sp = c.phosphor_faint },
    TreesitterContextLineNumber = { fg = c.phosphor_dim, bg = c.screen_lifted },
    TreesitterContextLineNumberBottom = { fg = c.phosphor, bg = c.screen_lifted, underline = true, sp = c.phosphor_faint },
    TreesitterContextSeparator = { fg = c.phosphor_faint, bg = c.screen_lifted },
  }

  link(groups, { "GitSignsAddNr", "GitSignsStagedAdd" }, "GitSignsAdd")
  link(groups, { "GitSignsChangeNr", "GitSignsStagedChange" }, "GitSignsChange")
  link(groups, { "GitSignsDeleteNr", "GitSignsStagedDelete" }, "GitSignsDelete")

  link(groups, {
    "DropBarIconUISeparator", "DropBarIconUISeparatorMenu", "DropBarIconUISeparatorNC",
  }, "Delimiter")
  link(groups, { "DropBarIconKindFolderNC" }, "Directory")
  link(groups, { "WhichKeyFloatBorder" }, "WhichKeyBorder")
  link(groups, { "WhichKeyFloatNC" }, "WhichKeyNormalNC")
  link(groups, {
    "WhichKeyIconAzure", "WhichKeyIconBlue", "WhichKeyIconCyan", "WhichKeyIconGreen", "WhichKeyIconGrey",
    "WhichKeyIconOrange", "WhichKeyIconPurple", "WhichKeyIconRed", "WhichKeyIconYellow",
  }, "WhichKeyIcon")

  link(groups, {
    "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal",
  }, "TelescopeNormal")
  link(groups, {
    "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
  }, "TelescopeBorder")
  link(groups, {
    "TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle",
  }, "TelescopeTitle")
  groups.TelescopePromptPrefix = { fg = c.phosphor_bright, bg = c.screen_lifted }
  groups.TelescopePromptCounter = { fg = c.phosphor_dim, bg = c.screen_lifted }

  local completion_kinds = {
    "Text", "Method", "Function", "Constructor", "Field", "Variable", "Class",
    "Interface", "Module", "Property", "Unit", "Value", "Enum", "Keyword",
    "Snippet", "Color", "File", "Reference", "Folder", "EnumMember", "Constant",
    "Struct", "Event", "Operator", "TypeParameter",
  }
  for _, kind in ipairs(completion_kinds) do
    groups["CmpItemKind" .. kind] = "CmpItemKind"
  end

  groups.NoiceCmdline = { fg = c.phosphor, bg = c.screen_lifted }
  link(groups, { "NoiceCmdlineIcon", "NoiceCmdlineIconSearch" }, "NoiceCmdline")
  link(groups, { "NoiceCmdlinePopup", "NoiceConfirm", "NoiceMini" }, "NormalFloat")
  link(groups, {
    "NoiceCmdlinePopupBorder", "NoiceCmdlinePopupBorderSearch", "NoiceConfirmBorder",
  }, "FloatBorder")
  link(groups, { "NoiceCmdlinePopupTitle", "NoiceFormatTitle", "NoiceLspProgressTitle" }, "FloatTitle")
  groups.NoiceFormatConfirm = { fg = c.phosphor }
  groups.NoiceFormatConfirmDefault = { fg = c.phosphor_bright, bold = true }
  link(groups, { "NoiceFormatDate", "NoiceFormatEvent", "NoiceFormatKind" }, "Comment")
  link(groups, { "NoiceFormatLevelDebug", "NoiceFormatLevelTrace", "NoiceFormatLevelOff" }, "Comment")
  groups.NoiceFormatLevelError = "DiagnosticError"
  groups.NoiceFormatLevelInfo = "DiagnosticInfo"
  groups.NoiceFormatLevelWarn = "DiagnosticWarn"
  groups.NoiceFormatProgressDone = { fg = c.phosphor_soft }
  groups.NoiceFormatProgressTodo = { fg = c.phosphor_ghost }
  groups.NoiceLspProgressClient = { fg = c.phosphor }
  groups.NoiceLspProgressSpinner = { fg = c.phosphor_bright }
  groups.NoiceVirtualText = "DiagnosticVirtualTextInfo"

  return groups
end

return M
