" Plugins

call plug#begin('D:\Softwares\nvim-win64\Neovim\share\nvim\plugged')

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"Powerline setting
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1


" Spaces & tabs
set tabstop=2	          " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs are spaces

" Ui config
set number              " show line numbers
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set shiftwidth=2        " automatic indent space
set laststatus=2        " for lightline
syntax enable            " enable syntax processing
filetype indent on      " load filetype-specific indent files

" Leader Shortcut
let mapleader=','       " leader is comma
inoremap jj <esc>

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Folding
set foldenable          " enablefolding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" Key Bindings
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" move windows
nnoremap <space> <c-w>

" highlight last inserted text
nnoremap gV `[v`]

" vim:foldmethod=marker:foldlevel=0
"

