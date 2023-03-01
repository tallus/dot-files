dot-files
=========

Erm, my dot files?

Use .zshrc-local to add custom/local aliases and functions etc

Also I use oh-my-zsh, the tallpaul.zsh-theme is for that.

It's a custom minimalist zsh theme with git, python virtualenv  and command
return value info. This file is Ubuntu specific but you can also do (most of) this on OS X etc with a little tweaking.(For OS X you will need to install pip and virtualenv(wrapper).

### Set up
````
DESKTOP="false"
# sudo apt-get install git zsh python-pip python-virtualenv python -dev virtualenvwrapper ack-grep tmux
sudo apt install git curl zsh python3 virtualenvwrapper ack-grep tmux plocate
# optionally
sudo apt install toilet silversurfer-ag
# if you install this it doesn't install  a very good font selection
# and you probably want to install some more (at least fraktur and slant)
# if you are me they are on gatheringstorms
# if you are not try: https://github.com/cmatsuoka/figlet-fonts
# or http://www.figlet.org/fontdb.cgi
curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd
# git clone https://github.com/tallus/dot-files.git
git clone git@github.com:tallus/dot-files.git

# new
sudo apt install thefuck yapf3 lolcat
sudo pip install pathlib

# old:
sudo gem install lolcat
sudo pip install pathlib thefuck
suo pip install yapf

# Backup existing dot files
# Add symlinks
ln -s ~/dot-files/zshrc ~/.zshrc
ln -s ~/dot-files/zsh ~/.zsh
ln -s ~/dot-files/vimrc ~/.vimrc
ln -s ~/dot-files/vim ~/.vim
ln -s ~/dot-files/tmux.conf ~/.tmux.conf
ln -s ~/dot-files/ackrc ~/.ackrc
ln -s ~/dot-files/pylintrc ~/.pylintrc
ln -s ~/dotfiles/flake8 ~/.config/flake8
ln -s ~/dot-files/style.ypaf ~/.config/yapf/style

# copy over zsh theme
cp dot-files/tallpaul.zsh-theme .oh-my-zsh/themes

# anything in here will override this file and oh-my-zsh
touch .zshrc-local
# sourced before oh-my-zsh
touch .zshrc-plugins
# add localplugins=(tmux) to .zshrc-plugins to autostart tmux
echo "localplugins=(tmux)" >> .zshrc-plugins


# Vim stuff
cd ~/dot-files/vim/bundle
./vim-clone.sh
# (update these with vim-update.sh)
# optionally add a shortcut to vimrc-local to autoformat selected text
# noremap <F11> :Autoformat<CR>
# copy style.yapf to .style.yapf in a project directory
# to use with vim auto-format
# Install ExuberantCtags to make use of all the plugins
sudo apt-install exuberant-ctags
## install powerline font
# This is only needed for a local machine, not for machines you only ssh to
cd .fonts
wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
fc-cache -vf ~/.fonts/

# set terminal emulator to use patched font

# see also:
# https://github.com/powerline/fonts
# https://powerline.readthedocs.org/en/latest/installation/linux.html#fonts-installation

# fix virtualenv wrapper
# edit /etc/bash_completion.d/virtualenvwrapper
# set use_full to yes
# chage the if statement to use double square brackets

# useful command line things
# sudo apt-get install vim-nox aptitude ipython (aptitude was already installed)
sudo apt install vim-nox python3-ipython ddgr direnv ondir px vim-syntastic
# Set a useful editor/not Nano
sudo  update-alternatives --config editor
# get Templates
git clone git@github.com:tallus/templates.git

#useful  GUI things
if [ $DESKTOP=="true" ]; then
  # terminator is best installed from the ppa - not needed anymore?
  # sudo add-apt-repository ppa:gnome-terminator && sudo apt-get update
  # sudo apt-get install terminator chromium-browser unity-tweak-tool gthumb inkscape gimp exaile
  sudo apt-get install terminator chromium-browser gnome-tweak-tool gthumb inkscape gimp exaile
  # make things look pretty - this is old
  sudo add-apt-repository ppa:tiheum/equinox
  sudo add-apt-repository ppa:webupd8team/themes
  sudo apt-get update && sudo apt-get install faenza-icon-theme faience-azur-dark  faience-icon-theme
fi
# put menus in windows not panel System Settings -> Appearance -> Behaviour (not any more)
