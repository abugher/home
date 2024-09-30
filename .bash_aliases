if ls --color=auto >&/dev/null 2>&1; then
  alias ls='ls -N --color=auto'
  alias l="ls -N --color=auto -1tr"
else
  alias l="ls -N -1tr"
fi
alias grep='grep --color=auto'
alias dp='dw 5 | pass add -m'
alias dmesg='sudo dmesg'
alias startx='exec /usr/bin/startx'
alias i='mplayer -cache 5000 -cache-min 20 -osdlevel 3 -fs'
alias pianobar='timeout 9h pianobar'
alias tdome='(cd ~/.tintin/; tt++ config/tdome.tt)'
alias supertuxkart='inhibit supertuxkart'
