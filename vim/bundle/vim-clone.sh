#!/bin/bash

for REPO in https://github.com/vim-utils/vim-troll-stopper.git https://github.com/davidhalter/jedi-vim.git  https://github.com/scrooloose/syntastic.git https://github.com/Valloric/MatchTagAlways.git https://github.com/majutsushi/tagbar.git https://github.com/tpope/vim-abolish.git https://github.com/tpope/vim-eunuch.git https://github.com/hynek/vim-python-pep8-indent.git https://github.com/plasticboy/vim-markdown.git; do
    git clone $REPO
done
