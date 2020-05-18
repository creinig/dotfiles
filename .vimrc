" vim: foldmethod=marker

set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins {{{
" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle')

" under the hood / automatic behavior / libraries
Plug 'tpope/vim-repeat'      " make complex operations repeatable
Plug 'tpope/vim-sleuth'      " auto-detect indent settings
Plug 'kana/vim-textobj-user' " define custom textobjects
Plug 'Raimondi/delimitMate'  " auto-close quotes, brackets etc

" UI modules
Plug 'lifepillar/vim-cheat40'  " show foldable cheatsheet with <leader>?
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'     " file manager
Plug 'tpope/vim-fugitive'      " git integration
Plug 'gcmt/taboo.vim'          " tab handling

" commands / operations / motions
Plug 'tpope/vim-surround'      " surround text with quotes etc
Plug 'junegunn/vim-easy-align' " vertically align text
Plug 'junegunn/fzf'            " fuzzy finder and commands making use of it
Plug 'junegunn/fzf.vim'
Plug 'creinig/ListToggle'      " commands to toggle location & quickfix list

" Coding helpers
if has("python3") " cygwin / babun has some problems there"
  Plug 'SirVer/ultisnips'        " snippet engine
endif
Plug 'honza/vim-snippets'      " snippet collection
Plug 'dense-analysis/ale'      " syntax checking + linting (async)
Plug 'preservim/nerdcommenter' " (un) comment lines

" language / syntax plugins
Plug 'mtdl9/vim-log-highlighting'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sukima/vim-tiddlywiki'
Plug 'fatih/vim-go'

" All of your Plugins must be added before the following line
call plug#end()            " required
" }}}



" https://vim.fandom.com/wiki/Page_up/down_and_keep_cursor_position
map <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
map <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>

" From 'Practical Vim' p101
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Start interactive EasyAlign in visual mode (e.g. vipea)
xmap ea <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ea <Plug>(EasyAlign)

" Open NERDTree if vim is started with a directory as parameter
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | exe 'NERDTreeFocus' | endif

map <C-n> :NERDTreeToggle<CR>

if has("python3")
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
endif


" ale integration for airline
let g:airline#extensions#ale#enabled = 1
" ale navigation shortcuts
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" tiddlywiki syntax settings
let g:tiddlywiki_autoupdate = 1

" settings for taboo.vim
let g:taboo_tab_format = ' %N: %f%m '
let g:taboo_renamed_tab_format = ' [%N: %l]%m '

"
" Use "<Space>" as Leader and define a bunch of mappings for it
"
let mapleader = " "

" Mappings for fzf.vim {{{
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fs :Snippets<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>f/ :History/<CR>
nnoremap <leader>f: :History:<CR>
nnoremap <leader>f? :Helptags<CR>
" }}}


" Mappings for git (mainly fugitive.vim) {{{
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gc :Gcommit<space>
nnoremap <leader>gh :Commits<space>
nnoremap <leader>gH :BCommits<space>
nnoremap <leader>gp :Gpush<space>
nnoremap <leader>gf :Gfetch<space>
nnoremap <leader>gl :Gpull<space>
nnoremap <leader>gL :Glog<space>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiffsplit<space>
" }}}

" utility functions / macros {{{
" remove all trailing whitespace in the file
nnoremap <leader>uw :%s/\s\+$//<cr>:let @/=''<CR>
" redraw screen, de-highlight searches, fix syntax highlighting
nnoremap <leader>ul :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" pipe the current selection into xclip
vnoremap <leader>uc "yy <Bar> :call system('xclip', @y)<Cr>
" }}}

" Shortcuts for editing common files in a vsplit {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>es :vsplit ~/.shellrc<cr>
" }}}

" option toggles / changes {{{
"   toggle relative / absolute line numbers
nnoremap <leader>or :set invrelativenumber<CR>
nnoremap <leader>on :set invnumber<CR>
"   toggle current line highlighting
nnoremap <leader>oc :set invcursorline<CR>
"   switch between folding styles
nnoremap <leader>ofn :set foldmethod=manual<CR>zR
nnoremap <leader>ofm :set foldmethod=marker<CR>zR
nnoremap <leader>ofi :set foldmethod=indent<CR>zM
nnoremap <leader>ofs :set foldmethod=syntax<CR>zM
" increase / decrease split width  to 5/4 / 4/5
nnoremap <silent> <leader>o+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> <leader>o- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>
" toggles and navigation for quickfix and location list
nnoremap <leader>ll :LToggle<Cr>
nnoremap <leader>ln :lnext<Cr>
nnoremap <leader>lp :lprev<Cr>
nnoremap <leader>cl :QToggle<Cr>
nnoremap <leader>cn :cnext<Cr>
nnoremap <leader>cp :cprev<Cr>
" }}}

" open tiddlywiki in a split window
nnoremap <leader>tv :vs<cr>:lcd<space>~/wiki/<cr>:Files<cr>

" Some remappings for better accessibility
nmap >c ]c
nmap <c [c
inoremap jj <ESC>



syntax on
colo creinig

" Options {{{

" from https://github.com/mhinz/vim-galore/blob/master/static/minimal-vimrc.vim
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

" Fix indenting for some filetypes where it is not enabled
autocmd FileType groovy     setlocal smartindent
autocmd FileType conf       setlocal smartindent
autocmd FileType tiddlywiki setlocal wrap

" https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

set nowrap     " a more sensible default for me
set linebreak  " where wrappung is used, do it right
set showcmd    " Useful e.g. for seeing that the leader is active
set encoding=utf-8
set ttyfast    " Faster redrawing.
set lazyredraw " Only redraw when necessary.

" set timeout for escape seqs very small to make vim more responsive
set timeout           " for mappings
set timeoutlen=1000   " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value

set colorcolumn=80
set history=200
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

" highlight current line in active window, but not in insert mode
" update: disabled because this makes the ui very sluggish
"autocmd InsertLeave,WinEnter * set cursorline
"autocmd InsertEnter,WinLeave * set nocursorline

set wrapscan               " Searches wrap around end-of-file.
set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.


" let ex completion behave similar to zsh
set wildmenu
set wildmode=full

set ignorecase
set smartcase
set formatoptions=crql
" }}}

" Put all temporary files under the same directory. {{{
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
" create directory if needed
if !isdirectory($HOME.'/.vim/files/backup') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/backup', 'p')
endif
if !isdirectory($HOME.'/.vim/files/swap') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/swap', 'p')
endif
if !isdirectory($HOME.'/.vim/files/undo') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/undo', 'p')
endif
if !isdirectory($HOME.'/.vim/files/info') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/info', 'p')
endif
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
" configure .viminfo handling. Used settings:
" ': number of files for which marks are stored
" n: file name
" <: Max number of lines per stored register
" s: max size of registers in kbyte
if !has('nvim')
  set viminfo     ='100,<50,s20,n$HOME/.vim/files/info/viminfo
else
  set viminfo     ='100,<50,s20,n$HOME/.vim/files/info/shada
endif
" }}}


" Return to last cursor position when opening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

" source ~/.vim/.local.post.vim , typically containing things that overwrite
" settings of this main .vimrc
runtime .local.vim

