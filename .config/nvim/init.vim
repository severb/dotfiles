" Plugin loading
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'severb/monoacc'
Plug 'neomake/neomake'
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'janko-m/vim-test'
Plug 'unblevable/quick-scope'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'majutsushi/tagbar'
call plug#end()


" General cfg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin indent on
colorscheme monoacc

set smartcase
set colorcolumn=79
set splitbelow
set splitright
set number
set cursorline
set showcmd
set listchars=tab:·\ ,eol:¬,trail:»
set list
set title
set background=dark
set linebreak

" Kill the bells
set noerrorbells
set novisualbell
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=
set vb t_vb=".

" Auto-resize splits on window resize
au VimResized * exe "normal! \<c-w>="

" Use system clipboard
set clipboard=unnamed


" Plugin cfg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme = 'monochrome'

let g:deoplete#enable_at_startup = 1

" tunned for monoacc theme
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_first_occurrence_highlight_color = 105
let g:qs_second_occurrence_highlight_color = 252

let g:incsearch#auto_nohlsearch = 1
" search uses Python regex like syntax
let g:incsearch#magic = '\v' " very magic

" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set a better leader for Dvorak layout
let mapleader = ","

" Bind Q to formatting instead of entering Ex-mode
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

noremap  <F1> <nop>
inoremap <F1> <nop>

" Remap everything to use incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
