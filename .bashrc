# ~/.bashrc: executed by bash(1) for non-login shells.


PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000000
HISTFILESIZE=2000000


PS1='$(printf %0.3d "${?}") \u@\h:$(sed "s#^${HOME}#~#" <<< "${PWD}") $(if test 0 = "${UID}"; then printf "#"; else printf "$"; fi) '
unset color_prompt
case "$TERM" in
    xterm-color)        color_prompt=yes;;
    xterm)              color_prompt=yes;;
    screen)             color_prompt=yes;;
esac

colors="$(tput colors 2>/dev/null)"
if ! grep -q '[0-9]' <<< "${colors}"; then
  colors=0
fi
if test "${colors}" -ge 8; then
  color_prompt=yes
fi
if [ "$color_prompt" = yes ]; then
  PS1='\[\e[0m\]$(printf %0.3d "${?}") \u\[\e[1;31m\]@\[\e[0m\]\h:$(sed "s#^${HOME}#~#" <<< "${PWD}") \[\e[1;31m\]$(if test 0 = "${UID}"; then printf "#"; else printf "$"; fi)\[\e[0m\] '
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(/usr/bin/dircolors -b ~/.dircolors)" || eval "$(/usr/bin/dircolors -b)"
  fi
fi
unset color_prompt


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


set -o vi
