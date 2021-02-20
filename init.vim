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

set completeopt=menuone,noinsert,noselect
set shortmess+=c

call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'arcticicestudio/nord-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jpalardy/vim-slime'
    Plug 'JuliaEditorSupport/julia-vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'reedes/vim-pencil'
    Plug 'tpope/vim-surround'
call plug#end()

colorscheme nord

lua << EOF
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text=false,
            signs=true,
            update_in_insert=true,
        }
    )
    local lspconfig = require'lspconfig'
    local on_attach_vim = function(client)
        require'completion'.on_attach(client)
    end
    lspconfig.julials.setup({on_attach=on_attach_vim})
EOF

let g:slime_target='tmux'
let g:slime_default_config={'socket_name': get(split($TMUX, ","), 0), 'target_pane': ':.1'}
let g:slime_dont_ask_default=1

let g:completion_timer_cycle=250
let g:completion_matching_ignore_case=1

augroup pencil
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd FileType text call pencil#init()
    autocmd FileType tex call pencil#init()
augroup END

function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
endfunction

function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=1
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)
