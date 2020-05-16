" Basic stuff
set nocompatible
syntax on
set encoding=utf-8
set number relativenumber
set clipboard+=unnamedplus " Ditches Vim's clipboard and uses the OS's one

" Search settings
set hlsearch
set ignorecase
set smartcase
set incsearch

" Tab sizes
set tabstop=2
set shiftwidth=2

" Plug init
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'aymericbeaumet/vim-symlink'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Set colorscheme
colorscheme gruvbox

" Airline config
let g:airline_theme='angr'
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#nerdtree_status = 1
