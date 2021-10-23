" Plugins

call plug#begin('D:\Softwares\nvim-win64\Neovim\share\nvim\plugged')

"" UI plugins
Plug 'overcache/NeoSolarized'
  set termguicolors

Plug 'itchyny/lightline.vim'
  set laststatus=2
  let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

Plug 'ryanoasis/vim-devicons'
  " loading the plugin
  let g:webdevicons_enable = 1
  let g:webdevicons_enable_nerdtree = 1

"" File manager
Plug 'preservim/nerdtree'
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  nnoremap <leader>n :NERDTreeFocus<CR>
  nnoremap <C-n> :NERDTree<CR>
  nnoremap <C-t> :NERDTreeToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>

call plug#end()

set encoding=UTF-8

" Spaces & tabs
set tabstop=2	          " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs are spaces

" Ui config
set number              " show line numbers
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set shiftwidth=2        " automatic indent space
colorscheme NeoSolarized
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

" Coding 

function Compile()
  if &filetype ==# 'cpp'
    exec "!g++ % -o %< -g -DLOCAL -Wall -Wextra -Wconversion -std=c++11"
  endif
endfunction

map <c-o> : call Compile() <CR>

" vim:foldmethod=marker:foldlevel=0
"
