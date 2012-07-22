function! Terms()
  call inputsave()
  let searchterm = input('Search: ')
  call inputrestore()
  return searchterm
endfunction
map © <ESC>:! /usr/bin/open -a "/Applications/Safari.app" 'https://duckduckgo.com/?q=<C-R>=Terms()<CR>'<CR><CR>
