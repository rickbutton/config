if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'dhruvasagar/vim-zoom'
call plug#end()

syntax enable
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set number
set showcmd
filetype indent on
set wildmenu
set foldenable
set showmatch
set incsearch
set hlsearch
set laststatus=2
set noshowmode
" turn off search highlight
nnoremap <leader>/ :nohlsearch<CR>

set esckeys

let mapleader=","

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

nnoremap <C-p> :Files<cr>

nnoremap <C-o> :NERDTreeToggle<cr>


" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

colorscheme codedark
let g:lightline = {
    \ 'active': {
    \    'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'zoom']]
    \ },
    \ 'component': {
    \    'zoom': '%{zoom#statusline()}'
    \ },
    \ 'colorscheme': 'wombat',
    \ }
set background=dark
set t_Co=256

autocmd BufNewFile,BufRead *.scm set syntax=scheme
autocmd BufNewFile,BufRead *.sld set syntax=scheme
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
