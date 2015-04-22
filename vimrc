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
  set background=light
  let g:rainbow_active = 1
  let g:solarized_termtrans = 1
  let g:solarized_visibility = 'high'
  let g:solarized_bold = 0
  let g:solarized_italic = 0
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
set listchars=tab:».,trail:.,extends:#,nbsp:.
set list
set laststatus=2
set ttimeoutlen=50

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

let mapleader = ","

vmap Q gq
nmap Q gqap

map <leader>p :set paste!<CR>
map <leader>l :set list!<CR>

map <leader>T :TagbarToggle<CR>
map <leader>m :call Put_modeline()<CR>

nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'

map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gb :Gblame<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>

autocmd FileType ruby set ts=2 sw=2
autocmd FileType ruby compiler ruby

autocmd FileType go set commentstring=//\ %s
autocmd FileType go set noet
autocmd FileType go set nolist
autocmd FileType go map <buffer> <leader>gf :Fmt<CR>
let g:golang_goroot = $GOROOT
let g:golang_onwrite = 0

" toggle spell
imap <Leader>s <C-o>:setlocal spell!<CR>
nmap <Leader>s :setlocal spell!<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

" eclim
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimProjectTreeAutoOpen=0
let g:EclimProjectTreeExpandPathOnOpen=1
let g:EclimProjectTreeSharedInstance=1

nnoremap <leader>js :JavaSearch<CR>
nnoremap <leader>jgs :JavaSet<CR>
nnoremap <leader>jgg :JavaGet<CR>
nnoremap <leader>jg :JavaGetSet<CR>
nnoremap <leader>jh :JavaHierarchy<CR>
nnoremap <leader>jii :JavaImpl<CR>
nnoremap <leader>jd :JavaDelegate<CR>
nnoremap <leader>ji :JavaImport<CR>
nnoremap <leader>jim :JavaImportMissing<CR>
nnoremap <leader>jr :JavaRename<CR>
nnoremap <leader>jf :JavaFormat<CR>

" tern js
nnoremap <leader>td :TernDef<CR>
nnoremap <leader>to :TernDoc<CR>
nnoremap <leader>tt :TernType<CR>
nnoremap <leader>tr :TernRefs<CR>
nnoremap <leader>te :TernRename<CR>
