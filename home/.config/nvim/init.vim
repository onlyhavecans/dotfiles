if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  if &shell =~# 'fish$'   "This is a compatibility fix for fish-shell and plugins
    set shell=sh
  endif
endif

" ==== vim plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim'}
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
Plug 'tpope/vim-surround'     " cs\" and cs' for surrounding
Plug 'tpope/vim-repeat'       " Make surround repeatable with .
Plug 'jremmen/vim-ripgrep'
Plug 'sheerun/vim-polyglot'   " Most language support

call plug#end()

" === Colorscheme
set background=dark
colorscheme Tomorrow-Night-Eighties

syntax enable
filetype plugin indent on
set list listchars=tab:→\ ,trail:∙,nbsp:+ " Display tabs and trailing spaces visually

" ==== Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
let backupdir = expand('~/.local/share/nvim/backups')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif
set undodir=~/.local/share/nvim/backups
set undofile

" ==== Scrolling
set scrolloff     =8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff =15
set sidescroll    =1
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" ================ My Cool shortcuts
let mapleader   = ","
let g:mapleader = ","

" <Leader>e = open vimrc in a split for quick editing
nnoremap <leader>e :tabnew $MYVIMRC<cr>

" <Leader>r = Reload vim config
noremap <Leader>r :so $MYVIMRC<CR>

" :w!! = write a file as sudo
cmap w!! w !sudo tee % >/dev/null

" :Q = quit all fast
command! -nargs=0 Quit :qall!

" ==== Plug
let g:plug_window = 'tabnew'

" ==== vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1

" ==== Ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ==== Straighten Quotes
function! <SID>StraightenQuotes()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/[”“„]/"/g
    %s/[’‘]/'/g
    %s/[…]/.../g
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! StraightenQuotes call <SID>StraightenQuotes()

" ==== Clean Ops Notes
function! <SID>CleanOpsNotes()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/ (.*)$//
    %s/^*/###/
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! CleanOpsNotes call <SID>CleanOpsNotes()

" ==== Strip trailing whitespace
" http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()

" ==== Super wrapping power
" http://vimcasts.org/episodes/soft-wrapping-text/
function! SetupWrapping()
  set wrap linebreak nolist
  set showbreak=…
endfunction

command! Wrap :call SetupWrapping()

" ==== Sourcing plugin specific setting
if filereadable(glob("~/.config/local/init.vim"))
  source ~/.config/local/init.vim
endif

" ==== local .vimrc with .envrc using add_extra_vimrc
if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source ".path
  endfor
endif

