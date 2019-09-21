#!/bin/bash
for REPO in https://github.com/vim-utils/vim-troll-stopper.git https://github.com/davidhalter/jedi-vim.git  https://github.com/scrooloose/syntastic.git https://github.com/Valloric/MatchTagAlways.git https://github.com/majutsushi/tagbar.git https://github.com/tpope/vim-abolish.git https://github.com/tpope/vim-eunuch.git https://github.com/hynek/vim-python-pep8-indent.git https://github.com/plasticboy/vim-markdown.git https://github.com/bling/vim-airline https://github.com/vim-airline/vim-airline-themes.git https://github.com/leshill/vim-json.git https://github.com/eapache/rainbow_parentheses.vim.git https://github.com/tpope/vim-fireplace.git https://github.com/tpope/vim-unimpaired.git git@github.com:heavenshell/vim-pydocstring.git https://github.com/tpope/vim-surround.git http://github.com/jtratner/vim-flavored-markdown.git https://github.com/guns/vim-clojure-static.git  https://github.com/tpope/vim-fugitive.git https://github.com/Chiel92/vim-autoformat.git https://github.com/xolox/vim-misc.git https://github.com/xolox/vim-easytags.git https://github.com/scrooloose/nerdtree.git https://github.com/vim-erlang/vim-erlang-runtime https://github.com/vim-erlang/vim-erlang-runtime; do
    git clone $REPO
done
vim -u NONE -c "helptags vim-fugitive/doc" -c q
cd jedi-vim
git submodule update --init
