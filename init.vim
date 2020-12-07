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
set updatetime=1000

call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'arcticicestudio/nord-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-surround'
call plug#end()

colorscheme nord
