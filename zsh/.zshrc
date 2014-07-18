# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/paulm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
setopt autopushd pushdignoredups # used by cd-

# Autoload screen if we aren't in it.  (Thanks Fjord!)
# Note we have to account for terminator if we want
# to allow for right click screen split
# now set in terminator preferences to it exits wjhen screen does.
#if [[ $(cat /proc/$PPID/cmdline) =~ terminator ]]; then
#    screen -RR
#    true
#elif [[ $STY = '' ]]; then 
#    exec screen -RR
#fi
#
#
#
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

source /home/paulm/.zsh/rc/git_prompt
# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# beeps are annoying
setopt NO_BEEP


# ls colors
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#{{{ Key bindings

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Insert sudo at beginning of line with Alt-S
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# <esc> v -- enter editor mode
autoload edit-command-line
zle -N edit-command-line
bindkey '\ev' edit-command-line
# insert last word with <esc> .
bindkey '\e.' insert-last-word

#functions
byebye(){
    local bye="bye!"
    clear 
    echo  -n "kernel panic: "
    bofh
    if [[ -e /usr/share/figlet/fraktur.flf ]]; then 
            figlet -f fraktur $bye | lolcat
            elif ! figlet -f $bye; then
                    fi 
    sleep 2s
    exit 0
}


# config
#PROMPT="%n@%m:%~%# " 
PROMPT=$'%n@%m:$(prompt_git_info)%{${fg[default]}%}%~%# '

export  EDITOR=/usr/bin/vim

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias r='screen -D -R'
#alias ls='ls -F --color'
alias la='ls -alh'
alias ll='ls -lh'
alias 'grep=grep --colour'
alias exit='byebye'
alias bye='byebye'
alias ssh='/home/paulm/bin/sssh'
alias real-ssh='/usr/bin/ssh'
alias rssh='/usr/bin/ssh'
alias duc='du -ch --max-depth=1'
alias duc2='du -ch --max-depth=2'
alias duc3='du -ch --max-depth=3'
# alias mkbash="$HOME/bin/mkscript bash" 

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


# things to do
source /etc/bash_completion.d/virtualenvwrapper
export PATH=$PATH:/home/paulm/bin:/home/paulm/.gem/ruby/1.8/bin
#if [ $TERM = "xterm" ]; then
#        figlet -f fraktur tundra  | lolcat
#        /home/paulm/bin/weather_report
#fi
cd
## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
# Local variables:
# mode: sh
# End:
