execute pathogen#infect()
syntax on

set number
set foldmethod=indent
set foldlevel=99
set hidden
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set splitbelow
set splitright

set wildmenu
set wildmode=longest:full,full

set hlsearch
set incsearch

"Don't treat numbers with leading 0s as octal
set nrformats=hex

filetype plugin on
filetype plugin indent on

colorscheme vividchalk

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

"slime
let g:slime_target = "tmux"
let g:slime_no_mappings = 1

xmap <Leader><C-c><C-c> <Plug>SlimeRegionSend

nmap <Leader><C-c><C-c> <Plug>SlimeParagraphSend
nmap <Leader><C-c><C-l> <Plug>SlimeLineSend
nmap <Leader><C-c><C-m> <Plug>SlimeMotionSend
nmap <Leader><C-c><C-g> <Plug>SlimeSendOp

"clang_complete

let g:clang_complete_auto=1
let g:clang_use_library=1

let g:clang_user_options='-std=c++1y'
let g:clang_auto_select=1

"syntastic

let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options='-std=c++14'

"method-stub

augroup cppauto 
au! 
au FileType c,cpp call <SID>CppBufferInit()
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.'
au! BufEnter *.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '.'
augroup END

function! s:CppBufferInit()
    nnoremap <buffer> <Leader>rfs :GenFnStub<CR>
    nnoremap <buffer> <Leader>rfi :GenFnStub 1<CR>
    xnoremap <buffer> <Leader>rfs :GenFnStubRange 0<CR>
    xnoremap <buffer> <Leader>rfi :GenFnStubRange 1<CR>
    nnoremap <silent> <buffer> <Leader>of :FSHere<CR>
    nnoremap <silent> <buffer> <Leader>ol :FSRight<CR>
    nnoremap <silent> <buffer> <Leader>oh :FSLeft<CR>
endfunction
