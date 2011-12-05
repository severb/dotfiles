" vim: foldmarker={,} foldlevel=0 foldmethod=marker spell

" Author (more or less) Sever Banesiu <banesiu.sever@gmail.com>

" Loading {

" Autoload from bundle
call pathogen#runtime_append_all_bundles()

" }

" Bindings {

" I'm using Dvorak and , is a very handy mapleader.
let mapleader = ","

" Use ,t to open Taglist
nnoremap <leader>t :NERDTreeToggle<CR>

" Use ,f to open FuzzyFinder
nnoremap <leader>f :FufFileWithCurrentBufferDir<CR>

" Comment and uncomment lines of code with this search and replace expression.
" This uses a positive lookahead. How cool is that!?
noremap <leader># :s/^\([\t\ ]*[^\ \t#]\+\)\&/#\ /<cr>
" And here we replace by reusing a group.
noremap <leader>3 :s/^\([\t\ ]*\)#\ \?/\1/<cr>

" Find the word under the cursor in subdirs files using the regex: /\(^\|[^a-zA-Z0-9_]\)word\([^a-zA-Z0-9_]\|$\)/
map <leader>fw :exec "vimgrep /\\(^\\\\|[^a-zA-Z0-9_]\\)".expand("<cword>")."\\([^a-zA-Z0-9_]\\\\|$\\)/j ./**/*.\\(py\\\\\\|c\\\\\\|java\\)"<CR>:cw<CR><C-w>j
" Find the definition of the method/class under the cursor in python sources.
map <leader>fd :exec "vimgrep /\\(def\\\\|class\\) ".expand("<cword>")."(/j ./**/*.py"<CR>:cw<CR><C-w>j

" Ues ,a for quick ack.
nnoremap <leader>a :Ack 


" Automatically use Python like regex when searching.
nnoremap / /\v
vnoremap / /\v

" Use ,<space> to clear search highlight.
nnoremap <leader><space> :noh<cr>

" Use <tab> to move between bracket pairs.
nnoremap <tab> %
vnoremap <tab> %

" Use ,W to remove tailing spaces.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

noremap  <F1> <nop>
inoremap <F1> <nop>

" }

" Basic {

" Add support for 256 color terminal
set t_Co=256
" This adds persistent undo to vim.
set undofile
set undoreload=10000
set colorcolumn=80
set nocompatible
set backup
set noswapfile
set hlsearch
set incsearch
set ignorecase
set nowrap
set foldenable
set helplang=En
set history=1024
set undolevels=1024 " use all the undos ever.
set background=dark
set hlsearch " Don't keep the search results highlighted. I hate that.
set title
set shiftwidth=4
set expandtab
set tabstop=8
set encoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set nocursorline
set ttyfast
set nonumber
set norelativenumber
set cpoptions+=J " Sentence followed by two spaces.
set lazyredraw
set splitbelow
set splitright
set notimeout
set nottimeout
set autoread
set dictionary=/usr/share/dict/words
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
syntax on
filetype on
filetype plugin on
filetype plugin indent on
compiler pyunit
colors molokai

" }

" Advanced {

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
set hidden " Allow buffers to be changed even if they contain changes.
set noexrc " Don't try to load some configuration files.
set backspace=indent,eol,start " This is supposed to make backspace more flexible.
set keymodel= " I don't want to select using Shift + End or the like.
set showmatch " Show matching parenthesis
set smartcase " Ignore case if search pattern is all lowercase,
set gdefault " By default use a global replace instead of line replace
set ruler " Shows the line and col number. Can be customized.
set selection=exclusive " When selecting from right to left, the last char isn't included.
set selectmode= " Why do I need a Select mode?
set wildignore=*.pyc,*~,*.pyw,.hg,.svn,.git,*.swp,*.bak " What to ignore when search a filename.
set wildmode=list:full " How to display the file list when searching.
" No damn visual, audio or error bell.
set noerrorbells
set novisualbell
set vb t_vb=".
set clipboard+=unnamed " Share clipboard with Windows. Aww...
set iskeyword+=_ " Underscore is part of a word in my world.
set laststatus=2 " Always display status line.
set linespace=0 " No empty spaces between the rows.
set list " Show whitespaces so I can remove them, doo'h!
set listchars=tab:·\ ,eol:¬,trail:»
set matchtime=3 " Blinks the matching bracket.
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v] " Don't ask!

" }

" GUI {

if has("gui_running")
	"set guifont=Monaco:h9:cANSI
	" There are a bunch of options here, I don't want most of them.
	" This hides everything uses simple dialogues as opposed to pop-ups and uses GUI tabs for tabs.
	set guioptions=ce
	highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif

" }

" Autocmds {

" Set the correct filetype for go language files.
au BufRead,BufNewFile *.go set filetype=go

" }

" Extension configurations {

let g:vimwiki_list = [{'path': '~/.dotfiles/wiki', 'path_html': '~/wikihtml/'}]
let g:ackprg = "ack-grep -H --nocolor --nogroup --column"
let g:pyflakes_use_quickfix = 0
au BufNewFile,BufRead *.less set filetype=less

" }

" Shell {

function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 

" }
