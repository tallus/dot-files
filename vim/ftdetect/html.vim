" set html to jinja since the latter also does the former
au BufWinEnter,BufRead,BufNewFile *.html set filetype=jinja
au BufWinEnter,BufRead,BufNewFile *.htm set filetype=jinja

