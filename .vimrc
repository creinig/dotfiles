set nocompatible              " be iMproved, required
set nobackup
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
"Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colo elflord
syntax on

