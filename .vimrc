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
Plug 'tpope/vim-repeat'          " make complex operations repeatable
Plug 'tpope/vim-sleuth'          " auto-detect indent settings
Plug 'kana/vim-textobj-user'     " define custom textobjects
" Plug 'Raimondi/delimitMate'    " auto-close quotes, brackets etc

" UI modules
Plug 'lifepillar/vim-cheat40'    " show foldable cheatsheet with <leader>?
Plug 'vim-airline/vim-airline'   " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'szw/vim-maximizer'         " Toggle to maximize/restore split windows (<F3>)
Plug 'scrooloose/nerdtree'       " file manager
Plug 'tpope/vim-fugitive'        " git integration
Plug 'junegunn/gv.vim'           " better git history browser
Plug 'airblade/vim-gitgutter'    " git info in the gutter
Plug 'gcmt/taboo.vim'            " tab handling
Plug 'mhinz/vim-startify'        " start screen
Plug 'liuchengxu/vim-which-key'  " online help for leader based mappings
Plug 'tpope/vim-dadbod'          " database query helper
Plug 'kristijanhusak/vim-dadbod-ui' " database client UI
Plug 'kristijanhusak/vim-dadbod-completion'

" commands / operations / motions
Plug 'tpope/vim-surround'        " surround text with quotes etc
Plug 'junegunn/vim-easy-align'   " vertically align text
Plug 'junegunn/fzf'              " fuzzy finder and commands making use of it
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'           " comprehensive search over directory hierarchies
Plug 'creinig/ListToggle'        " commands to toggle location & quickfix list
Plug 'AndrewRadev/linediff.vim'  " editable diff between two arbitrary regions
Plug 'will133/vim-dirdiff'       " diff two directory trees
Plug 'easymotion/vim-easymotion' " powerful extension of motions
Plug 'unblevable/quick-scope'    " Highlight good candidates for f/t motions
Plug 'svermeulen/vim-yoink'      " better access to the yank / delete history

" Coding helpers
if has("python3") " cygwin / babun has some problems there"
  Plug 'SirVer/ultisnips'        " snippet engine
endif
Plug 'honza/vim-snippets'        " snippet collection
Plug 'dense-analysis/ale'        " syntax checking + linting (async)
Plug 'preservim/nerdcommenter'   " (un) comment lines

" language / syntax plugins
Plug 'mtdl9/vim-log-highlighting'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sukima/vim-tiddlywiki'
Plug 'rust-lang/rust.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'preservim/tagbar'
Plug 'habamax/vim-asciidoctor'
Plug 'tomtom/tlib_vim'           " required for ttodo_vim
Plug 'tomtom/ttodo_vim'          " todo.txt support

" All of your Plugins must be added before the following line
call plug#end()            " required
" }}}



" https://vim.fandom.com/wiki/Page_up/down_and_keep_cursor_position
map <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
map <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>

" From 'Practical Vim' p101
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

    " Add my custom snippets
    let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/df-snippets']
endif


" ale integration for airline
let g:airline#extensions#ale#enabled = 1
" ale navigation shortcuts
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Use standardrb instead of plain rubocop
let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}

" Change vim-ruby indent to match standardrb
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0

" tiddlywiki syntax settings
let g:tiddlywiki_autoupdate = 1

" settings for taboo.vim
let g:taboo_tab_format = ' %N: %f%m '
let g:taboo_renamed_tab_format = ' [%N: %l]%m '

" settings for NERDCommenter
let g:NERDCreateDefaultMappings=0

" settings for ctrlsf.vim
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_default_root = 'project'

" settings for rust.vim
let g:rustfmt_autosave = 1

" settings for quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:ttodo#dirs = ['~/']
let g:ttodo#sort = 'done,-next,-overdue,pri,due,lists,tags,idx'
let g:ttodo#ftplugin#add_at_eof = 'false'
"let loaded_vifm=1

" Mappings for vim-yoink (Note: the default "c-n" clashes with NERDTree
nmap <c-ä> <plug>(YoinkPostPasteSwapBack)
nmap <c-ö> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this
" case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)


" Use "<Space>" as Leader and define a bunch of mappings for it
"
let mapleader = " "
let maplocalleader = "-"

" setup which_key for all leader mappings
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '-'<CR>
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
autocmd FileType which_key highlight WhichKeyFloating ctermbg=Black

" Mappings for fzf.vim -- prefix f{{{
let g:which_key_map['f'] = {'name' : 'FZF'}
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

" Mappings for Search (crtlsf etc) -- prefix s {{{
let g:which_key_map['s'] = {'name' : 'Search'}
nmap <leader>sf <Plug>CtrlSFPrompt
vmap <leader>sf <Plug>CtrlSFVwordPath
vmap <leader>sF <Plug>CtrlSFVwordExec
nmap <leader>st :CtrlSFToggle<CR>
" }}}

" Mappings for git (mainly fugitive.vim) -- prefix g {{{
let g:which_key_map['g'] = {'name' : 'Git'}
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

" utility functions / macros  -- prefix u {{{
let g:which_key_map['u'] = {'name' : 'Utility'}
" remove all trailing whitespace in the file
nnoremap <leader>uw mw:%s/\s\+$//<cr>:let @/=''<CR>`w
let g:which_key_map.u.w = 'Remove trailing WS'
" redraw screen, de-highlight searches, fix syntax highlighting
nnoremap <leader>ul :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
let g:which_key_map.u.l = 'Redraw and clean up'


