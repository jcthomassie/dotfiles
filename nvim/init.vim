" Whitespace
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrap
set backspace=indent,eol,start  " more powerful backspacing

" Style
set number
set ruler

" Plugins
call plug#begin(stdpath('config') . '/.plugins')
Plug 'joshdick/onedark.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

colorscheme onedark

source $DOTS_REPO_ROOT/nvim/mappings.vim
