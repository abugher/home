# ~/.bashrc: executed by bash(1) for non-login shells.

# See other .bash* for aliases and such.

# Per user tab completion specifications are under:  
#   ~/.local/share/bash-completion/completions/


NEWPATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games
OLDPATH="$(
  for p in $(
    sed 's/:/\n/g' <<< "${PATH}"
  ); do 
    if ! grep -q "^${p}\$" <<< "$(
      sed 's/:/\n/g' <<< "${NEWPATH}"
    )"; then 
      echo -n ":${p}"
    fi; 
  done
)"
PATH="${NEWPATH}${OLDPATH}"


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


PS1="$(~/bin/setPS1)"

if terminal-has-color; then
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(/usr/bin/dircolors -b ~/.dircolors)" || eval "$(/usr/bin/dircolors -b)"
  fi
fi


shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000000
HISTFILESIZE=2000000


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


set -o vi


if ! test 'set' = "${SSH_AUTH_SOCK:+set}"; then
  eval "$(ssh-agent)" > /dev/null
fi


export GPG_TTY="$(tty)"
export PYTHONDONTWRITEBYTECODE=please
