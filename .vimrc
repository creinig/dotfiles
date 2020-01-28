set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kana/vim-textobj-user'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'tpope/vim-sleuth'
Plugin 'junegunn/vim-easy-align'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdtree'
Plugin 'preservim/nerdcommenter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'

" ultisnips requires python3, which is not supported in vim under termux
if has("python3")
    " Track the engine.
    Plugin 'SirVer/ultisnips'
else
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
endif

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

"Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" https://vim.fandom.com/wiki/Indenting_source_code
set expandtab
set shiftwidth=4
set softtabstop=4
" Fix indenting for some filetypes where it is not enabled
autocmd FileType groovy setlocal smartindent
autocmd FileType conf   setlocal smartindent

" https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

" https://vim.fandom.com/wiki/Page_up/down_and_keep_cursor_position
map <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
map <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>

" From 'Practical Vim' p101
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Start interactive EasyAlign in visual mode (e.g. vipga)
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
nnoremap <leader>fm :Maps<CR>

" Mappings for fugitive.vim
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gc :Gcommit
nnoremap <leader>gp :Gpush
nnoremap <leader>gf :Gfetch
nnoremap <leader>gl :Gpull
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

" utility shortcuts
"   remove all trailing whitespace in the file
nnoremap <leader>uw :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>un :set invrelativenumber<CR>

syntax on
colo creinig

set nowrap  "a more sensible default for me
set showcmd "Useful e.g. for seeing that the leader is active
set nobackup
set encoding=utf-8
set ttyfast
"set relativenumber " slows down vim. See leader mapping for toggle above
set colorcolumn=80
set history=200

" let ex completion behave similar to zs
set wildmenu 
set wildmode=full

set ignorecase
set smartcase
set formatoptions=crql
