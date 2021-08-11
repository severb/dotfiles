call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'

call plug#end()

let mapleader = " "

" include highlight clear in redraw
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set termguicolors

colorscheme xor

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
set updatetime=100        "typing pause for swap file and CusorHold event, used by gitgutter

let g:netrw_liststyle=3  "list tree style
let g:netrw_dirhistmax=0 "don't keep a history
let g:netrw_banner=0     "disable top banner

" make * and # work in visual mode
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Use ctrl-c to exit insert mode
inoremap <C-c> <Esc>

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

" briefly highlight yanked text
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" completion-nvim config
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << LSPCFG
local nvim_lsp = require('lspconfig')
local completion = require('completion')

local on_attach = function(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', 'gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  completion.on_attach()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'rust_analyzer', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

LSPCFG

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()

