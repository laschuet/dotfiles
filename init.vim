syntax on

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
set termguicolors
set updatetime=1000

call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'arcticicestudio/nord-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jpalardy/vim-slime'
    Plug 'tpope/vim-surround'
call plug#end()

colorscheme nord

let g:slime_target='tmux'
let g:slime_default_config={'socket_name': get(split($TMUX, ","), 0), 'target_pane': ':.1'}
let g:slime_dont_ask_default=1
