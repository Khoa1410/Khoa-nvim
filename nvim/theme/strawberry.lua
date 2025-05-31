
local M = {}

-- khai báo màu hex
local colors = {
  g0 = "#fff0f7",
  g1 = "#f0dde6",
  g2 = "#b5a3ac",
  g3 = "#9e8b95",
  g4 = "#8a7680",
  g5 = "#75616b",
  g6 = "#3b2c33",
  g7 = "#2b1d24",
  g8 = "#f55050",
  g9 = "#e06a26",
  gA = "#d4ac35",
  gB = "#219e21",
  gC = "#1b9e9e",
  gD = "#468dd4",
  gE = "#a26fbf",
  gF = "#d46a84",
}

local function set_highlight(group, opts)
  local hl = { fg = opts.fg, bg = opts.bg, bold = opts.bold, underline = opts.underline, undercurl = opts.undercurl, reverse = opts.reverse }
  vim.api.nvim_set_hl(0, group, hl)
end

function M.setup()
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "light"
  vim.g.colors_name = "strawberry_light"

  -- cơ bản
  set_highlight("Cursor", { fg = colors.g0, bg = colors.gF })
  set_highlight("StatusLine", { fg = colors.g0, bg = colors.gF })
  set_highlight("StatusLineTerm", { fg = colors.g0, bg = colors.gF })
  set_highlight("TabLineSel", { fg = colors.g0, bg = colors.gF })
  set_highlight("TermCursor", { fg = colors.g0, bg = colors.gF })

  set_highlight("CursorLineNr", { fg = colors.g0, bg = colors.g3 })
  set_highlight("LineNr", { fg = colors.g4, bg = colors.g1 })

  set_highlight("Bold", { bold = true })
  set_highlight("Directory", { fg = colors.g5, bold = true })
  set_highlight("Italic", { underline = false }) 
  set_highlight("Normal", { fg = colors.g5, bg = colors.g0 })
  set_highlight("Underlined", { fg = colors.g5, underline = true })

  set_highlight("Comment", { fg = colors.g3 })
  set_highlight("Conceal", { fg = colors.g3 })
  set_highlight("EndOfBuffer", { fg = colors.g3 })
  set_highlight("Ignore", { fg = colors.g3 })
  set_highlight("NonText", { fg = colors.g3 })

  set_highlight("ColorColumn", { bg = colors.g1 })
  set_highlight("CursorColumn", { bg = colors.g1 })
  set_highlight("CursorLine", { bg = colors.g1 })
  set_highlight("QuickFixLine", { bg = colors.g1 })
  set_highlight("StatusLineNC", { fg = colors.g5, bg = colors.g1 })
  set_highlight("StatusLineTermNC", { fg = colors.g5, bg = colors.g1 })
  set_highlight("TabLineFill", { bg = colors.g1 })
  set_highlight("TermCursorNC", { bg = colors.g1 })

  set_highlight("DiffChange", { fg = colors.g4, bg = colors.g1 })
  set_highlight("FoldColumn", { fg = colors.g4, bg = colors.g1 })
  set_highlight("Folded", { fg = colors.g4, bg = colors.g1 })
  set_highlight("SignColumn", { fg = colors.g4, bg = colors.g1 })
  set_highlight("TabLine", { fg = colors.g4, bg = colors.g1 })
  set_highlight("VisualNOS", { fg = colors.g4, bg = colors.g1 })

  set_highlight("MatchParen", { fg = colors.g6, bg = colors.g2 })
  set_highlight("Pmenu", { fg = colors.g6, bg = colors.g2 })
  set_highlight("Visual", { fg = colors.g6, bg = colors.g2 })

  set_highlight("PmenuSel", { fg = colors.g0, bg = colors.g5 })
  set_highlight("WildMenu", { fg = colors.g0, bg = colors.g6 })

  set_highlight("PmenuSbar", { fg = colors.g1, bg = colors.g1 })
  set_highlight("PmenuThumb", { fg = colors.g4, bg = colors.g4 })
  set_highlight("VertSplit", { fg = colors.g2, bg = colors.g2 })

  -- cảnh báo (RED)
  set_highlight("DiffDelete", { fg = colors.g8, bg = colors.g0, reverse = true })
  set_highlight("Error", { fg = colors.g8, bg = colors.g0, reverse = true })
  set_highlight("ErrorMsg", { fg = colors.g8, bg = colors.g0 })
  set_highlight("SpellBad", { undercurl = true, sp = colors.g8 })
  set_highlight("TooLong", { fg = colors.g8 })
  set_highlight("WarningMsg", { fg = colors.g8, bg = colors.g0 })

  -- cam (ORANGE)
  set_highlight("Define", { fg = colors.g9 })
  set_highlight("IncSearch", { fg = colors.g9, bg = colors.g0, reverse = true })
  set_highlight("Include", { fg = colors.g9 })
  set_highlight("Macro", { fg = colors.g9 })
  set_highlight("PreCondit", { fg = colors.g9 })
  set_highlight("PreProc", { fg = colors.g9 })
  set_highlight("SpellCap", { undercurl = true, sp = colors.g9 })
  set_highlight("Title", { fg = colors.g9 })

  -- vàng (YELLOW)
  set_highlight("DiffText", { fg = colors.gA, bg = colors.g6, reverse = true })
  set_highlight("Search", { fg = colors.gA, bg = colors.g6, reverse = true })
  set_highlight("Todo", { fg = colors.gA, bg = colors.g6, reverse = true })

  -- xanh lá (GREEN)
  set_highlight("Conditional", { fg = colors.gB })
  set_highlight("DiffAdd", { fg = colors.gB, bg = colors.g0, reverse = true })
  set_highlight("Exception", { fg = colors.gB })
  set_highlight("Keyword", { fg = colors.gB })
  set_highlight("Label", { fg = colors.gB })
  set_highlight("ModeMsg", { fg = colors.gB })
  set_highlight("MoreMsg", { fg = colors.gB })
  set_highlight("Operator", { fg = colors.gB })
  set_highlight("Question", { fg = colors.gB })
  set_highlight("Repeat", { fg = colors.gB })
  set_highlight("Statement", { fg = colors.gB })

  -- xanh ngọc (TEAL)
  set_highlight("SpellLocal", { undercurl = true, sp = colors.gC })
  set_highlight("StorageClass", { fg = colors.gC })
  set_highlight("Structure", { fg = colors.gC })
  set_highlight("Type", { fg = colors.gC })
  set_highlight("Typedef", { fg = colors.gC })

  -- xanh dương (BLUE)
  set_highlight("Boolean", { fg = colors.gD })
  set_highlight("Character", { fg = colors.gD })
  set_highlight("Constant", { fg = colors.gD })
  set_highlight("Float", { fg = colors.gD })
  set_highlight("Number", { fg = colors.gD })
  set_highlight("String", { fg = colors.gD })

  -- tím (PURPLE)
  set_highlight("Debug", { fg = colors.gE })
  set_highlight("Delimiter", { fg = colors.gE })
  set_highlight("Special", { fg = colors.gE })
  set_highlight("SpecialChar", { fg = colors.gE })
  set_highlight("SpecialComment", { fg = colors.gE })
  set_highlight("SpecialKey", { fg = colors.gE })
  set_highlight("SpellRare", { undercurl = true, sp = colors.gE })
  set_highlight("Tag", { fg = colors.gE })

  -- hồng (PINK)
  set_highlight("Function", { fg = colors.gF })
  set_highlight("Identifier", { fg = colors.gF })

  -- tùy chọn disable
  if vim.g.strawberry_light_CursorLineNr == "off" then
    set_highlight("CursorLineNr", { fg = colors.g4, bg = colors.g1 })
  end

  if vim.g.strawberry_light_LineNr == "off" then
    set_highlight("CursorLineNr", { fg = colors.g4, bg = colors.g0 })
    set_highlight("LineNr", { fg = colors.g4, bg = colors.g0 })
  end
end

return M

