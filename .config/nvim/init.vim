call plug#begin('~/.local/share/nvim/plugged')

" color schemes
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'majutsushi/tagbar'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'RRethy/vim-illuminate'

call plug#end()

let mapleader = " "

" include highlight clear in redraw
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:onedark_terminal_italics = 1
" colorscheme OceanicNext
" colorscheme onedark
colorscheme xor
let g:airline_theme='onedark'

set splitright            "open vertical splits on the right
set splitbelow            "open horizontal splits below
set hidden                "don't warn if a buffer has changes before becomming hidden
set cursorline            "highlight current line
set ignorecase            "ignore case in search (used w/ smartcase)
set smartcase             "case sensitive search when uppercase chars are used
set nowrap                "don't wrap lines
set clipboard=unnamedplus "copy to CLIPBOARD
set mouse=a               "enable mouse in all modes
set colorcolumn=80        "show 80 columns limit

let g:netrw_liststyle=3 "list tree style
let g:netrw_banner=0    "disable top banner

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_min_count=2     "show only if more than a tab is open
let g:airline#extensions#tabline#tab_nr_type=1       "show tab number (instead of splits count)
let g:airline#extensions#tabline#show_buffers=0      "don't show buffer bar
let g:airline#extensions#tabline#show_splits=0       "don't show splits bar
let g:airline#extensions#tabline#show_tab_type=0     "don't show the type (only tabs are enabled)
let g:airline#extensions#tabline#show_close_button=0 "don't show close button

" make * and # work in visual mode
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! SearchVisualSelectionWithRg() range
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
vnoremap <silent> <leader>* :call SearchVisualSelectionWithRg()<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>

" show fullscreen preview for files
command! -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), 1)
"
" show fullscreen preview for git files
command! -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), 1)

"preserve the flags when repeating substitutions
nnoremap & :&&<CR>
xnoremap & :&&<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_autosave = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'c': ['clangd-8'],
    \ 'cpp': ['clangd-8'],
    \ 'go': ['gopls'],
    \ }

augroup LanguageClient_config
  autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStarted setlocal formatexpr=LanguageClient#textDocument_rangeFormatting()
    autocmd User LanguageClientStopped setlocal signcolumn=auto
    autocmd User LanguageClientStopped setlocal formatexpr=""
augroup END
let g:LanguageClient_useVirtualText = 1
let g:LanguageClient_completionPreferTextEdit = 1
let g:LanguageClient_hoverPreview = "Always"
nnoremap K :call LanguageClient_contextMenu()<CR>
