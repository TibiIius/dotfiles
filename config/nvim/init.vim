" Basic stuff
set nocompatible
syntax on
set encoding=utf-8
set number relativenumber " Number of current line + relative number of other lines
set clipboard+=unnamedplus " Ditches Vim's clipboard and uses the OS's one
set mouse=a " Be a heretic and use mouse support :)

let g:startify_custom_header=[
    \ '    __     __ ___  __  __',
    \ '    \ \   / /|_ _||  \/  |',
    \ '     \ \ / /  | | | |\/| |',
    \ '      \ V /   | | | |  | |',
    \ '       \_/   |___||_|  |_|',
    \ ]





" Search settings
set hlsearch " Highlights searched elements
set ignorecase
set smartcase " Only case-sensitive when search includes upper-case characters
set incsearch " Start searching as you type

" Tab sizes
set tabstop=2
set shiftwidth=2
set expandtab

if !exists('g:vscode') " Only do if not in VScode mode
	" Plug init
	call plug#begin('~/.vim/plugged')
  Plug 'nekonako/xresources-nvim'
  Plug 'junegunn/fzf'
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
	Plug 'lervag/vimtex'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'kaicataldo/material.vim', { 'branch': 'main' }
	Plug 'mhinz/vim-startify'
	call plug#end()

	" Set colorscheme
  let g:material_theme_style = 'darker'
	colorscheme material  
	if has("termguicolors") " set true colors
		set t_8f=\[[38;2;%lu;%lu;%lum
		set t_8b=\[[48;2;%lu;%lu;%lum
		set termguicolors
	endif

	" General config
	let g:tex_flavor = "latex"
	let g:vimtex_view_general_viewer = 'zathura'

	" Airline config
	let g:airline_theme='wombat'
	let g:airline#extensions#branch#enabled = 1
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#nerdtree_status = 1
	let g:airline#extensions#tabline#enabled = 1

	" UltiSnippets
	let g:UltiSnipsExpandTrigger="<c-q>"
	let g:UltiSnipsJumpForwardTrigger = '<c-q>'

  " Some keybinds
  map <C-p> :FZF<enter>

  " Additional coc config
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-json', 
    \ 'coc-vimtex', 
    \ ]

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " open NERDTree automatically
  " if no args are passed, Startify is started
  " wincmd to move focus away from NERDTree
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | else
              \ |   NERDTree
              \ |   wincmd w
              \ | endif

endif
