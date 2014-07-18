au BufNewFile,BufRead *.orc,*.sco,*.csd,*.udo   set filetype=csound
au BufNewFile		*.csd	0r $HOME/.vim/templates/template.csd
au BufNewFile,BufRead	*.csd	so $HOME/.vim/macros/csound_macros.vim
