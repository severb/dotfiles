call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lsp'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader = " "

" include highlight clear in redraw
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:onedark_terminal_italics = 1
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

" show fzf fullscreen preview for files
command! -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), 1)
"
" show fzf fullscreen preview for git files
command! -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), 1)

"preserve the flags when repeating substitutions
nnoremap & :&&<CR>
xnoremap & :&&<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

lua << LSPCFG

  require'nvim_lsp'.clangd.setup{}

LSPCFG

" LSP config
set completeopt-=preview " disable Preview Window on autocomplete
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>D <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>i <cmd>lua vim.lsp.buf.implementation()<CR>
inoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>R <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>o <cmd>lua vim.lsp.buf.formatting()<CR>
