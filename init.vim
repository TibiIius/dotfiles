" Basic stuff
set nocompatible
syntax on
set encoding=utf-8
set number relativenumber
set clipboard+=unnamedplus " Ditches Vim's clipboard and uses the OS one

" Search settings
set hlsearch
set ignorecase
set smartcase
set incsearch

" Tab sizes
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

"Plug init
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'aymericbeaumet/vim-symlink'
call plug#end()

" Airline config
let g:airline_theme='angr'
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#nerdtree_status = 1
