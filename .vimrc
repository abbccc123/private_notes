set nocompatible

source $VIMRUNTIME/defaults.vim

if &term == "screen" || &term == "screen-256color"
  set t_Co=256
  syntax on
  set background=dark
endif

if $TERM == 'linux'
  colorscheme blue
else
  colorscheme retrobox
endif

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
"Plug 'ayu-theme/ayu-vim'
"Plug 'vim-airline/vim-airline'
"Plug 'luochen1990/rainbow'
"Plug 'maralla/completor.vim'
Plug 'morhetz/gruvbox'

call plug#end()

set number
filetype plugin on

set termguicolors
set t_Co=256
"let ayucolor='light'
set background=light
" colorscheme ayu
" colorscheme retrobox
" colorscheme retrobox

let g:rainbow_active=1

set wildmenu
set guifont=Source\ Code\ Pro\ Medium\ 13
"set cindent tabstop=2
set cindent shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch
set incsearch
set scrolloff=99
set showcmd
set backup
set splitbelow
set splitright
set nohlsearch
set belloff=all
set cursorcolumn
set cursorline
set showmatch
set tags+=~/.vim/systags
set completeopt+=menuone
set path+=/usr/include/c++/13.2.1
set ignorecase smartcase
set nowrap
set list
set listchars=tab:\|.
set hlsearch
set conceallevel=0
set nohidden
set path+=/usr/include/**
set dictionary=/usr/share/dict/words
set laststatus=2
set confirm

set backup
set patchmode=.ori

"nnoremap a A
map j gj
map k gk
noremap <F4> <C-C>:w<enter>
noremap <F3> <C-C>:w<enter>
nnoremap <F2> :NERDTreeToggle<enter>
nnoremap <F1> :help<enter>:only!<enter>`"`"
nnoremap <F6> :source~/.vimrc<enter>
nnoremap <F7> :nohlsearch<enter>
nnoremap <F10> :1,$yank +<enter>
nnoremap  2
nnoremap <C-W>f <C-W>f<C-W>L
vmap / y/<C-R>"<CR>
nnoremap <space>l :terminal<enter><C-W>L
nnoremap <space>k :terminal<enter><C-W>K
nnoremap <space>j :terminal<enter><C-W>J
nnoremap <space>h :terminal<enter><C-W>H
nnoremap <space><space> :terminal<enter>

nnoremap <esc>u <c-u>
nnoremap <esc>d <c-d>

nnoremap <esc>c :tabnew<enter>
nnoremap <esc>h :tabprev<enter>
nnoremap <esc>l :tabnext<enter>
nnoremap <F8> :NERDTreeToggle<enter>

" [shortcut] move among windows
nnoremap <tab> <C-w>
tnoremap <tab>h <C-w>h
tnoremap <tab>j <C-w>j
tnoremap <tab>k <C-w>k
tnoremap <tab>l <C-w>l
tnoremap <tab>t <c-w>:terminal<enter>

tnoremap <tab>q <c-d>
tnoremap <tab><tab> <c-w>N

nnoremap K k

" [shortcut] quick save
inoremap <C-C> <C-C>:w<enter>

" [shortcut] new terminal in termianl mode
tnoremap <c-w>t <c-w>:terminal<enter>

autocmd BufNewFile *.cpp 0r ~/.vim/skeleton.cpp
