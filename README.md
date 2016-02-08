dot-files
=========

Erm, my dot files?

Use .zshrc-local to add custom/local aliases and functions etc

Also I use oh-my-zsh, the tallpaul.zsh-theme is for that.

It's a custom minimalist zsh theme with git, python virtualenv  and command
return value info. This file is Ubuntu specific but you can also do (most of) this on OS X etc with a little tweaking.(For OS X you will need to install pip and virtualenv(wrapper).

### Set up
````
sudo apt-get install git zsh python-pip python-virtualenv python -dev virtualenvwrapper ack-grep tmxu
curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd
git clone https://github.com/tallus/dot-files.git
sudo gem install lolcat
sudo pip install pathlib thefuck

# Backup existing dot files
# Add symlinks
ln -s dot-files/zshrc .zshrc
ln -s dot-files/zsh .zsh
ln -s dot-files/vimrc .vimrc
ln -s dot-files/vim ./.vim
ln -s dot-files/tmux.conf .tmux.conf

# copy over zsh theme
cp dot-files/tallpaul.zsh-theme .oh-my-zsh/themes

touch .zshrc-local
# add localplugins=(tmux) to .zshrc-local to autostart tmux
echo "localplugins=(tmux)" >> .zshrc-local


# Vim stuff
cd ~/dot-files/vim/bundle
./vim-clone.sh
# (update these with vim-update.sh)

# Install ExuberantCtags to make use of all the plugins

## install powerline font
This is only needed for a local machine, not for machines you only ssh to
cd .fonts
wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
fc-cache -vf ~/.fonts/

# set terminal emulator to use patched font

# see also:
# https://github.com/powerline/fonts
# https://powerline.readthedocs.org/en/latest/installation/linux.html#fonts-installation



# useful command line things
sudo apt-get install vim-nox aptitude ipython toilet
# Set a useful editor/not Nano
sudo  update-alternatives --config editor
#useful  GUI things
sudo apt-get install terminator chromium-browser unity-tweak-tool gthumb inkscape gimp exaile
#useful server stuff
sudo apt-get install postgresql-9.3 postgresql-client-9.3 ipython python-psycopg2 nginx openssh-server ansible
# make things look pretty
sudo add-apt-repository ppa:tiheum/equinox
sudo add-apt-repository ppa:webupd8team/themes
sudo apt-get update && sudo apt-get install faenza-icon-theme faience-azur-dark  faience-icon-theme

# put menus in windows not panel System Settings -> Appearance -> Behaviour
````
