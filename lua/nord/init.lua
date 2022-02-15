local uv = vim.loop
local b = require "nord.bitoper"
local S_IFDIR = tonumber("40000", 8)
local DIR_MODE = tonumber("755", 8)

local M = {
  palette = {
    nord0 = "#2E3440",
    nord1 = "#3B4252",
    nord2 = "#434C5E",
    nord3 = "#4C566A",
    nord3_bright = "#616E88",
    nord4 = "#D8DEE9",
    nord5 = "#E5E9F0",
    nord6 = "#ECEFF4",
    nord7 = "#8FBCBB",
    nord8 = "#88C0D0",
    nord9 = "#81A1C1",
    nord10 = "#5E81AC",
    nord11 = "#BF616A",
    nord12 = "#D08770",
    nord13 = "#EBCB8B",
    nord14 = "#A3BE8C",
    nord15 = "#B48EAD",

    black = "#3B4252",
    red = "#BF616A",
    green = "#A3BE8C",
    yellow = "#EBCB8B",
    blue = "#81A1C1",
    magenta = "#B48EAD",
    cyan = "#88C0D0",
    white = "#E5E9F0",
    bright_black = "#4C566A",
    bright_red = "#BF616A",
    bright_green = "#A3BE8C",
    bright_yellow = "#EBCB8B",
    bright_blue = "#81A1C1",
    bright_magenta = "#B48EAD",
    bright_cyan = "#8FBCBB",
    bright_white = "#ECEFF4",
  },
}

function M.update(opt)
  local text = M.generate(opt)
  local result = M.save(text)
  if result then
    M.warn "Updated. Please restart Neovim to use the new colors."
  else
    M.warn "Update detected. But failed."
  end
end

function M.warn(msg)
  vim.notify("[nord-vim] " .. msg, vim.log.levels.WARN)
end

