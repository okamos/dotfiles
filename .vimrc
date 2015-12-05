if !isdirectory(expand("~/.vim"))
  call mkdir(expand("~/.vim"))
endif
" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  if !isdirectory(expand("~/.vim/.bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/.bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/.bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/.bundle'))
let g:neobundle_default_git_protocol='https'
NeoBundleFetch 'Shougo/neobundle.vim'
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundleLazy 'Shougo/neosnippet', {
  \ 'depends' : 'Shougo/neosnippet-snippets',
  \ 'autoload' : {
  \   'insert' : 1,
  \   'filetypes' : 'snippet',
  \ }}
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}
NeoBundle 'tpope/vim-fugitive', {
  \ 'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/matchit.zip'
if has('mac') || has('win32unix')
  NeoBundle 'glidenote/memolist.vim'
endif
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'wavded/vim-stylus'
NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}
NeoBundle 'kannokanno/previm'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'mattn/emmet-vim', {
  \ 'autoload' : {
  \   'filetypes' : ['html', 'html5', 'eruby', 'jsp', 'xml', 'css', 'scss', 'coffee'],
  \   'commands' : ['<Plug>ZenCodingExpandNormal']
  \ }}
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'othree/html5.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}
NeoBundle 'scrooloose/syntastic'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jiangmiao/auto-pairs'

NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" }}}
" plugin data directories {{{
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
let g:neosnippet#data_directory     = expand('~/.vim/etc/.cache/neosnippet')
let g:neosnippet#snippets_directory = [expand('~/.vim/.bundle/neosnippet-snippets/neosnippets'),expand('~/dotfiles/snippets')]
let g:unite_data_directory          = expand('~/.vim/etc/unite')
let g:neomru#file_mru_path          = expand('~/.vim/etc/neomru/file')
let g:neomru#directory_mru_path     = expand('~/.vim/etc/neomru/direcroty')
let g:w3m#history#save_file         = expand('~/.vim/etc/.vim_w3m_hist')
let g:yankround_dir                 = expand('~/.vim/etc/.cache/yankround')
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
" grep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts  = '--nogroup --nocolor --smart-case'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding      = 'utf-8'
endif
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" }}}
" vimfiler {{{
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
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
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
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
set t_Co=256
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
" }}}
