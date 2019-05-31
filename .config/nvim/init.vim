call plug#begin('~/.local/share/nvim/plugged')

" color schemes
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

let mapleader = " "

" include highlight clear in redraw
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:onedark_terminal_italics = 1
" colorscheme OceanicNext
colorscheme onedark

set splitright	"open vertical splits on the right
set splitbelow	"open horizontal splits below
set hidden	"don't warn if a buffer has changes before becomming hidden
set cursorline	"highlight current line
set ignorecase	"ignore case in search (used w/ smartcase)
set smartcase	"case sensitive search when uppercase chars are used

let g:netrw_liststyle=3	"list tree style
let g:netrw_banner=0	"disable top banner

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_min_count=2	"show only if more than a tab is open
let g:airline#extensions#tabline#tab_nr_type=1		"show tab number (instead of splits count)
let g:airline#extensions#tabline#show_buffers=0		"don't show buffer bar
let g:airline#extensions#tabline#show_splits=0		"don't show splits bar
let g:airline#extensions#tabline#show_tab_type=0	"don't show the type (only tabs are enabled)
let g:airline#extensions#tabline#show_close_button=0	"don't show close button

" makes * and # work on visual mode
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

" FZF bindigs
nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>L :execute 'BLines ' . expand('<cword>')<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>C :BCommits<CR>

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :Helptags<CR>
nnoremap <silent> <leader>H :Commands<CR>

nnoremap <silent> <leader>* :execute 'Rg ' . expand('<cword>')<CR>
vnoremap <silent> <leader>* :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>

"preserve the flags when repeating substitutions
nnoremap & :&&<CR>
xnoremap & :&&<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
