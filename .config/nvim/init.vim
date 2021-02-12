" plugin settings {{{
if &compatible
  set nocompatible
endif
let s:config_dir = expand($XDG_CONFIG_HOME . '/nvim')
let s:cache_dir = expand($XDG_CACHE_HOME . '/nvim')

let s:plug_dir = s:cache_dir . '/plugged'
let s:autoload_plug = expand($XDG_DATA_HOME . '/nvim/site/autoload/plug.vim')

if !filereadable(s:autoload_plug)
  silent execute '!curl -fLo ' . s:autoload_plug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(s:plug_dir)

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'will133/vim-dirdiff'
Plug 'tpope/vim-commentary'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['EasyAlign', '<Plug>(EasyAlign)'] }

Plug 'glidenote/memolist.vim'
Plug 'previm/previm'
Plug 'plasticboy/vim-markdown'
Plug 'tyru/open-browser.vim'

Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim', { 'for': ['eruby', 'html', 'gohtmltmpl', 'vue'], 'on': [] }

Plug 'honza/vim-snippets', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }

Plug 'tidalcycles/vim-tidal'

Plug 'w0rp/ale'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'

call plug#end()

augroup load_us_insert
  autocmd!
  autocmd InsertEnter * call plug#load(
    \ 'emmet-vim',
    \ 'vim-snippets',
    \ 'ultisnips',
    \ ) | autocmd! load_us_insert
augroup END
" }}}

filetype plugin indent on
let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')

" plugin data directories {{{
let g:ctrlp_cache_dir          = expand($XDG_CACHE_HOME . '/nvim/ctrlp')
let g:memolist_path                 = expand('~/GoogleDrive/memolist')
" }}}

" plugins {{{
" fzf
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'pt --column --ignore=.git --global-gitignore '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview({ 'dir': s:find_git_root() }),
  \   <bang>0)
let g:fzf_history_dir = '~/.cache/nvim/fzf-history'

" memolist
let g:memolist_gfixgrep             = 1
let g:memolist_filename_prefix_none = 1
nmap mn  :MemoNew<CR>
nmap mg  :MemoGrep<CR>

" previm
let g:previm_show_header = 0

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)

" easy-align
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ultisnips
let g:UltiSnipsExpandTrigger="<f5>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" rust
let g:rustfmt_autosave = 1

" ale
let g:ale_linters = {
  \ 'html': [],
  \ 'css': ['stylelint'],
  \ 'javascript': ['eslint'],
  \ 'vue': ['eslint']
  \ }
let g:ale_linter_aliases = {'vue': 'css'}
let g:ale_fixers = {
  \ 'ruby': ['rubocop']
  \ }

" lsp
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" asyncomplete
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0
" goimports
let g:goimports_simplify = 1
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
set spell
hi CursorLine guifg=#E19972
set nobackup
set noswapfile
set matchpairs& matchpairs+=<:>
set hlsearch
set ignorecase
set smartcase
set infercase
set laststatus=2
set statusline=%<%t\ %y%h%w%m%r%=%-14.(%l,%c%V%)\ [%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]\ %P
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
map silent <C-n> :cnext<CR>
map silent <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
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

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
