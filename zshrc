# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
setopt HIST_IGNORE_DUPS # ignore duplicate lines in history file
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/paul/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
setopt autopushd pushdignoredups # used by cd-

PATH="$HOME/bin:$PATH"

# Use to detect OS X/mac
is_darwin(){
    [[ $OSTYPE == darwin* ]] && return 0
    return 1
}

# Autoload screen if we aren't in it.  (Thanks Fjord!)
# Note we have to account for terminator if we want
# to allow for right click screen split
if [ $PPWD ]; then
    cd $PPWD
fi

#if [[ $(cat /proc/$PPID/cmdline) =~ terminator ]]; then
#  screen -RR
#elif [[ $STY = '' ]]; then
#    exec screen -RR
#fi

#if [[ $STY = '' ]]; then  exec screen -RR ;fi
#if [[ $TERM != "screen" ]] then exec tmux; fi

# Set 256 colours in gnome terminal/terminator
if [[ $COLORTERM == "gnome-terminal" ]]; then
                # Those crafty Gnome folks require you to check COLORTERM,
                # but don't allow you to just *favor* the setting over TERM.
                # Instead you need to compare it and perform some guesses
                # based upon the value. This is, perhaps, too simplistic.
                TERM="gnome-256color"
fi

source $HOME/.zsh/rc/git_prompt


# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# beeps are annoying
setopt NO_BEEP


# ls colors
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# config
#PROMPT="%n@%m:%~ %# "
export  EDITOR=/usr/bin/vim

# functions

# built in hook called on exit
#  add zshexit to zshrc-local to overide this
zshexit(){
    if [ ${plugins[(i)tmux]} -le ${#plugins} ] && [ -e $HOME/.bye ]; then
            rm $HOME/.bye
    else
        if [ ${plugins[(i)tmux]} -le ${#plugins} ]; then
            touch $HOME/.bye
        fi
        clear
        if [ -f $HOME/bin/bofh ]; then
            echo "kernel panic:"
            $HOME/bin/bofh
        fi
        if [ ! -z  $commands[figlet] ] && [ ! -z  $commands[lolcat] ];then
            if [ -f /usr/share/figlet/fraktur.flf ]; then
                figlet -f fraktur "bye!"  | lolcat
            else
                figlet "bye!"  | lolcat
            fi
        fi
        sleep 1.2s
    fi
    exit
}

sprompt(){
    PROMPT="%n@%m %#:"
}


rcd(){
    cd
    cd -
    clear
}

# set up useful dev tools in virtualenv
pydev(){
    pip install ipython nose mock coverage
    pip install flake8 frosted pep8 prospector pyflakes pylama pylint
    pip install "ipython[notebook]"

}


# only if the command doesn't exist i.e. in ~/bin
# alternatively add to zshrc-local to overide this
if [ -z $commands[hello] ]; then
    hello(){
        if [ ! -z  $commands[figlet] ] && [ ! -z  $commands[lolcat] ];then
            echo "               Welcome to" | lolcat;
            if [ -f /usr/share/figlet/slant.flf ]; then
                figlet -f slant  "    $HOST" | lolcat
            else
                figlet "    $HOST" | lolcat
            fi
        elif [ ! -z  $commands[figlet] ]; then
            echo "               Welcome to";
            if [ -f /usr/share/figlet/slant.flf ]; then
                figlet -f slant  "    $HOST"
            else
                figlet -f "    $HOST"
            fi
        else
            echo "Welcome to $HOST"
        fi
    }
fi

# lss less if regular file otherwise ls (accepts args to ls
 lss(){
    if [ -f $1 ]; then
        less $1;
    else
        ls  ${argv:2} $1;
    fi
}


# Aliases

#alias r='screen -D -R'
alias ls='ls -F --color'
#alias la='ls -alh'
alias ll='ls -lh'
alias 'grep=grep --colour'
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias compile='gcc -std=c99 -Wall -Wextra -Werror -o $@'
alias duc='du -ch --max-depth=1'
alias duc2='du -ch --max-depth=2'
alias duc3='du -ch --max-depth=3'
alias mkbash="$HOME/bin/mkscript bash"
alias mkrb="$HOME/bin/mkscript ruby"
alias mkjs="$HOME/bin/mkscript javascript"
alias vi=vim
alias view="vim -R"
alias tmux="tmux -2"
# if [ $(uname) != 'Darwin' ]; then
#     alias ack="ack-grep"
# fi
alias pack="ack --python"
alias hack="ack --html"
alias jack="ack --js"
alias sack="ack --scss"
# alias thefuck ->fuck) if it's there
if [ ! -z  $commands[thefuck] ]; then
    eval "$(thefuck --alias)"
fi

wat(){
    preexec() { print -nr $'\033'"]2;$1"$'\a' }
}

# Make GNU fileutils more verbose
for c in cp rm chmod chown rename; do
        alias $c="$c -v"
    done

if [[ -x "`whence -p dircolors`" ]]; then
      eval `dircolors`
        alias ls='ls -F --color=auto'
    else
          alias ls='ls -F'
      fi


# virtualenvwrapper
# use python3 by default if it exists
if which python3 &> /dev/null && which python &> /dev/null; then
     export VIRTUALENVWRAPPER_PYTHON=$(which python3)
     LOCAL_PIP=$(which pip3)

 else
     export VIRTUALENVWRAPPER_PYTHON=$(which python)
     LOCAL_PIP=$(which pip)
fi
# ensure virtualenvwrapper is installed for this version of python
# probably a bad idea see PEP 668, hence OS overide
if ! is_darwin && ! $($LOCAL_PIP show virtualenvwrapper &>/dev/null) ; then
    echo "$LOCAL_PIP install --user virtualenvwrapper"
fi

export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
export WORKON_HOME=$HOME/.virtualenvs
if [ -e $HOME/code ]; then
    export PROJECT_HOME=$HOME/code
else
    export PROJECT_HOME=$HOME/projects
fi
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENV_USE_DISTRIBUTE=true

if [ -f /etc/bash_completion.d/virtualenvwrapper ] ; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/etc/bash_completion.d/virtualenvwrapper
        source /etc/bash_completion.d/virtualenvwrapper
    }
elif [ -f /opt/homebrew/bin/virtualenvwrapper.sh ]; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/opt/homebrew/bin/virtualenvwrapper.sh
        source /opt/homebrew/bin/virtualenvwrapper.sh
    }
elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
        source /usr/bin/virtualenvwrapper.sh
    }
elif [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
        source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    }
elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
        source /usr/bin/virtualenvwrapper.sh
    }
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    function {
        setopt local_options
        unsetopt equals
        export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
        source /usr/local/bin/virtualenvwrapper.sh
    }
