" Filetype autodetection for the Promela language (.prm files)

augroup promela_ft
  au!
  autocmd BufNewFile,BufRead *.prm   set filetype=promela
augroup END
