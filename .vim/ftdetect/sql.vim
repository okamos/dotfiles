if has('win32unix')
  au BufNewFile,BufRead *.frm set tags+=~/ctags/tags
endif
