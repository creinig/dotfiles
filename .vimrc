set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'lifepillar/vim-cheat40'
Plugin 'kana/vim-textobj-user'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'tpope/vim-sleuth'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdtree'
Plugin 'preservim/nerdcommenter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" language / syntax plugins
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'mustache/vim-mustache-handlebars'

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
nnoremap <leader>fh :History<CR>
nnoremap <leader>fs :Snippets<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fC :BCommits<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>

" Mappings for fugitive.vim
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gc :Gcommit<space>
nnoremap <leader>gp :Gpush<space>
nnoremap <leader>gf :Gfetch<space>
nnoremap <leader>gl :Gpull<space>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiffsplit<space>

" utility shortcuts
"   remove all trailing whitespace in the file
nnoremap <leader>uw :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>un :set invrelativenumber<CR>


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
autocmd FileType groovy setlocal smartindent
autocmd FileType conf   setlocal smartindent

" https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

set nowrap  "a more sensible default for me
set showcmd "Useful e.g. for seeing that the leader is active
set encoding=utf-8
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set colorcolumn=80
set history=200
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
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