else
    echo "No virtualenvwrapper :("
fi

# alias python3 to python
# if [[ ! -a /usr/bin/python && -a /usr/bin/python3 ]]; then
#     alias python=/usr/bin/python3
# fi

# alias mkvirtualenv-real='mkvirtualenv'
# alias mkvirtualenv='mkvirt'

## source local plugins
if [  -e ~/.zshrc-plugins ]; then
    source ~/.zshrc-plugins
fi
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="fishy"
#ZSH_THEME="gallifrey"
#ZSH_THEME="jreese"
#ZSH_THEME="minimal"
#ZSH_THEME="mrtazz"
ZSH_THEME="tallpaul"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python pip virtualenvwrapper web-search ruby  history vi-mode catimg zsh-syntax-highlighting)

## source local
if [  -e ~/.zshrc-local ]; then
    source ~/.zshrc-local
fi

# add plugins from zshrc-local
if [ ${#localplugins} -ge 1 ]; then
    plugins=($plugins $localplugins)
fi

# Customize tmux plugin
if [ ${plugins[(i)tmux]} -le ${#plugins} ]; then
    ZSH_TMUX_AUTOSTART=true
    ZSH_TMUX_AUTOCONNECT=false
    ZSH_TMUX_AUTOQUIT=true
fi
source $ZSH/oh-my-zsh.sh

# Customize to your needs...


#PROMPT=$'%n@%m:$(prompt_git_info)%{${fg[default]}%}%~%# '
# Who doesn't want home and end to work?
# Key bindings
#

# these might need to go after on-my-zsh is called
unsetopt SHARE_HISTORY

# make home and end key work
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# <esc> v -- enter editor mode
autoload edit-command-line
zle -N edit-command-line
bindkey '\ev' edit-command-line
# insert last word with <esc> .
bindkey '\e.' insert-last-word

[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history


#bindkey -v

# Insert sudo at beginning of line with Alt-S
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# overide zsh_syntax_highlighting colours for light terms
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=130'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=130'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[functions]='fg=blue,bold'

# run here to ensure it doesn't get overwritten
if [  -e ~/.zshrc-local-aliases ]; then
    source ~/.zshrc-local-aliases
fi

# Don't run this if shell interaction is required
# (by intellij)
if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
    ## xterm fun!
    hello
    # Use this to output messages after everything else
    if [  -e ~/.zshrc-local-final ]; then
        source ~/.zshrc-local-final
    fi
fi

# End of lines configured by zsh-newuser-install

### END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
# Local variables:
# mode: sh
# End


#if [[ -e /rvms ]]; then
#    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#    source ~/.rvm/scripts/rvm
#fi
#PATH=$PATH:/home/pmunday/web-serpng/code/serpng/tools/bin
#export TERM=screen-256color


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/MundPa/.sdkman"
# [[ -s "/Users/MundPa/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/MundPa/.sdkman/bin/sdkman-init.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
