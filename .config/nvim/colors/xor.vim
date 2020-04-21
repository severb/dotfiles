set background=dark
highlight clear
if exists("syntax_on")
        syntax reset
endif
let g:colors_name = "xor"

let s:bgn="#242325"
let s:bga="#333134"
let s:acc="#FED766"
let s:fgn="#A09FA0"
let s:fga="#7A7C84"


function s:hili(group, guifg, guibg, guisp, gui)
    exec "hi " . a:group . " guifg=" . a:guifg . " guibg=" . a:guibg . " guisp=" . a:guisp . " gui=" . a:gui
endfunction

call	s:hili("Normal",	s:fgn,	s:bgn,	"none",	"none")
call	s:hili("NormalNC",	"none",	"none",	"none",	"none")
call	s:hili("Cursor",	"none",	"none",	"none",	"reverse")
call	s:hili("CursorLine",	"none",	s:bga,	"none",	"none")
call	s:hili("CursorColumn",	"none",	s:bga,	"none",	"none")
call	s:hili("VertSplit",	s:bga,	s:bga,	"none",	"none")
call	s:hili("LineNr",	s:bga,	s:bgn,	"none",	"none")
call	s:hili("CursorLineNr",	s:bgn,	s:bga,	"none",	"none")
call	s:hili("Visual",	"none",	s:bga,	"none",	"none")
call	s:hili("MatchParen",	"none",	"none",	"none",	"underline")
call	s:hili("NonText",	s:bga,	"none",	"none",	"none")
call	s:hili("IncSearch",	s:acc,	"none",	"none",	"reverse")
call	s:hili("Search",	s:acc,	"none",	"none",	"reverse")
call	s:hili("SpellBad",	"none",	"none",	s:acc,	"undercurl")
call	s:hili("Whitespace",	s:bga,	"none",	"none",	"bold")
call	s:hili("Directory",	s:fga,	"none",	"none",	"none")
call	s:hili("ColorColumn",	"none",	s:bga,	"none",	"none")
call	s:hili("MsgArea",	"none",	"none",	"none",	"none")
call	s:hili("ErrorMsg",	s:acc,	"none",	"none",	"none")
call	s:hili("WarningMsg",	s:fga,	"none",	"none",	"none")
call	s:hili("Folded",	"none",	s:bga,	"none",	"italic")
call	s:hili("QuickFixLine",	"none",	"none",	"none",	"reverse")

call	s:hili("Pmenu",	"none",	s:bga,	"none",	"none")
call	s:hili("PmenuSel",	"none",	"none",	"none",	"reverse")
call	s:hili("PmenuThumb",	"none",	s:bga,	"none",	"none")
call	s:hili("PmenuSbar",	"none",	s:bgn,	"none",	"none")

call	s:hili("Comment",	s:fga,	"none",	"none",	"italic")
call	s:hili("Constant",	s:fga,	"none",	"none",	"italic")
call	s:hili("Identifier",	s:fga,	"none",	"none",	"none")
call	s:hili("Statement",	"none",	"none",	"none",	"bold")
call	s:hili("PreProc",	"none",	"none",	"none",	"bold,italic")
call	s:hili("Type",	"none",	"none",	"none",	"bold")
call	s:hili("Special",	s:fga,	"none",	"none",	"italic")
call	s:hili("Underlined",	"none",	"none",	"none",	"underline")
call	s:hili("Todo",	s:acc,	"none",	"none",	"italic")
call	s:hili("Error",	s:acc,	"none",	"none",	"reverse")

call	s:hili("LspDiagnosticsError",	s:acc,	"none",	"none",	"italic")
call	s:hili("LspDiagnosticsWarning",	s:bgn,	s:bga,	"none",	"italic")
call	s:hili("LspDiagnosticsInformation",	s:bga,	"none",	"none",	"italic")
call	s:hili("LspDiagnosticsHint",	s:bga,	"none",	"none",	"italic")

call	s:hili("DiffAdd",	s:fga,	s:bga,	"none",	"none")
call	s:hili("DiffChange",	"none",	"none",	"none",	"none")
call	s:hili("DiffDelete",	s:bgn,	s:bga,	"none",	"none")
call	s:hili("DiffText",	"none",	s:bga,	"none",	"none")


""" extensions

" fugitive
call	s:hili("gitDiff",	"none",	"none",	"none",	"none")
call	s:hili("diffAdded",	s:fga,	s:bga,	"none",	"none")
call	s:hili("diffRemoved",	s:bgn,	s:bga,	"none",	"none")
