hi! link txtBold Identifier
hi! link zshVariableDef Identifier
hi! link zshFunction Function
hi! link MatchParen DiffText

hi! link CTagsModule Type
hi! link CTagsClass Type
hi! link CTagsMethod Identifier
hi! link CTagsSingleton Identifier

hi! link javascriptFuncName Type
hi! link javascriptFunction Statement
hi! link javascriptThis Statement
hi! link javascriptParens Normal
hi! link jOperators javascriptStringD
hi! link jId Title
hi! link jClass Title

hi! link sassMixinName Function
hi! link sassDefinition Function
hi! link sassProperty Type
hi! link htmlTagName Type

hi! link NERDTreeFile Constant
hi! link NERDTreeDir Identifier
hi! PreProc gui=bold


" Enforce the colors set here
au VimEnter * so ~/.vim/settings/solarized.vim
