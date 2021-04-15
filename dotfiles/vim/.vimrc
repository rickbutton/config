if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'dhruvasagar/vim-zoom'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'liuchengxu/vim-which-key'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'guns/vim-sexp'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'luochen1990/rainbow'
call plug#end()

" sane defaults
syntax enable
set backspace=indent,eol,start
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
set mouse=ar

if !has('nvim')
    set esckeys
endif

let g:javascript_plugin_flow = 1

let mapleader=" "

" pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" file management
nnoremap <C-p> :Files<cr>
nnoremap <C-o> :Rg<cr>
nnoremap <C-i> :NERDTreeToggle<cr>

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" colors/styles
let g:lightline = {
    \ 'active': {
    \    'left': [['mode', 'paste'], ['cocstatus', 'currentfunction', 'readonly', 'relativepath', 'modified', 'zoom']]
    \ },
    \ 'inactive': {
    \    'left': [['relativepath']]
    \ },
    \ 'component': {
    \    'zoom': '%{zoom#statusline()}'
    \ },
    \ 'component_function': {
    \    'cocstatus': 'coc#status',
    \    'currentfunction': 'CocCurrentFunction'
    \ },
    \ 'colorscheme': 'wombat',
    \ }
set background=dark
set t_Co=256
set t_ut=
colorscheme codedark

" scheme
autocmd BufNewFile,BufRead *.scm set syntax=scheme
autocmd BufNewFile,BufRead *.sld set syntax=scheme
autocmd FileType scheme setlocal commentstring=;%s

" coc.vim
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" tab for trigger coc with current selection
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ctrl-space to trigger coc
inoremap <silent><expr> <c-space> coc#refresh()

" <cr> to commit coc
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> <leader>gk :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! HeaderToggle()
    let filename = expand("%:t")
    if filename =~ ".cpp"
        execute "e %:r.h"
    else
        execute "e %:r.cpp"
    endif
endfunction

nmap <leader>sp :<C-u>sp<CR>
nmap <leader>vs :<C-u>vs<CR>

nmap <leader>aa <Plug>(coc-codeaction)
nmap <leader>af <Plug>(coc-fix-current)
nmap <leader>aj :<C-u>CocNext<CR>
nmap <leader>ak :<C-u>CocPrev<CR>

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

nmap <leader>rr :<C-u>CocRestart<CR>

nmap <leader>dd :<C-u>CocList diagnostics<CR>
nmap <leader>dn <Plug>(coc-diagnostic-next)
nmap <leader>dp <Plug>(coc-diagnostic-prev)

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <leader>y  :<C-u>CocList -A --normal yank<CR>

nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <leader>c  :<C-u>Commentary<CR>
xnoremap <leader>c  :<C-u>'<,'>Commentary<CR>

nnoremap <leader>/ :nohlsearch<CR>

nmap <leader><leader> <Plug>(zoom-toggle)

autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <leader>h :call HeaderToggle()<cr>
nnoremap <leader>s :call CocAction("doHover")<cr>

let g:AutoPairsMultilineClose = 0
