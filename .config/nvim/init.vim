augroup rc_autocmd
  autocmd!
augroup END
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

" at first
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif
" at second
if dein#check_install()
  call dein#install()
endif
" }}}


filetype plugin indent on

" plugin data directories {{{
let g:neosnippet#data_directory     = expand('~/.cache/etc/.cache/neosnippet')
let g:neosnippet#snippets_directory = [s:dein_dir.'/repos/github.com/Shougo/neosnippet-snippets/neosnippets', expand('~/dotfiles/snippets')]
let g:unite_data_directory          = expand('~/.cache/etc/unite')
let g:neomru#file_mru_path          = expand('~/.cache/etc/neomru/file')
let g:neomru#directory_mru_path     = expand('~/.cache/etc/neomru/direcroty')
let g:neoyank#file                  = expand('~/.cache/etc/.cache/neoyank')
let g:memolist_path                 = expand('~/GoogleDrive/memolist')
" }}}
" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 5
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}
" neosnippet {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}
" unite {{{
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" recall grep result
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite file_mru buffer<CR>
nmap <silent> <C-u><C-p> :<C-u>Unite file_rec/async:!<CR>
" grep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts  = '--nogroup --nocolor --smart-case'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding      = 'utf-8'
endif
" }}}
" memolist {{{
let g:memolist_gfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_option = "-vertical -start-insert"
nnoremap mn  :MemoNew<CR>
nnoremap ml  :MemoList<CR>
nnoremap mg  :MemoGrep<CR>
" }}}
" switch {{{
nmap + :Switch<CR>
nmap - :Switch<CR>
" }}}
" emmet {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \ 'lang' : 'ja',
  \ 'html' : {
  \   'indentation' : '  '
  \ }}
" }}}
" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}
" neoyank.vim {{{
nmap <silent> <C-u><C-y> :<C-u>:Unite history/yank<CR>
let g:neoyank#limit = 1000
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}
" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
" }}}
" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}
" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
" }}}
" syntastic {{{
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['ruby', 'eruby', 'javascript', 'coffee']
  \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_javascript_checkers = ['eslint']
" }}}
" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'component_function': {
  \   'fugitive': 'MyFugitive',
  \   'readonly': 'MyReadonly',
  \   'modified': 'MyModified',
  \   'filename': 'MyFilename'
  \ },
  \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
  \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
  \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
" }}}

" encoding {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
" }}}
" appearance {{{
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set t_Co=256
endif
syntax on
let g:seoul256_background = 233
try
  colorscheme seoul256
catch
endtry
hi EasyMotionTarget guifg=#80a0ff ctermfg=81
set nobackup
set noswapfile
set matchpairs& matchpairs+=<:>
set hlsearch
set ignorecase
set smartcase
set infercase
set laststatus=2
set ruler
set number
set nowrap
set list
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
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
" }}}
