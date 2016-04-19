filetype off

"Load vim-plug if it is not already installed (Necessary for all further
"plugin loading
if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !python2 ./install.py --clang-completer --racer-completer
    endif
endfunction

call plug#begin('~/.vim/plug')
    Plug 'easymotion/vim-easymotion' 
    Plug 'tpope/vim-vividchalk'
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
    Plug 'SirVer/ultisnips'
    Plug 'vim-airline/vim-airline'
    Plug 'kana/vim-altr', { 'on': '<plug>(altr-forward)' }
    Plug 'tpope/vim-fugitive'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'mbbill/undotree'
    Plug 'rust-lang/rust.vim'
    Plug 'nathanaelkane/vim-indent-guides'

    Plug 'Shougo/unite.vim'
    Plug 'Shougo/neomru.vim'

    Plug 'tylerreisinger/vim-methodstub'
call plug#end()

filetype plugin indent on
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
set smarttab
set updatetime=500

set formatoptions+=j
set laststatus=2
set display+=lastline

set scrolloff=1
set sidescrolloff=3

set splitbelow
set splitright

set wildmenu
set wildmode=longest:full,full

set hlsearch
set incsearch

"Don't treat numbers with leading 0s as octal
set nrformats=hex

set spell spelllang=en_us

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

"clang-format
nnoremap <leader>rs :pyf /usr/share/clang/clang-format.py<CR>
vnoremap <leader>rs :pyf /usr/share/clang/clang-format.py<CR>

"rainbow-parenthesis
nnoremap <F9> :RainbowParenthesesToggle<CR>

"indent guides
nnoremap <F5> :IndentGuidesToggle<CR>
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=233 guibg=#121212
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234 guibg=#1c1c1c

"airline

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''

"ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

"altr
nmap <Leader>o <Plug>(altr-forward)
nmap <Leader>p <Plug>(altr-back)

"unite.vim
call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_source_history_yank_enable = 1

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'no_split': 1
\ })

"Define a prefix for all unite commands
nnoremap [unite] <Nop>
nmap <space> [unite]

nnoremap [unite]b :<C-u>Unite -buffer-name=Buffers buffer<cr>
nnoremap [unite]f :<C-u>Unite -buffer-name=files file<cr>
nnoremap [unite]r :<C-u>Unite -quick-match -buffer-name=mru file_mru<cr>
nnoremap [unite]q :<C-u>Unite -quick-match -buffer-name=files register<cr>
nnoremap [unite]o :<C-u>Unite -buffer-name=files buffer file_rec<cr>
nnoremap [unite]ma :<C-u>Unite -buffer-name=mapping mapping<cr>
nnoremap [unite]me :<C-u>Unite -buffer-name=message output:message<cr>
nnoremap [unite]s :<C-u>Unite -buffer-name=message source<cr>


function! s:unite_buffer_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer><C-j> <Plug>(unite_select_next_line)
  imap <buffer><C-k> <Plug>(unite_select_previous_line)
endfunction

autocmd FileType unite call s:unite_buffer_settings()

"undotree
nnoremap <F6> :<C-u>UndotreeToggle<CR>

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
endfunction

function! s:YamlBufferInit()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
endfunction