function M.generate(opt)
  opt = vim.tbl_extend("force", {
    bold = true,
    italic = vim.fn.has "gui_running" == 1 or vim.env.TERM_ITALICS == "true",
    underline = true,
    italic_comments = true,
    uniform_status_lines = false,
    uniform_diff_background = false,
    cursor_line_number_background = false,
    bold_vertical_split_line = false,

    language_specific_highlights = true,
    plugin_specific_highlights = true,
    filetype_specific_highlights = true,
  }, opt or {})
  local opt_string = vim.inspect(opt, { newline = " ", indent = "" })

  local bold = opt.bold and "hi Bold gui=bold" or ""
  local italic = opt.italic and "hi Italic gui=italic" or ""
  local underline = opt.underline and "hi Underline gui=underline" or ""
  local cursor_line_nr = opt.cursor_line_number_background and " guibg=#3B4252" or ""
  local uniform_status_lines = opt.uniform_status_lines and "#4C566A" or "#3B4252"
  local bold_vertical_split_line = opt.bold_vertical_split_line and "#3B4252" or "#2E3440"
  local italic_comments = opt.italic_comments and " gui=italic" or ""
  local uniform_diff_background = opt.uniform_diff_background and "#3B4252" or "#2E3440"

  local result = [[
" nord-vim Lua version: ]] .. M.mtime() .. [[ opt: ]] .. opt_string .. [[

let g:colors_name = 'nord'
set background=dark

" Attributes
]] .. bold .. [[

]] .. italic .. [[

]] .. underline .. [[


" Editor
hi ColorColumn guibg=#3B4252
hi Cursor guifg=#2E3440 guibg=#D8DEE9
hi CursorLine guibg=#3B4252 gui=NONE
hi Error guifg=#D8DEE9 guibg=#BF616A
hi iCursor guifg=#2E3440 guibg=#D8DEE9
hi LineNr guifg=#4C566A guibg=NONE
hi MatchParen guifg=#88C0D0 guibg=#4C566A
hi NonText guifg=#434C5E
hi Normal guifg=#D8DEE9 guibg=#2E3440
hi Pmenu guifg=#D8DEE9 guibg=#434C5E gui=NONE
hi PmenuSbar guifg=#D8DEE9 guibg=#434C5E
hi PmenuSel guifg=#88C0D0 guibg=#4C566A
hi PmenuThumb guifg=#88C0D0 guibg=#4C566A
hi SpecialKey guifg=#4C566A
hi SpellBad guifg=#BF616A guibg=#2E3440 gui=undercurl guisp=#BF616A
hi SpellCap guifg=#EBCB8B guibg=#2E3440 gui=undercurl guisp=#EBCB8B
hi SpellLocal guifg=#E5E9F0 guibg=#2E3440 gui=undercurl guisp=#E5E9F0
hi SpellRare guifg=#ECEFF4 guibg=#2E3440 gui=undercurl guisp=#ECEFF4
hi Visual guibg=#434C5E
hi VisualNOS guibg=#434C5E

" Neovim Support
hi healthError guifg=#BF616A guibg=#3B4252
hi healthSuccess guifg=#A3BE8C guibg=#3B4252
hi healthWarning guifg=#EBCB8B guibg=#3B4252
hi TermCursorNC guibg=#3B4252

" Neovim Terminal Colors
let g:terminal_color_0 = '#3B4252'
let g:terminal_color_1 = '#BF616A'
let g:terminal_color_2 = '#A3BE8C'
let g:terminal_color_3 = '#EBCB8B'
let g:terminal_color_4 = '#81A1C1'
let g:terminal_color_5 = '#B48EAD'
let g:terminal_color_6 = '#88C0D0'
let g:terminal_color_7 = '#E5E9F0'
let g:terminal_color_8 = '#4C566A'
let g:terminal_color_9 = '#BF616A'
let g:terminal_color_10 = '#A3BE8C'
let g:terminal_color_11 = '#EBCB8B'
let g:terminal_color_12 = '#81A1C1'
let g:terminal_color_13 = '#B48EAD'
let g:terminal_color_14 = '#8FBCBB'
let g:terminal_color_15 = '#ECEFF4'

" Neovim Diagnostics API
hi DiagnosticWarn guifg=#EBCB8B
hi DiagnosticError guifg=#BF616A
hi DiagnosticInfo guifg=#88C0D0
hi DiagnosticHint guifg=#5E81AC
hi DiagnosticUnderlineWarn guifg=#EBCB8B gui=undercurl
hi DiagnosticUnderlineError guifg=#BF616A gui=undercurl
hi DiagnosticUnderlineInfo guifg=#88C0D0 gui=undercurl
hi DiagnosticUnderlineHint guifg=#5E81AC gui=undercurl

" Neovim Document
hi LspReferenceText guibg=#4C566A
hi LspReferenceRead guibg=#4C566A
hi LspReferenceWrite guibg=#4C566A

" Gutter
hi CursorColumn guibg=#3B4252
hi CursorLineNr guifg=#D8DEE9]] .. cursor_line_nr .. [[

hi Folded guifg=#4C566A guibg=#3B4252
hi FoldColumn guifg=#4C566A guibg=#2E3440
hi SignColumn guifg=#3B4252 guibg=#2E3440

" Navigation
hi Directory guifg=#88C0D0

" Prompt/Status
hi EndOfBuffer guifg=#3B4252
hi ErrorMsg guifg=#D8DEE9 guibg=#BF616A
hi ModeMsg guifg=#D8DEE9
hi MoreMsg guifg=#88C0D0
hi Question guifg=#D8DEE9
hi StatusLine guifg=#88C0D0 guibg=]] .. uniform_status_lines .. [[

hi StatusLineNC guifg=#D8DEE9 guibg=]] .. uniform_status_lines .. [[

hi StatusLineTerm guifg=#88C0D0 guibg=]] .. uniform_status_lines .. [[

hi StatusLineTermNC guifg=#D8DEE9 guibg=]] .. uniform_status_lines .. [[

hi WarningMsg guifg=#2E3440 guibg=#EBCB8B
hi WildMenu guifg=#88C0D0 guibg=#3B4252

" Search
hi IncSearch guifg=#ECEFF4 guibg=#5E81AC
hi Search guifg=#3B4252 guibg=#88C0D0

" Tabs
hi TabLine guifg=#D8DEE9 guibg=#3B4252
hi TabLineFill guifg=#D8DEE9 guibg=#3B4252
hi TabLineSel guifg=#88C0D0 guibg=#4C566A

" Window
hi Title guifg=#D8DEE9
hi VertSplit guifg=#434C5E guibg=]] .. bold_vertical_split_line .. [[


" Language Base Groups
hi Boolean guifg=#81A1C1
hi Character guifg=#A3BE8C
hi Comment guifg=#616E88]] .. italic_comments .. [[

hi Conceal guibg=NONE
hi Conditional guifg=#81A1C1
hi Constant guifg=#D8DEE9
hi Decorator guifg=#D08770
hi Define guifg=#81A1C1
hi Delimiter guifg=#ECEFF4
hi Exception guifg=#81A1C1
hi Float guifg=#B48EAD
hi Function guifg=#88C0D0
hi Identifier guifg=#D8DEE9
hi Include guifg=#88A1C1
hi Keyword guifg=#88A1C1
hi Label guifg=#88A1C1
hi Number guifg=#B48EAD
hi Operator guifg=#88A1C1
hi PreProc guifg=#88A1C1
hi Repeat guifg=#88A1C1
hi Special guifg=#D8DEE9
hi SpecialChar guifg=#EBCB8B
hi SpecialComment guifg=#88C0D0]] .. italic_comments .. [[

hi Statement guifg=#81A1C1
hi StorageClass guifg=#81A1C1
hi String guifg=#A3BE8C
hi Structure guifg=#81A1C1
hi Tag guifg=#D8DEE9
hi Todo guifg=#EBCB8B guibg=NONE
hi Type guifg=#81A1C1
hi Typedef guifg=#81A1C1
hi! link Annotation Decorator
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Variable Identifier

" Languages
hi asciidocAttributeEntry guifg=#5E81AC
hi asciidocAttributeList guifg=#5E81AC
hi asciidocAttributeRef guifg=#5E81AC
hi asciidocHLabel guifg=#81A1C1
hi asciidocListingBlock guifg=#8FBCBB
hi asciidocMacroAttributes guifg=#88C0D0
hi asciidocOneLineTitle guifg=#88C0D0
hi asciidocPassthroughBlock guifg=#81A1C1
hi asciidocQuotedMonospaced guifg=#8FBCBB
hi asciidocTriplePlusPassthrough guifg=#8FBCBB
hi! link asciidocAdmonition Keyword
hi! link asciidocAttributeRef markdownH1
hi! link asciidocBackslash Keyword
hi! link asciidocMacro Keyword
hi! link asciidocQuotedBold Bold
hi! link asciidocQuotedEmphasized Italic
hi! link asciidocQuotedMonospaced2 asciidocQuotedMonospaced
hi! link asciidocQuotedUnconstrainedBold asciidocQuotedBold
hi! link asciidocQuotedUnconstrainedEmphasized asciidocQuotedEmphasized
hi! link asciidocURL markdownLinkText

hi awkCharClass guifg=#8FBCBB
hi awkPatterns guifg=#81A1C1
hi! link awkArrayElement Identifier
hi! link awkBoolLogic Keyword
hi! link awkBrktRegExp SpecialChar
hi! link awkComma Delimiter
hi! link awkExpression Keyword
hi! link awkFieldVars Identifier
hi! link awkLineSkip Keyword
hi! link awkOperator Operator
hi! link awkRegExp SpecialChar
hi! link awkSearch Keyword
hi! link awkSemicolon Delimiter
hi! link awkSpecialCharacter SpecialChar
hi! link awkSpecialPrintf SpecialChar
hi! link awkVariables Identifier

hi! link csPreCondit PreCondit
hi! link csType Type
hi! link csXmlTag SpecialComment

hi dosiniHeader guifg=#88C0D0
hi! link dosiniLabel Type

hi dtBooleanKey guifg=#8FBCBB
hi dtExecKey guifg=#8FBCBB
hi dtLocaleKey guifg=#8FBCBB
hi dtNumericKey guifg=#8FBCBB
hi dtTypeKey guifg=#8FBCBB
hi! link dtDelim Delimiter
hi! link dtLocaleValue Keyword
hi! link dtTypeValue Keyword

hi DiffAdd guifg=#A3BE8C guibg=]] .. uniform_diff_background .. [[

hi DiffChange guifg=#EBCB8B guibg=]] .. uniform_diff_background .. [[

hi DiffDelete guifg=#BF616A guibg=]] .. uniform_diff_background .. [[

hi DiffText guifg=#81A1C1 guibg=]] .. uniform_diff_background .. [[

hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete

hi gitconfigVariable guifg=#8FBCBB

hi helpBar guifg=#4C566A
hi helpHyperTextJump guifg=#88C0D0 gui=underline

hi! link lispAtomBarSymbol SpecialChar
hi! link lispAtomList SpecialChar
hi! link lispAtomMark Keyword
hi! link lispBarSymbol SpecialChar
hi! link lispFunc Function

hi perlPackageDecl guifg=#8FBCBB

hi phpClasses guifg=#8FBCBB
hi phpDocTags guifg=#8FBCBB
hi! link phpDocCustomTags phpDocTags
hi! link phpMemberSelector Keyword

hi podCmdText guifg=#8FBCBB
hi podVerbatimLine guifg=#D8DEE9
hi! link podFormat Keyword

hi! link sqlKeyword Keyword
hi! link sqlSpecial Keyword

" Plugins
" Neovim LSP
" > neovim/nvim-lspconfig
hi LspCodeLens guifg=#616E88
hi LspDiagnosticsDefaultWarning guifg=#EBCB8B
hi LspDiagnosticsDefaultError guifg=#BF616A
hi LspDiagnosticsDefaultInformation guifg=#88C0D0
hi LspDiagnosticsDefaultHint guifg=#5E81AC
hi LspDiagnosticsUnderlineWarning guifg=#EBCB8B gui=undercurl
hi LspDiagnosticsUnderlineError guifg=#BF616A gui=undercurl
hi LspDiagnosticsUnderlineInformation guifg=#88C0D0 gui=undercurl
hi LspDiagnosticsUnderlineHint guifg=#5E81AC gui=undercurl

" tree-sitter
" > nvim-treesitter/nvim-treesitter
hi! link TSAnnotation Annotation
hi! link TSConstBuiltin Constant
hi! link TSConstructor Function
hi! link TSEmphasis Italic
hi! link TSFuncBuiltin Function
hi! link TSFuncMacro Function
hi! link TSStringRegex SpecialChar
hi! link TSStrong Bold
hi! link TSStructure Structure
hi! link TSTagDelimiter TSTag
hi! link TSUnderline Underline
hi! link TSVariable Variable
hi! link TSVariableBuiltin Keyword
]]

  -- This is not needed when you enable tree-sitter highlighting.
  if opt.language_specific_highlights then
    result = result
      .. [[
hi cIncluded guifg=#8FBCBB
hi! link cOperator Operator
hi! link cPreCondit PreCondit
hi! link cConstant Type

hi cmakeGeneratorExpression guifg=#5E81AC

hi cssAttributeSelector guifg=#8FBCBB
hi cssDefinition guifg=#8FBCBB
hi cssIdentifier guifg=#8FBCBB
hi cssStringQ guifg=#8FBCBB
hi! link cssAttr Keyword
hi! link cssBraces Delimiter
hi! link cssClassName cssDefinition
hi! link cssColor Number
hi! link cssProp cssDefinition
hi! link cssPseudoClass cssDefinition
hi! link cssPseudoClassId cssPseudoClass
hi! link cssVendor Keyword

hi goBuiltins guifg=#8FBCBB
hi! link goConstants Keyword

hi htmlArg guifg=#8FBCBB
hi htmlLink guifg=#D8DEE9
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTag Keyword
hi! link htmlTagN htmlTag

hi javaDocTags guifg=#8FBCBB
hi! link javaCommentTitle Comment
hi! link javaScriptBraces Delimiter
hi! link javaScriptIdentifier Keyword
hi! link javaScriptNumber Number

hi jsonKeyword guifg=#8FBCBB

hi lessClass guifg=#8FBCBB
hi! link lessAmpersand Keyword
hi! link lessCssAttribute Delimiter
hi! link lessFunction Function
hi! link cssSelectorOp Keyword

hi! link luaFunc Function

hi markdownBlockquote guifg=#8FBCBB
hi markdownCode guifg=#8FBCBB
hi markdownCodeDelimiter guifg=#8FBCBB
hi markdownFootnote guifg=#8FBCBB
hi markdownId guifg=#8FBCBB
hi markdownIdDeclaration guifg=#8FBCBB
hi markdownH1 guifg=#88C0D0
hi markdownLinkText guifg=#88C0D0
hi markdownUrl guifg=#D8DEE9
hi! link markdownBold Bold
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword

hi! link pythonBuiltin Type
hi! link pythonEscape SpecialChar

hi rubyConstant guifg=#8FBCBB
hi rubySymbol guifg=#ECEFF4
hi! link rubyAttribute Identifier
hi! link rubyBlockParameterList Operator
hi! link rubyInterpolationDelimiter Keyword
hi! link rubyKeywordAsMethod Function
hi! link rubyLocalVariableOrMethod Function
hi! link rubyPseudoVariable Keyword
hi! link rubyRegexp SpecialChar

hi rustAttribute guifg=#5E81AC
hi rustEnum guifg=#8FBCBB
hi rustMacro guifg=#88C0D0
hi rustModPath guifg=#8FBCBB
hi rustPanic guifg=#81A1C1
hi rustTrait guifg=#8FBCBB
hi! link rustCommentLineDoc Comment
hi! link rustDerive rustAttribute
hi! link rustEnumVariant rustEnum
hi! link rustEscape SpecialChar
hi! link rustQuestionMark Keyword

hi sassClass guifg=#8FBCBB
hi sassId guifg=#8FBCBB
hi! link sassAmpersand Keyword
hi! link sassClassChar Delimiter
hi! link sassControl Keyword
hi! link sassControlLine Keyword
hi! link sassExtend Keyword
hi! link sassFor Keyword
hi! link sassFunctionDecl Keyword
hi! link sassFunctionName Function
hi! link sassidChar sassId
hi! link sassInclude SpecialChar
hi! link sassMixinName Function
hi! link sassMixing SpecialChar
hi! link sassReturn Keyword

hi! link shCmdParenRegion Delimiter
hi! link shCmdSubRegion Delimiter
hi! link shDerefSimple Identifier
hi! link shDerefVar Identifier

hi vimAugroup guifg=#8FBCBB
hi vimMapRhs guifg=#8FBCBB
hi vimNotation guifg=#8FBCBB
hi! link vimFunc Function
hi! link vimFunction Function
hi! link vimUserFunc Function

hi xmlAttrib guifg=#8FBCBB
hi xmlCdataStart guifg=#616E88
hi xmlNamespace guifg=#8FBCBB
hi! link xmlAttribPunct Delimiter
hi! link xmlCdata Comment
hi! link xmlCdataCdata xmlCdataStart
hi! link xmlCdataEnd xmlCdataStart
hi! link xmlEndTag xmlTagName
hi! link xmlProcessingDelim Keyword
hi! link xmlTagName Keyword

hi yamlBlockMappingKey guifg=#8FBCBB
hi! link yamlBool Keyword
hi! link yamlDocumentStart Keyword

]]
  end

  if opt.plugin_specific_highlights then
    -- TODO
  end

  return result
end

function M.this_file()
  return debug.getinfo(1, "S").source:gsub("^@", "", 1)
end

function M.filename()
  local top_dir = M.this_file():gsub([[/lua/nord.lua]], "", 1)
  return top_dir .. "/colors/nord.vim"
end

function M.save(text)
  local filename = M.filename()
  local colors_dir = filename:gsub [[/nord.vim$]]
  local st = uv.fs_stat(colors_dir)
  if not st or b(st.mode, S_IFDIR, b.AND) ~= S_IFDIR then
    uv.fs_mkdir(colors_dir, DIR_MODE)
  end
  local fd = uv.fs_open(filename, "w", tonumber("644", 8))
  return uv.fs_write(fd, text)
end

return M
