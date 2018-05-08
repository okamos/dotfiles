" dein settings {{{
if &compatible
  set nocompatible
endif
let s:config_dir = expand($XDG_CONFIG_HOME . '/nvim')
let s:cache_dir = expand($XDG_CACHE_HOME . '/nvim')

let s:dein_dir = s:cache_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = s:config_dir . '/dein.toml'
  let s:lazy_toml = s:config_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" }}}

filetype plugin indent on
let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')

" plugin data directories {{{
let g:ctrlp_cache_dir          = expand($XDG_CACHE_HOME . '/nvim/ctrlp')
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
set clipboard+=unnamedplus
set autoindent
set shiftround
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab
set foldmethod=syntax
set spelllang=en,cjk
set timeout
set timeoutlen=500
set ttimeout
set ttimeoutlen=50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"etc
set nf=hex
set mouse=a

"key-mapping
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <Tab> %
vmap <Tab> %
nmap <silent> c] :cnext<CR>
nmap <silent> c[ :cprevious<CR>
tnoremap <Esc> <C-\><C-n>
" }}}
" functions {{{
function! s:setFileType()
  if searchpair('<script', '', '</script>', 'bnW')
    set ft=javascript
  elseif searchpair('<style', '', '</style>', 'bnW')
    set ft=css
  elseif searchpair('<i18n', '', '</i18n>', 'bnW')
    set ft=json
  else
    set ft=html
  endif
endfunction
augroup vueBinds
  au!
  au User *.vue call s:setFileType()
augroup END
nmap <silent> tu :doautocmd User<CR>
" }}}
