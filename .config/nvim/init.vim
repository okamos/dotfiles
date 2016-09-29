" dein settings {{{
if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install('vimproc')
endif
if dein#check_install()
  call dein#install()
endif
" }}}

filetype plugin indent on

let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
let g:loaded_ruby_provider = 1

" plugin data directories {{{
let g:neomru#file_mru_path          = expand('~/.cache/etc/neomru/file')
let g:neomru#directory_mru_path     = expand('~/.cache/etc/neomru/direcroty')
let g:neoyank#file                  = expand('~/.cache/etc/.cache/neoyank')
let g:memolist_path                 = expand('~/GoogleDrive/memolist')
" }}}

" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
" }}}

" encoding {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
" }}}
" appearance {{{
set termguicolors
syntax on
let g:seoul256_background = 233
try
  colorscheme seoul256
catch
endtry
hi CursorLine guifg=#E19972
set nobackup
set noswapfile
set matchpairs& matchpairs+=<:>
set hlsearch
set ignorecase
set smartcase
set infercase
set laststatus=2
set statusline=%<%t\ %y%h%w%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ [%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]\ %P
set nowrap
set wildmenu
set showcmd
set clipboard=unnamed
set autoindent
set shiftround
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab
set foldmethod=indent
set foldlevel=30

"etc
set nf=hex
set mouse=a

"key-mapping
imap <C-j> <esc>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <Tab> %
vmap <Tab> %
tnoremap <Esc> <C-\><C-n>
" }}}
