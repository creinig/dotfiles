set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" under the hood / automatic behavior / libraries
Plugin 'tpope/vim-repeat'      " make complex operations repeatable
Plugin 'tpope/vim-sleuth'      " auto-detect indent settings
Plugin 'kana/vim-textobj-user' " define custom textobjects
Plugin 'Raimondi/delimitMate'  " auto-close quotes, brackets etc

" UI modules
Plugin 'lifepillar/vim-cheat40'  " show foldable cheatsheet with <leader>?
Plugin 'vim-airline/vim-airline' " status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'     " file manager
Plugin 'tpope/vim-fugitive'      " git integration

" commands / operations / motions
Plugin 'tpope/vim-surround'      " surround text with quotes etc
Plugin 'junegunn/vim-easy-align' " vertically align text
Plugin 'junegunn/fzf'            " fuzzy finder and commands making use of it
Plugin 'junegunn/fzf.vim'

" Coding helpers
Plugin 'SirVer/ultisnips'        " snippet engine
Plugin 'honza/vim-snippets'      " snippet collection
Plugin 'vim-syntastic/syntastic' " syntax checking + linting
Plugin 'preservim/nerdcommenter' " (un) comment lines

" language / syntax plugins
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'sukima/vim-tiddlywiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required




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


" basic settings for syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


"
" Use "<Space>" as Leader and define a bunch of mappings for it
"
let mapleader = " "

" Mappings for fzf.vim
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


" Mappings for git (mainly fugitive.vim)
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

" utility shortcuts
"   remove all trailing whitespace in the file
nnoremap <leader>uw :%s/\s\+$//<cr>:let @/=''<CR>
" toggle relative / absolute line numbers
nnoremap <leader>ur :set invrelativenumber<CR>
nnoremap <leader>un :set invnumber<CR>
" redraw screen, de-highlight searches, fix syntax highlighting
nnoremap <leader>ul :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" open tiddlywiki in a split window
nnoremap <leader>tv :vs<cr>:lcd<space>~/wiki/<cr>:Files<cr>
nnoremap <leader>te :lcd<space>~/wiki/<cr>:Files<cr>


" Some remappings for better accessibility
nmap >c ]c
nmap <c [c



syntax on
colo creinig

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
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

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

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
" create directory if needed
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo



" Return to last cursor position when opening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
