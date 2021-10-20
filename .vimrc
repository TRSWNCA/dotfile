" Plugins
source ~/.config/vim/plugged.vim

" Spaces & tabs
set tabstop=2	        " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs are spaces

" Ui config
set number              " show line numbers
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set shiftwidth=2        " automatic indent space
set laststatus=2        " for lightline
" set modeline=1
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
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag

" open NerdTree.vim
nnoremap <C-o> :NERDTreeToggle<CR>

" jump to declaraion feature
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" BackUps
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Lightline settings
let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

" Set Colors
colorscheme molokai      " https://github.com/sjl/badwolf/blob/master/colors/badwolf.vim
syntax enable            " enable syntax processing

" vim:foldmethod=marker:foldlevel=0
"
"

" Functions
function Compile()
	if &filetype ==# 'cpp'
		exec "!g++ % -o %< -g -Wall -Wextra -Wconversion -std=c++11"
	elseif &filetype ==# 'c'
		exec "!gcc % -o %< -g -Wall -Wextra -Wconversion"
	elseif &filetype ==# 'tex'
		exec "!xelatex '%'"
	elseif &filetype ==# 'java'
		exec "!javac %"
	endif
endfunction

function Debug()
	if &filetype ==# 'cpp' 
		exec "!lldb ./%<"
	elseif &filetype ==# 'tex'
		exec "!open './%<.pdf'"
	elseif &filetype ==# 'java'
		exec "!jdb %<"
	endif
endfunction

function Run()
	if &filetype ==# 'cpp'
		exec "!time ./%<"
	elseif &filetype ==# 'tex'
		exec "!open -a Preview.app './%<.pdf'"
	elseif &filetype ==# 'java'
		exec "!java %<"
	elseif &filetype ==# 'html'
		exec "!firefox %"
	elseif &filetype ==# 'php'
		exec "!php %"
	elseif &filetype ==# 'sh'
		exec "!bash %"
	endif
endfunction

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif

map <F9> : call Compile() <CR>
map <C-o> : call Compile() <CR>
map <F5> : call Debug() <CR>
map <F6> : call Run() <CR>
map <F2> : ! python3 % <CR>

