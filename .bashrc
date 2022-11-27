# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case "${-}" in *i*) ;; *) return;; esac

set -o vi

PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games

shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000000
HISTFILESIZE=2000000

unset color_prompt force_color_prompt
case "$TERM" in
    xterm-color)        color_prompt=yes;;
    xterm)              color_prompt=yes;;
    screen)             color_prompt=yes;;
esac
if test "$(tput colors)" -ge 8; then
  color_prompt=yes
fi
if [ "$color_prompt" = yes ]; then
    PS1='$(printf %0.3d "${?}") \[\e[1;35m\]${debian_chroot:+($debian_chroot)}\u\[\e[0m\]\[\e[1;36m\]@\[\e[0m\]\[\e[1;32m\]\h\[\e[0m\]:${PWD##${HOME}?(/)}\[\e[1;32m\] \$\[\e[0m\] '
else
    PS1='${?} ${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
fi
unset color_prompt force_color_prompt
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NETHACKOPTIONS="@${HOME}/.nethackrc"
