" init pathogen
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

if v:progname =~? "evim"
  finish
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
    set autoindent
endif

function! Put_modeline ()
  let l:ml = printf("vim: set et ft=%s ts=%d sw=%d tw=%d:", &filetype, &tabstop, &shiftwidth, &textwidth)
  let l:ml = substitute(&commentstring, "%s", l:ml, "")
  call append(line("$"), l:ml)
endfunction

" disable pyflakes quick fix
let g:pyflakes_use_quickfix = 0


let g:miniBufExplForceSyntaxEnable=1
let g:miniBufExplMapWindowNavVim=1

set nocompatible
set mouse=a
set backspace=indent,eol,start
set ruler
set showcmd

set history=100
set incsearch

set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=79
set smarttab
set foldmethod=indent
set foldlevel=99

set background=dark
colorscheme peachpuff

let mapleader = ","

map Q gq
map <leader>b :MBEbn<CR>
map <leader>p :TMiniBufExplorer<cr>
map <leader>t :TagbarToggle<CR>
map <leader>s :set spell<CR>
map <leader>S :set nospell<CR>
map <leader>m :call Put_modeline()<CR>
map <leader>x :q!<CR>
map <leader>q :wq!<CR>
map <leader>w :w!<CR>

autocmd FileType ruby set ts=2 sw=2
autocmd FileType ruby set tags+=~/.tags/ruby

autocmd FileType python set tags+=~/.tags/python
autocmd FileType python map <buffer> <leader>8 :call Pep8()<CR>

" hilight trailing spaces
match Todo /\s\+$/

highlight SpellBad term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red
