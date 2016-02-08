#!/bin/bash

for REPO in jedi-vim  syntastic MatchTagAlways tagbar vim-abolish vim-eunuch vim-python-pep8-indent vim-markdown vim-airline vim-airline-themes vim-json vim-troll-stopper; do
    cd $REPO
    git pull
    cd ../

done
