" Color column isn't just a simple thing here so... lets be complicated"
set colorcolumn=0
let s:color_column_old = 81

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction

command! ToggleColorColumn call <SID>ToggleColorColumn()
nnoremap <F4> :ToggleColorColumn<cr>
