# ~/.bashrc: executed by bash(1) for non-login shells.


PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000000
HISTFILESIZE=2000000


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


# Colors:
# 0 = clear formatting?
# 30 = invisible?
# 31 = red
# 32 = green
# 33 = amber
# 34 = blue
# 35 = magenta
# 36 = cyan
# 37 = gray

# Background colors:
# 40 = black?  invisible?
# 41 = red
# 42 = green
# 43 = amber
# 44 = blue
# 45 = magenta
# 46 = cyan
# 47 = gray

# Modifiers:
# 0 = default
# 1 = bright
# 2 = dim
# 3 = italics
# 4 = underline
# 5 = blink
# 6 = blink
# 7 = invert fg/bg
# 8 = invisible?
# 9 = strikethrough

# Setting foreground clears background.  Not vice versa.

ps1_clear='\[\e[0m\]'

function ps1_color_code() {
  color="${1}"
  modifier="${2:-0}"
  printf '\\[\\e[%s;%sm\\]' "${modifier}" "${color}"
}

function ps1_background_code() {
  color="${1}"
  printf '\\[\\e[%sm\\]' "${color}"
}

ps1_default_color="$(ps1_color_code 37 3)"

if test 0 = "${UID}"; then 
  ps1_splash_color="$(ps1_color_code 31 7)"
else 
  ps1_splash_color="$(ps1_color_code 32 0)"
fi

PS1='$(printf %0.3d "${?}") \u@\h:$(sed "s#^${HOME}#~#" <<< "${PWD}") $(if test 0 = "${UID}"; then printf "#"; else printf "$"; fi) '
if [ "$color_prompt" = yes ]; then
  ps1_ret="$(ps1_background_code 44)"'$(printf %3d "${?}")'"${ps1_clear}"
  ps1_user="${ps1_default_color}\\u${ps1_clear}"
  ps1_at="${ps1_splash_color}@${ps1_clear}"
  ps1_host="${ps1_default_color}\\h${ps1_clear}"
  ps1_colon="${ps1_splash_color}:${ps1_clear}"
  ps1_pwd="${ps1_default_color}"'$(sed "s#^${HOME}#~#" <<< "${PWD}")'"${ps1_clear}"
  ps1_sigil="${ps1_splash_color}$(
    if test 0 = "${UID}"; then 
      printf '#'
    else 
      printf '$'
    fi
  )${ps1_clear}"
  PS1="${ps1_ret} ${ps1_user}${ps1_at}${ps1_host}${ps1_colon}${ps1_pwd}${ps1_sigil} "
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
