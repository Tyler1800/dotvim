execute pathogen#infect()
syntax on

set number
set relativenumber
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

function! NumberToggle()
    set relativenumber!
endfunc

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
nnoremap <F8> :call NumberToggle()<cr>


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

"syntastic

let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options='-std=c++14'

"Jedi

let g:pymode_rope_complete_on_dot = 0

"YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/plugin-config/.ycm_extra.conf.py'

"method-stub

augroup cppauto 
au! 
au FileType c,cpp call <SID>CppBufferInit()
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '.'
au! BufEnter *.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '.'
augroup END

augroup yamlauto
    au!
    au FileType yaml call <SID>YamlBufferInit()
augroup END

autocmd InsertEnter * silent! :set norelativenumber
autocmd InsertLeave * silent! :set relativenumber

function! s:CppBufferInit()
    nnoremap <buffer> <Leader>rfs :GenFnStub<CR>
    nnoremap <buffer> <Leader>rfi :GenFnStub 1<CR>
    xnoremap <buffer> <Leader>rfs :GenFnStubRange 0<CR>
    xnoremap <buffer> <Leader>rfi :GenFnStubRange 1<CR>
    nnoremap <silent> <buffer> <Leader>of :FSHere<CR>
    nnoremap <silent> <buffer> <Leader>ol :FSRight<CR>
    nnoremap <silent> <buffer> <Leader>oh :FSLeft<CR>
endfunction

function! s:YamlBufferInit()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
endfunction

