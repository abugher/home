" Comments start with a double quote.
" Remember:
"   :help foo

set             nocompatible
set             nomodeline
set             backspace=indent,eol,start
set             ruler
set             mouse=
syntax          on

set             foldmethod=indent
set             spellfile=$HOME/.dictionary.utf-8.add

set             background=dark
" Use colorscheme 'lunaperche', but remove reverse specs (term=reverse
" cterm=reverse gui=reverse) from highlight group 'MatchParen'.  ('reverse'
" highlights the matching paren instead of the selected one, creating the
" visual impression of a cursor jump.  Otherwise, the matching paren gets a
" soft highlight.)
colorscheme     lunaperche
highlight       clear MatchParen
highlight       MatchParen ctermfg=30 ctermbg=16 guifg=#c5e7c5 guibg=#000000


" Tabs
"
"   1 and 2 set the width considered to be a "tab" to eight spaces.
"   3 sets indentation to two spaces.
"   4 makes sure all tabs are entered as spaces.
"   5 basically enables context awareness when hitting the tab key.  It causes
"   tabs entered at the beginning of a line to be shiftwidth wide, for example.
"
set             tabstop=8           " 1
set             softtabstop=8       " 2
set             shiftwidth=2        " 3
set             expandtab           " 4
set             smarttab            " 5

" nosmartindent + autoindent does the dumb autoindenting I like.  Generally,
" hitting enter yields a new line at the same indentation level as the previous
" line, and it doesn't screw up #comments, which is my biggest sore point.
"
" You might want to set smartindent for lists with leading dashes.
set             autoindent
set             nosmartindent
set             nocindent

" formatoptions flags:
" t - Automatically wrap text while typing or with "gq".  (How does vim know
"     when editing text vs code?)
" c - Continue comments when a new line is created because textwidth was
"     reached.  (No effect if `tw=0`.)
" q - Rewrap comments with "gq".  (Somehow works even with `tw=0`.)
" l - Long lines stay long.  If a line is already longer than textwidth, it
"     will not wrap while typing.
" 
" Avoided flags:
" r - Continue comments with [Return] in insert mode.
" o - Continue comments with "o" or "O".

" comments comments comments comments comments comments comments comments comments comments
set             formatoptions=tcql

" ----

" Load autocommands only once.
"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1

" Makefiles need real tabs.
au BufWinEnter  [Mm]akefile     setlocal noexpandtab
au BufWinEnter  [Mm]akefile     setlocal nosmarttab

" Set width to 72 only if file ends in .txt.
au BufWinEnter  *.txt           setlocal textwidth=72
au BufWinEnter  *.txt           setlocal spell

" Remember a "view" per-file.  This preserves folds, and presumably other
" things.  
au BufWinLeave  ?*              mkview
au BufWinEnter  ?*              loadview

" This awful mess should put the cursor at the last position per-file:
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Syntax highlighting should take the whole file into account, not break
" when I fold a hundred lines.
autocmd BufEnter * :syntax sync fromstart

"endif " autocommands_loaded

" If ':set syn=sh', use Bash syntax, not generic sh.
let b:is_bash=1
