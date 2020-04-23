set background=dark
highlight clear
if exists("syntax_on")
        syntax reset
endif
let g:colors_name = "xor"

" Change between colorscheme variations with :XORvariation <name>
command! -nargs=? XORvariation call s:xor_set_variation("<args>")

function s:xor_set_variation(variation)
	if a:variation ==? 'contrast'
		let bgn="#242325"
		let bga="#333134"
		let fgn="#BEB4BE"
		let fga="#9CA0AB"
		let acc="#FFE269"
	" Greeting curious vimscript reader!
	" You can add your own variations below.
	" I found https://coolors.co/ to be an easy way to generate palletes.
	" elseif a:variation ==? 'other'
		" let bgn="#XXXXXX" "background normal
		" let bga="#XXXXXX" "background alternate
		" let fgn="#XXXXXX" "foreground normal
		" let fga="#XXXXXX" "foreground alternate
		" let acc="#XXXXXX" "accent
	else
		let bgn="#242325"
		let bga="#333134"
		let fgn="#A09FA0"
		let fga="#7A7C84"
		let acc="#FED766"
	endif
	call s:setup(fgn, fga, acc, bgn, bga)
endfunction


function s:hili(group, guifg, guibg, guisp, gui)
    exec "hi " . a:group . " guifg=" . a:guifg . " guibg=" . a:guibg . " guisp=" . a:guisp . " gui=" . a:gui
endfunction

function s:setup(fgn, fga, acc, bgn, bga)
	call	s:hili("Normal",	a:fgn,	a:bgn,	"none",	"none")
	call	s:hili("NormalNC",	"none",	"none",	"none",	"none")
	call	s:hili("Cursor",	"none",	"none",	"none",	"reverse")
	call	s:hili("CursorLine",	"none",	a:bga,	"none",	"none")
	call	s:hili("CursorColumn",	"none",	a:bga,	"none",	"none")
	call	s:hili("VertSplit",	a:bga,	a:bga,	"none",	"none")
	call	s:hili("LineNr",	a:bga,	a:bgn,	"none",	"none")
	call	s:hili("CursorLineNr",	a:bgn,	a:bga,	"none",	"none")
	call	s:hili("Visual",	"none",	a:bga,	"none",	"none")
	call	s:hili("MatchParen",	"none",	"none",	"none",	"underline")
	call	s:hili("NonText",	a:bga,	"none",	"none",	"none")
	call	s:hili("IncSearch",	a:bga,	a:acc,	"none",	"none")
	call	s:hili("Search",	a:bga,	a:acc,	"none",	"none")
	call	s:hili("SpellBad",	"none",	"none",	a:acc,	"undercurl")
	call	s:hili("Whitespace",	a:bga,	"none",	"none",	"bold")
	call	s:hili("Directory",	a:fga,	"none",	"none",	"none")
	call	s:hili("ColorColumn",	"none",	a:bga,	"none",	"none")
	call	s:hili("MsgArea",	"none",	"none",	"none",	"none")
	call	s:hili("ErrorMsg",	a:acc,	"none",	"none",	"bold")
	call	s:hili("WarningMsg",	a:fga,	"none",	"none",	"bold")
	call	s:hili("Folded",	"none",	a:bga,	"none",	"italic")
	call	s:hili("QuickFixLine",	"none",	"none",	"none",	"reverse")

	call	s:hili("Pmenu",	"none",	a:bga,	"none",	"none")
	call	s:hili("PmenuSel",	"none",	"none",	"none",	"reverse")
	call	s:hili("PmenuThumb",	"none",	a:bga,	"none",	"none")
	call	s:hili("PmenuSbar",	"none",	a:bgn,	"none",	"none")

	call	s:hili("Comment",	a:fga,	"none",	"none",	"italic")
	call	s:hili("Constant",	a:fga,	"none",	"none",	"italic")
	call	s:hili("Identifier",	a:fga,	"none",	"none",	"none")
	call	s:hili("Statement",	"none",	"none",	"none",	"bold")
	call	s:hili("PreProc",	"none",	"none",	"none",	"bold,italic")
	call	s:hili("Type",	"none",	"none",	"none",	"bold")
	call	s:hili("Special",	a:fga,	"none",	"none",	"italic")
	call	s:hili("Underlined",	"none",	"none",	"none",	"underline")
	call	s:hili("Todo",	a:acc,	"none",	"none",	"italic")
	call	s:hili("Error",	a:bgn,	a:acc,	"none",	"none")

	call	s:hili("LspDiagnosticsError",	a:bga,	a:acc,	"none",	"italic")
	call	s:hili("LspDiagnosticsWarning",	a:acc,	"none",	"none",	"italic")
	call	s:hili("LspDiagnosticsInformation",	a:fga,	"none",	"none",	"italic")
	call	s:hili("LspDiagnosticsHint",	"none",	"none",	"none",	"italic")

	call	s:hili("DiffAdd",	a:fga,	a:bga,	"none",	"none")
	call	s:hili("DiffChange",	"none",	"none",	"none",	"none")
	call	s:hili("DiffDelete",	a:bgn,	a:bga,	"none",	"none")
	call	s:hili("DiffText",	"none",	a:bga,	"none",	"none")


	""" extensions

	" fugitive
	call	s:hili("gitDiff",	"none",	"none",	"none",	"none")
	call	s:hili("diffAdded",	a:fga,	a:bga,	"none",	"none")
	call	s:hili("diffRemoved",	a:bgn,	a:bga,	"none",	"none")
endfunction

" call s:xor_set_variation("")
XORvariation
