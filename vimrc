set nocompatible
set encoding=utf-8

" init pathogen
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set hidden
set nobackup
set noswapfile

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set background=dark
  let g:solarized_termtrans=1
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
  colorscheme solarized
endif

if has("autocmd")
  filetype plugin indent on
else
  set autoindent
endif

function! Put_modeline ()
  let l:ml = printf("vim: set et ft=%s ts=%d sw=%d tw=%d:", &filetype, &tabstop, &shiftwidth, &textwidth)
  let l:ml = substitute(&commentstring, "%s", l:ml, "")
  call append(line("$"), l:ml)
endfunction

set pastetoggle=<F2>

set backspace=indent,eol,start
set ruler
set showcmd
set history=500
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set foldmethod=indent
set foldlevel=99
set number
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set laststatus=2

let mapleader = ","

vmap Q gq
nmap Q gqap

map <leader>M :TMiniBufExplorer<cr>
map <leader>T :TagbarToggle<CR>
map <leader>s :set spell<CR>
map <leader>S :set nospell<CR>
map <leader>l :set list<CR>
map <leader>m :call Put_modeline()<CR>
map <leader>x :q!<CR>
map <leader>q :wq!<CR>
map <leader>w :w!<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gb :Gblame<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>

autocmd FileType ruby set ts=2 sw=2
map <leader>r :call ri#OpenSearchPrompt(1)<cr>
map <leader>rk :call ri#LookupNameUnderCursor()<cr>

autocmd FileType python set tw=79
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight=0

" hilight trailing spaces
match Todo /\s\+$/

