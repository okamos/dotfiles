au BufRead,BufNewFile *.frm
  \ if getline(1).getline(2).getline(3).getline(4).getline(5).getline(6) =~? 'VB_Name\|Begin VB\.\(Form\|MDIForm\|UserControl\)' |
  \   set filetype=vb |
  \ else |
  \   set filetype=form |
  \ endif

if has('win32unix')
  au BufNewFile,BufRead *.frm set tags+=~/ctags/tags
endif
