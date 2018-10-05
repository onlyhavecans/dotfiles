cd ~
set t_Co=256
let g:solarized_termcolors=256
set background=light
colorscheme bubblegum-256-light

set lines=45
set columns=90

" Show tab number (useful for Cmd0, Cmd-2.. mapping)
" For some reason this doesn't work as a regular set command,
" (the numbers don't show up) so I made it a VimEnter event
autocmd VimEnter * set guitablabel=%N:\ %t\ %M

" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

if has("gui_macvim")
  set gfn=PragmataPro:h18

  set guioptions=aAce
  set guioptions-=T
  set fuoptions=maxvert,maxhorz
  set noballooneval

  " resize current buffer by +/- 5
  nnoremap <M-Right> :vertical resize +5<CR>
  nnoremap <M-Left>  :vertical resize -5<CR>
  nnoremap <M-Up>    :resize -5<CR>
  nnoremap <M-Down>  :resize +5<CR>

  " Command+Option+Right for next
  map <D-M-Right> :tabn<CR>
  " Command+Option+Left for previous
  map <D-M-Left>  :tabp<CR>

  " Automatically resize splits
  " when resizing MacVim window
  autocmd VimResized * wincmd =
endif