dot-files
=========

Erm, my dot files?

Also I use oh-my-zsh, the tallpaul.zsh-theme is for that.

It's a custom minimalist zsh theme with git, python virtualenv  and command
return value info

### Set up
````
sudo apt-get install git zsh python-pip python-virtualenv virtualenvwrapper ack-grep
curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
git clone git://github.com/tallus/dot-files.git
sudo gem install lolcat

sudo apt-get install vim-nox aptitude ipython toilet
sudo apt-get install terminator chromium-browser unity-tweak-tool gthumb inkscape gimp exaile
sudo apt-get install postgresql-9.3 postgresql-client-9.3 ipython python-psycopg2 nginx openssh-server ansible
sudo add-apt-repository ppa:tiheum/equinox
sudo add-apt-repository ppa:webupd8team/themes
sudo apt-get update && sudo apt-get install faenza-icon-theme faience-azur-dark  faience-icon-theme
````
