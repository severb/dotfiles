set background=dark
highlight clear
if exists("syntax_on")
        syntax reset
endif
let g:colors_name = "xor"

hi Normal       guifg=#aaaaaa   guibg=none      gui=none
hi! link NonText        Normal
hi! link Identifier     Normal
hi! link PreProc        Normal
hi! link Type           Normal
hi! link Special        Normal
hi! link Constant       Normal

hi Cursor       guifg=none      guibg=none      gui=reverse
hi! link TermCursor     Cursor

hi Visual       guifg=none      guibg=none      gui=reverse
hi Todo         guifg=#e5c07b   guibg=none      gui=none
hi! link MatchParen Todo
hi Error        guifg=#e06c75   guibg=none      gui=none
hi Underlined   guifg=none      guibg=none      gui=underline
hi Comment      guifg=#bbbbbb   guibg=none      gui=bold
hi Statement    guifg=#666666   guibg=none      gui=none
hi! link LineNr Statement
hi CursorLineNr guifg=#666666   guibg=#242730   gui=none

hi VertSplit    guifg=#242730   guibg=#242730   gui=none
hi CursorLine   guifg=none      guibg=#242730   gui=none
hi! link ColorColumn    CursorLine
hi! link CursorColumn   CursorLine

hi Search       guifg=#000000   guibg=#e5c07b   gui=none
hi! link IncSearch      Search

hi Pmenu        guifg=#cccccc   guibg=#191b21   gui=none
hi! link PmenuSbar Pmenu
hi PmenuThumb   guifg=none      guibg=#000000   gui=none
hi PmenuSel     guifg=#282c34   guibg=#e5c07b   gui=none

hi Whitespace   guifg=#444444   guibg=none      gui=none

hi SpellBad     guifg=#e06c75   guibg=none      gui=undercurl   guisp=#e06c75
hi! link SpellCap SpellBad
hi! link SpellLocal SpellBad
hi! link SpellRare SpellBad

hi illuminatedWord guifg=none	guibg=none	gui=underline
