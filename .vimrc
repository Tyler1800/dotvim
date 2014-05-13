execute pathogen#infect()
syntax on

set number
set foldmethod=indent
set foldlevel=99
set hidden
set tabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

set wildmenu
set wildmode=longest:full,full

set hlsearch
set incsearch

filetype plugin on
filetype plugin indent on

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

imap <Left> <Nop>
imap <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <F7> :setlocal spell! spelllang=en_us<CR>

nnoremap <leader>vcl :source $MYVIMRC<CR>
nnoremap <leader>vco :vsplit $MYVIMRC<CR>

"fuzzyfinder
nnoremap <Leader>fb :FufBuffer<CR>
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>ft :FufTag<CR>


let g:clang_complete_auto=1
let g:clang_use_library=1

let g:clang_user_options='-std=c++11'
let g:clang_auto_select=1

colorscheme vividchalk
