:set number
":set relativenumber
:set clipboard+=unnamedplus
:set termguicolors

call plug#begin()

Plug 'catppuccin/nvim',
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'lilydjwg/colorizer'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"set background="dark0_hard"
colorscheme catppuccin-mocha
highlight Normal ctermbg=none guibg=none

"let g:airline_powerline_fonts = 1

let g:lightline = {'colorscheme': 'catppuccin'}
nnoremap <C-b> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
