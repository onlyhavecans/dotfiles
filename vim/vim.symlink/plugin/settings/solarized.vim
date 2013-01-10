
if has('gui_running')
    set background=dark
else
    set background=light
endif

hi! link txtBold Identifier
hi! link zshVariableDef Identifier
hi! link zshFunction Function
hi! link MatchParen DiffText

" Enforce the colors set here
au VimEnter * so ~/.vim/plugin/settings/solarized.vim
