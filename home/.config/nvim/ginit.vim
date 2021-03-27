" I want some uniquely vimr behaviors
set number " Line numbers by default in vimr

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
