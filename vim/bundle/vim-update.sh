#!/bin/bash

for REPO in jedi-vim  syntastic MatchTagAlways tagbar vim-abolish vim-eunuch vim-python-pep8-indent vim-markdown vim-flavored-markdown vim-airline vim-airline-themes vim-json vim-troll-stopper vim-fireplace rainbow_parentheses.vim vim-uimpaired vim-pydocstring vim-surround vim-clojure-static vim-fugitive vim-autoformat  vim-misc vim-easy-tags nerdtree vim-erlang-runtime vim-erlang-omnicomplete  do
    cd $REPO
    git pull
    cd ../
done

