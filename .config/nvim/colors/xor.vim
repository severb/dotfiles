set background=dark
highlight clear
if exists("syntax_on")
        syntax reset
endif
let g:colors_name = "xor"

hi Normal       guifg=#a9afbc   guibg=none      gui=none
hi! link NonText        Normal
hi! link Identifier     Normal
hi! link PreProc        Normal
hi! link Type           Normal
hi! link Special        Normal
hi! link Constant       Normal

hi Cursor       guifg=none      guibg=none      gui=reverse
hi! link TermCursor     Cursor

hi Visual       guifg=none      guibg=none      gui=reverse
hi Todo         guifg=#e5c07b   guibg=none      gui=bold
hi! link MatchParen Todo
hi Error        guifg=#e06c75   guibg=none      gui=none
hi Underlined   guifg=none      guibg=none      gui=underline
hi Comment      guifg=#d4d7de   guibg=none      gui=italic
hi Statement    guifg=#7d879b   guibg=none      gui=none
hi! link LineNr Statement
hi CursorLineNr guifg=#7d879b   guibg=none      gui=bold

hi VertSplit    guifg=#2c313a   guibg=#2c313a   gui=none
hi CursorLine   guifg=none      guibg=#2c313a   gui=none
hi! link ColorColumn    CursorLine
hi! link CursorColumn   CursorLine

hi Search       guifg=#282c34   guibg=#e5c07b   gui=none
hi! link IncSearch      Search

hi Pmenu        guifg=#a9afbc   guibg=#373d48   gui=none
hi! link PmenuSbar Pmenu
hi PmenuThumb   guifg=none      guibg=#21252b   gui=none
hi PmenuSel     guifg=none      guibg=#21252b   gui=none

hi Whitespace   guifg=#596273   guibg=none      gui=none

hi SpellBad     guifg=#e06c75   guibg=none      gui=undercurl   guisp=#e06c75
hi! link SpellCap SpellBad
hi! link SpellLocal SpellBad
hi! link SpellRare SpellBad

hi illuminatedWord guifg=none   guibg=none      gui=underline