" pipe the current selection into xclip/pbcopy
if executable("pbcopy")
  vnoremap <leader>uy "yy <Bar> :call system('pbcopy', @y)<Cr>
  vnoremap <leader>uc "yy <Bar> :call system('pbcopy', @y)<Cr>
else
  vnoremap <leader>uy "yy <Bar> :call system('xclip -selection primary', @y)<Cr>
  vnoremap <leader>uc "yy <Bar> :call system('xclip -selection clipboard', @y)<Cr>
endif
let g:which_key_map.u.y = 'Copy to primary'
let g:which_key_map.u.c = 'Copy to clipboard'


" change the window-local directory to that of the current file
nnoremap <leader>ud :lcd %:p:h<Cr>
let g:which_key_map.u.d = 'cd (local) to current file'
" }}}

" the NERDCommenter mappings I actually use -- prefix c {{{
let g:which_key_map['c'] = {'name' : 'Comments'}
nmap <leader>c<space> <plug>NERDCommenterToggle
xmap <leader>c<space> <plug>NERDCommenterToggle
nmap <leader>cs <plug>NERDCommenterSexy
xmap <leader>cs <plug>NERDCommenterSexy
nmap <leader>c$ <plug>NERDCommenterEOL
" }}}

" Shortcuts for inserting text snippets -- perfix a {{{
let g:which_key_map['a'] = {'name' : 'Insert text snippets'}
let g:which_key_map.a.d = {'name' : 'Dates / Timestamps'}
let g:which_key_map.a.w = {'name' : 'Words / Phrases'}
" Just the date
nnoremap <leader>add "=strftime('%F')<CR>p
let g:which_key_map.a.d.d = 'Date'
" Just the time (HH:MM)
nnoremap <leader>adt "=strftime('%H:%M')<CR>p
let g:which_key_map.a.d.t = 'Time'
" Everything for a journal entry
nnoremap <leader>adj "=strftime('%a, %F, %H:%M')<CR>p
let g:which_key_map.a.d.j = 'Journal entry timestamp'
" Format for my event log
nnoremap <leader>ade "=strftime('%a, %F')<CR>p
let g:which_key_map.a.d.e = 'Event log timestamp'
" Date/Time header in journal
nnoremap <leader>awj "=strftime('! %a, %F, %H:%M, ')<CR>pa
let g:which_key_map.a.w.j = 'Journal header'
" Date header in Event Log
nnoremap <leader>awe "=strftime('* %a, %F')<CR>po
let g:which_key_map.a.w.e = 'Event log header'
" }}}

" Shortcuts for editing common files in a vsplit -- prefix e {{{
let g:which_key_map['e'] = {'name' : 'Edit common files in vsplit'}
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>es :vsplit ~/.shellrc<cr>
" }}}

" option toggles / changes -- prefix o {{{
let g:which_key_map['o'] = {'name' : 'Options'}
"   toggle relative / absolute line numbers
nnoremap <leader>or :set invrelativenumber<CR>
nnoremap <leader>on :set invnumber<CR>
"   toggle soft wrapping
nnoremap <leader>ow :set invwrap<CR>
"   toggle current line highlighting
nnoremap <leader>oc :set invcursorline<CR>
"   switch between folding styles
nnoremap <leader>ofn :set foldmethod=manual<CR>zR
nnoremap <leader>ofm :set foldmethod=marker<CR>zR
nnoremap <leader>ofi :set foldmethod=indent<CR>zM
nnoremap <leader>ofs :set foldmethod=syntax<CR>zM
" increase / decrease split width  to 5/4 / 4/5
nnoremap <silent> <leader>o+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
let g:which_key_map.o['+'] = 'Increase split width'
nnoremap <silent> <leader>o- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>
let g:which_key_map.o['-'] = 'Decrease split width'
" toggles and navigation for quickfix and location list
nnoremap <leader>ll :LToggle<Cr>
nnoremap <leader>ln :lnext<Cr>
nnoremap <leader>lp :lprev<Cr>
nnoremap <leader>cc :QToggle<Cr>
nnoremap <leader>cn :cnext<Cr>
nnoremap <leader>cp :cprev<Cr>
" }}}

" Other shortcuts (different prefixes) {{{
" open tiddlywiki in a split window
nnoremap <leader>tv :vs<cr>:lcd<space>~/wiki/<cr>:Files<cr>
" Change window-local directory to the one of the file being edite
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" }}}

" Cheat sheet
nnoremap <unique> <leader>? :<c-u>Cheat40<cr>

" Some remappings for better accessibility
nmap >c ]c
nmap <c [c
inoremap jj <ESC>

nmap <F8> :TagbarOpenAutoClose<CR>


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
autocmd FileType yaml       setlocal smartindent shiftwidth=2 softtabstop=2

" https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

set nowrap          " a more sensible default for me
set linebreak       " where wrapping is used, do it right
set nostartofline   " Keep cursor in the same column when scrolling vertically (PgUp/PgDown etc)
set showcmd         " Useful e.g. for seeing that the leader is active
set encoding=utf-8
set ttyfast         " Faster redrawing.
set lazyredraw      " Only redraw when necessary.

" set timeout for escape seqs very small to make vim more responsive
set timeout           " for mappings
set timeoutlen=1000   " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value

" make mouse work in tmux
set ttymouse=xterm2
set mouse=a

" set colorcolumn=80 " Not actually useful for me
set history=200
set backspace=indent,eol,start  " Make backspace work as you would expect.
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
set synmaxcol   =400       " Only highlight the first 400 columns.


" let ex completion behave similar to zsh
set wildmenu
set wildmode=full

" Better completion menu settings
set completeopt=menuone,preview,noinsert

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

