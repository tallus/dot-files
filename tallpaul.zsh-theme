# ZSH Theme emulating the Fish shell's default prompt.

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe "
   BEGIN {
      binmode STDIN,  ':encoding(UTF-8)';
      binmode STDOUT, ':encoding(UTF-8)';
   }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
")
} 

autoload -U add-zsh-hook
ROOT_ICON_COLOR=$FG[111]
MACHINE_NAME_COLOR=$FG[208]
PROMPT_SUCCESS_COLOR=$FG[103]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]
PROMPT_PROMPT=$FG[208]
GIT_DIRTY_COLOR=$FG[124]
GIT_CLEAN_COLOR=$FG[148]
GIT_PROMPT_INFO=$FG[148]
LIGHTGREY=$FG[248]
GREY=$FG[242]



local user_color='green'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%{$GREY%}$(_fishy_collapsed_wd)%{$reset_color%} »%b '

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
local return_status="%{$LIGHTGREY%}%(?..%?)%{$reset_color%}"
RPROMPT='${return_status} $(prompt_git_info)$(git_prompt_status)%{$reset_color%}'

#RPROMPT='%{$GREY%}$(git_prompt_info)%{$reset_color%} »%b '


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[black]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""


#ZSH_THEME_GIT_PROMPT_PREFIX=" "
#ZSH_THEME_GIT_PROMPT_SUFFIX=""
#ZSH_THEME_GIT_PROMPT_DIRTY=""
#ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$LIGHTGREY%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$LIGHTGREY%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$LIGHTGREY%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$LIGHTGREY%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$LIGHTGREY%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$LIGHTGREY%}?"
