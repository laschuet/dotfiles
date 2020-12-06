syntax on
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set number
set scrolloff=1
set shiftwidth=4
set smartcase
set tabstop=4

call plug#begin('~/.vim/plugged')
    Plug 'arcticicestudio/nord-vim'
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

colorscheme nord
