" Basic stuff
set nocompatible
syntax on
set encoding=utf-8
set number relativenumber " Number of current line + relative number of other lines
set clipboard+=unnamedplus " Ditches Vim's clipboard and uses the OS's one

" Search settings
set hlsearch " Highlights searched elements
set ignorecase
set smartcase " Only case-sensitive when search includes upper-case characters
set incsearch " Start searching as you type

" Tab sizes
set tabstop=2
set shiftwidth=2

if !exists('g:vscode') " Only do if not in VScode mode
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
	Plug 'lervag/vimtex'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'ycm-core/YouCompleteMe'
	call plug#end()

	" Set colorscheme
	colorscheme nord

	" General config
	let g:tex_flavor = "latex"
	let g:vimtex_view_general_viewer = 'zathura'

	" Airline config
	let g:airline_theme='nord'
	let g:airline#extensions#branch#enabled = 1
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#nerdtree_status = 1
	let g:airline#extensions#tabline#enabled = 1

	" UltiSnippets
	let g:UltiSnipsExpandTrigger="<s-q>"
	let g:UltiSnipsJumpForwardTrigger = '<s-q>'

	" Auto brackets etc
	"inoremap " ""<left>
	"inoremap ' ''<left>
	inoremap ( ()<left>
	inoremap [ []<left>
	inoremap { {}<left>

	" YCM snippets
	if !exists('g:ycm_semantic_triggers')
		let g:ycm_semantic_triggers = {}
	endif
	au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
endif
