" http://vimcasts.org/episodes/soft-wrapping-text/
function! SetupWrapping()
  set wrap
  set showbreak=…
endfunction

" TODO: this should happen automatically for certain file types (e.g. markdown)
command! -nargs=* Wrap :call SetupWrapping()<CR>

