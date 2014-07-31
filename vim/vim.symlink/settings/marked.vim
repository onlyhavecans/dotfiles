function! s:setupMarkup()
  nnoremap <leader>p :silent !open -a Marked 2.app '%:p'<cr>
endfunction

au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
