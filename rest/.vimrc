set nocompatible
syntax on
syntax enable
filetype on
filetype indent on
filetype plugin on
set encoding=utf-8
" set spelllang='en-us'
" set spell=true
set path+=**
set wildmenu
set laststatus=2
set signcolumn=yes

" options
let g:netrw_browse_split=0
let g:netrw_banner=0
let g:netrw_winsize=25
nnoremap - <cmd>Ex<cr>

set number
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set shiftround

set nowrap

set ignorecase
set smartcase
set nohlsearch
set incsearch

set scrolloff=8
set isfname+="@-@"
set updatetime=50
set colorcolumn=80

set backspace="indent,eol,start"

set splitright
set splitbelow

set noswapfile
set nobackup
set undodir=/home/king/.vim/undodir
set undofile


" KEYMAPS:
let g:mapleader=" "
inoremap <C-c> <Esc>
nnoremap x "_x
xnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>K <cmd>norm! K<cr>
nnoremap [b <cmd>bprevious<cr>
nnoremap ]b <cmd>bnext<cr>
nnoremap <leader>bo <cmd>e #<cr>
nnoremap <leader>bd <cmd>bd<cr>

vnoremap < <gv
vnoremap > >gv

noremap <C-j> <cmd>m .+1<cr>==
nnoremap <C-k> <cmd>m .-2<cr>==
inoremap <C-j> <esc><cmd>m .+1<cr>==gi
inoremap <C-k> <esc><cmd>m .-2<cr>==gi
vnoremap <C-k> :m '<-2<cr>gv=gv
vnoremap <C-j> :m '>+1<cr>gv=gv

nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-f> <cmd>silent !tmux neww tmux-sessionizer<cr>
nnoremap <C-b> <cmd>silent !tmux neww tmux-cht.sh<cr>

nnoremap <leader>lo <cmd>lopen<cr>
nnoremap <leader>qo <cmd>copen<cr>
nnoremap ]q <cmd>cnext<cr>zz
nnoremap [q <cmd>cprev<cr>zz
nnoremap ]l <cmd>lnext<cr>zz
nnoremap [l <cmd>lprev<cr>zz

nnoremap <leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <leader>cs <cmd>!chmod u+x %<cr>
nnoremap <leader>vpp <cmd>e ~/.vimrc<cr>
nnoremap <leader><leader> <cmd>so<cr>

" AUTOCMD:
autocmd BufWritePre * %s/\s\+$//e


" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
\| PlugInstall --sync | source $MYVIMRC
\| endif
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

set termguicolors
set background=dark
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_transparent_bg=1
color gruvbox
autocmd SourcePost * highlight Normal guibg=NONE ctermbg=NONE
autocmd SourcePost * highlight SignColumn guibg=NONE ctermbg=NONE

nnoremap <leader>u <cmd>UndotreeToggle<cr>
nnoremap <leader>qt <cmd>TagbarToggle<cr>

nnoremap <leader>ff <cmd>Files<CR>
nnoremap <leader>fr <cmd>History<CR>
nnoremap <leader>fc <cmd>Rg<Cr>
nnoremap <leader>fs <cmd>RG<Cr>
nnoremap <leader>fg <cmd>GFiles<cr>
nnoremap <leader>bt <cmd>Buffers<cr>

nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)

onoremap ih <Plug>(GitGutterTextObjectInnerPending)
onoremap ah <Plug>(GitGutterTextObjectOuterPending)
xnoremap ih <Plug>(GitGutterTextObjectInnerVisual)
xnoremap ah <Plug>(GitGutterTextObjectOuterVisual)
