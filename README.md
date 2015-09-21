dot-files
=========

Erm, my dot files?

Use .zshrc-local to add custom/local aliases and functions etc

Also I use oh-my-zsh, the tallpaul.zsh-theme is for that.

It's a custom minimalist zsh theme with git, python virtualenv  and command
return value info

### Set up
````
sudo apt-get install git zsh python-pip python-virtualenv virtualenvwrapper ack-grep
curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/custom/plugins
git clone https:://github.com/zsh-users/zsh-syntax-highlighting.git
cd 
git clone https://github.com/tallus/dot-files.git
sudo gem install lolcat
sudo pip install pathlib thefuck

# Backup existing dot files
# Add symlinks 
# i.e. ln -s dot-files/zshrc .zshrc

touch .zshrc-local
# add localplugins=(tmux) to .zshrc-local to autostart tmux
echo "localplugins=(tmux)" >> localplugins=(tmux)


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
