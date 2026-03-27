" Comments start with a double quote.
" Remember:
"   :help foo

" The mere existence of ~/.vimrc disables loading of defaults.vim, found at a
" path similar to:  
" 
"   /usr/share/vim/vim91/defaults.vim
"
" If vim behaves differently with no rc file than with this rc file in ways
" that seem unrelated to these settings, that might be why.


" Don't be vi.  This touches other options, so set it early to avoid undoing
" other settings.
set             nocompatible


" Filetype handling:
"
" Note:  Filetype handling seems to happen after loading general settings,
" thus overriding them, even if the settings lines are written after the
" filetype handling lines.  Force overrides with "autocommand BufWinEnter
" ...".
"
" Detect filetype automatically.
filetype        detect
" Load plugins based on filetype.  Among other things, plugins define comment
" indicators.  Without this, vim will not wrap comments in vimrc correctly.
filetype        plugin on
" Do not load indentation specs based on filetype.  I am fairly attached to my
" own ideas about indentation, regardless of language.
filetype        indent off
" Syntax highlighting.  This is also specific to filetype, but independent from
" filetype plugins.
syntax          on
" Syntax highlighting should take the whole file into account, not break
" when I fold a hundred lines.
syntax          sync fromstart
" If ':set syn=sh' (manually or by filetype detection), use Bash syntax, not
" generic sh.
let             b:is_bash=1
" See autocmd lines further down for more filetype-specific configuration.


" Security:
" 
" Don't let contents of edited files control editor settings.  That's a stupid
" idea.  Even if it weren't a security risk, I just don't like it.
set             nomodeline


" Indentation:
"
" nosmartindent + autoindent does the dumb autoindenting I like.  Generally,
" hitting enter yields a new line at the same indentation level as the previous
" line, and it doesn't screw up #comments, which is my biggest sore point.
"
" You might want to set smartindent for lists with leading dashes.
set             autoindent
set             nosmartindent
set             nocindent


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


" Line wrapping:
"
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
"
" Filetype plugins tend to mess with formatoptions, overriding this setting.
" See autocmd lines, further down, overriding the override.
set             formatoptions=tcql
" By default, never automatically wrap.  Override this further down.
set             textwidth=0


" Appearance:
" 
set             background=dark
" Use colorscheme 'lunaperche', but remove reverse specs (term=reverse
" cterm=reverse gui=reverse) from highlight group 'MatchParen'.  ('reverse'
" highlights the matching paren instead of the selected one, creating the
" visual impression of a cursor jump.  Otherwise, the matching paren gets a
" soft highlight.)
colorscheme     lunaperche
highlight       clear MatchParen
highlight       MatchParen ctermfg=30 ctermbg=16 guifg=#c5e7c5 guibg=#000000


" Backspace over various things.
set             backspace=indent,eol,start
" Show the line and character numbers of the cursor position.
set             ruler
" Mouse selection and vim visual selection are different and should remain so.
set             mouse=
" Scroll the page before the cursor hits the top or bottom.
set             scrolloff=10
" "za" to collapse indented sections of text.  "zR" to collapse all.  ":set
" foldlevel=0" to collapse all.
set             foldmethod=indent
" "zg" to add a word to the dictionary.  Those entries go to this file.  Edit
" the file to remove or alter entries.
set             spellfile=$HOME/.dictionary.utf-8.add


" Functions:
"
" This function should restore cursor position when editing a previously
" edited file.
function! RestoreCursor()
  if line("'\"") <= line("$")
    normal!     g`"
    return      1
  endif
endfunction


" Autocommands (autocmd):
"
" Settings here can override filetype plugins.  The BufWinEnter event happens
" after filetype plugins have finished.
" 
" `:source ~/.vimrc` could lead to buildup of redundant autocmd entries, but
" autocmd lines can be crafted to avoid that by organizing them into a group or
" groups and starting each group with `autocmd!`, clearing existing
" autocommands in that group.
"
" It is possible to write functions to conditionally set options based on
" detected filetype rather than relying on file extensions.  That might be a
" better approach than what is currently written below, but this seems adequate
" for some use cases.

augroup         vimrc
  " Define global (any file extension) options first, to allow overrides
  " further down.
  autocmd!
  " Restore cursor position using function defined above.
  autocmd       BufWinEnter     *               call            RestoreCursor()
  " Override annoying settings from filetype plugins (which override my
  " settings above).
  autocmd       BufWinEnter     *               setlocal        formatoptions=tcql
  autocmd       BufWinEnter     *               setlocal        textwidth=0
  " Remember a "view" per-file.  This preserves folds and manual settings.
  " Unfortunately, new settings from vimrc files will not be loaded until
  " either the view file is removed or the vimrc file is sourced manually.
  " (Technically, I think the new vimrc file will be parsed, but then loading
  " the old view overwrites the settings.)
  autocmd       BufWinLeave     ?*              mkview
  autocmd       BufWinEnter     ?*              loadview
  " Makefiles need real tabs.
  autocmd       BufWinEnter     [Mm]akefile     setlocal        noexpandtab
  autocmd       BufWinEnter     [Mm]akefile     setlocal        nosmarttab
  " Override textwidth yet again.
  autocmd       BufWinEnter     *.txt           setlocal        textwidth=72
  " Only spellcheck text.
  autocmd       BufWinEnter     *.txt           setlocal        spell
augroup         END

