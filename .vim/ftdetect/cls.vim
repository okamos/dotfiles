au BufRead,BufNewFile *.cls
  \ if getline(1).getline(2).getline(3).getline(4).getline(5).getline(6).getline(7).getline(8).getline(9).getline(10) =~? 'VB_Name\|Begin VB\.\(Form\|MDIForm\|UserControl\)' |
  \   set filetype=vb |
  \ elseif getline(1) =~ '^%' |
  \   set filetype=tex |
  \ elseif getline(1)[0] == '#' && getline(1) =~ 'rexx' |
  \   set filetype=rexx |
  \ else |
  \   set filetype=st |
  \ endif

if has('win32unix')
  au BufNewFile,BufRead *.cls set tags+=~/ctags/tags
endif
