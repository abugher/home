# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case "${-}" in *i*) ;; *) return;; esac


PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games


# aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# history
shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000000
HISTFILESIZE=2000000


# colors
PS1='${?} ${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
unset color_prompt
case "$TERM" in
    xterm-color)        color_prompt=yes;;
    xterm)              color_prompt=yes;;
    screen)             color_prompt=yes;;
esac
if test "$(tput colors)" -ge 8; then
  color_prompt=yes
fi
if [ "$color_prompt" = yes ]; then
  # color prompt
  PS1='$(printf %0.3d "${?}") \[\e[1;35m\]${debian_chroot:+($debian_chroot)}\u\[\e[0m\]\[\e[1;36m\]@\[\e[0m\]\[\e[1;32m\]\h\[\e[0m\]:${PWD##${HOME}?(/)}\[\e[1;32m\] \$\[\e[0m\] '
  # color output
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
fi
unset color_prompt


# tab completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# preferences
set -o vi
