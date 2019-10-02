if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  if &shell =~# 'fish$'   "This is a compatibility fix for fish-shell and plugins
    set shell=sh
  endif
endif

let g:loaded_python_provider = 1
let g:python3_host_prog = glob('~/.asdf/shims/python3')

" ==== Most ALE settings want to be loaded before plugins

let g:ale_close_preview_on_insert = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_list_window_size = 4
let g:ale_open_list = 1
let g:alt_completion_enabled =1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'rust': ['rustfmt'],
      \}

" ==== vim plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Core functionality
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'        " I like being on the airline
Plug 'jremmen/vim-ripgrep'            " Ripgrep's time has come
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Play better w/ tmux
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
Plug 'wellle/tmux-complete.vim'

" The tpope section
Plug 'tpope/vim-fugitive'   " make git commands a thing
Plug 'tpope/vim-rhubarb'    " but use hub
Plug 'tpope/vim-surround'   " cs\" and cs' for surrounding
Plug 'tpope/vim-repeat'     " Make surround repeatable with .
Plug 'tpope/vim-commentary' " comment things with gc g<motion>c
Plug 'tpope/vim-endwise'    " Close my definitions like I close my braces

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Text Alignment plugin
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Big Lang
Plug 'sheerun/vim-polyglot'   " Most language support
Plug 'rust-lang/rust.vim'     " Official Rust plugin
Plug 'dougireton/vim-chef'    " Sets filetypes with chef and sets path to make `gf` work with recipes
Plug 'dag/vim-fish'           " Fish shell

" Erlang Support
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-compiler'

Plug 'blueyed/delimitMate'    " Autoadding closing braces
Plug 'airblade/vim-gitgutter' " Shows edits from git in gutter
Plug 'dense-analysis/ale'     " syntax checking and Language Server

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" My special plugins
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'itspriddle/vim-marked'
Plug 'LokiChaos/vim-tintin'
call plug#end()

let g:deoplete#enable_at_startup = 1

" === Colorscheme
set background=dark
colorscheme vim-monokai-tasty
let g:airline_theme='monokai_tasty'

" ==== make nvim less annoyting
set clipboard+=unnamedplus

" ==== General sanity fixing
set encoding=utf-8
set fileencoding=utf-8
syntax enable
filetype plugin indent on
set autoindent
set backspace=indent,eol,start  "Allow backspace in insert mode
set expandtab
set foldmethod=indent
set incsearch "Find the next match as we type the search
set linebreak "Wrap lines at convenient points
set list listchars=tab:→\ ,trail:∙,nbsp:+ "Display tabs and trailing spaces visually
set nobackup
set nofoldenable "no fold by default ever
set noswapfile
set nowrap
set nowritebackup
set nrformats= "blank nrf to make ^a always binary
set number
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest,full

set mouse=a

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

" <F1> = Disable help
nnoremap <F1> <nop>

" <F2> = Toggle line numbers
nnoremap <F2> :set invnumber<CR>

" <F3> = Toggle NerdTree
nnoremap <F3> :NERDTreeToggle<CR>

" <F4> = change directory to current file's pwd
nnoremap <F4> :cd %:p:h<CR>:pwd<CR>

" <F5> = Language Server menu
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" <F6> = Refactor
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

" <F7> = Toggle paste mode
set pastetoggle=<F7>

" <F8> = next buffer

" <F9> = None
" nmap <F9> <nop>

" // = clears search highlight
nnoremap <silent> // :noh<CR>

nnoremap XX :qall!<CR>

" K = Disable man key
nnoremap K <nop>

" jk smash = esc! Seriously, esc on the homerow
inoremap jk <Esc>

" Y = copy from current character to end of line
" (mimic y0's behavior but backwards)
noremap Y y$

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" <Leader>b = blagfix (strip curlies)
nnoremap <Leader>b :StraightenQuotes<CR>

" <Leader>c = comment out
vnoremap <Leader>c :Commentary<CR>
nnoremap <Leader>c :Commentary<CR>

" <Leader>d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
xnoremap <silent> <leader>d "_d

" <Leader>e = open vimrc in a split for quick editing
nnoremap <leader>e :tabnew $MYVIMRC<cr>

" <Leader>f = toggle all folding
noremap <Leader>f zi

" <Leader>h = Highlight changed lines using Git Gutter
noremap <Leader>h :GitGutterLineHighlightsToggle<CR>

" <Leader>n = NERDTree
nnoremap <Leader>n :NERDTreeToggle<Enter>

" <Leader>P = paste at end of line
inoremap <Leader>P :normal $p
nnoremap <Leader>P $p

" <Leader>p = paste in next line
inoremap <Leader>p :normal pu<CR>
nnoremap <Leader>p :pu<CR>

" <Leader>q = Auto rewrap
vnoremap <Leader>q gq
nnoremap <Leader>q gqap

" <Leader>r = Reload vim config
noremap <Leader>r :so $MYVIMRC<CR>

" <Leader>s = Search under word in my current search obsession
noremap <Leader>s :Rg<CR>

" <Leader>t = TabNext
nnoremap <Leader>t :tabNext<CR>

" <Leader>w = Strip all whitespace (from yadr-whitespace-killer.vim)
nnoremap <Leader>w :StripTrailingWhitespaces<CR>

" <Leader>z = quick write/save
nnoremap <Leader>z :write<CR>

" <C-p> the fast file Ctrl-p from Subl
nnoremap <C-p> :Files<CR>

" :w!! = write a file as sudo
cmap w!! w !sudo tee % >/dev/null

" :Q = quit all fast
command! -nargs=0 Quit :qall!

" ==== Rust.vim
let g:rustfmt_autosave = 1

" ==== ale
let g:airline#extensions#ale#enabled = 1

" ==== deoplete
let g:tmuxcomplete#trigger = ''
let g:deoplete#enable_at_startup = 1

" ==== Plug
let g:plug_window = 'tabnew'

" ==== airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 1

" ==== GitGutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager    = 0

" ==== Powerline
set laststatus=2

" ==== vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1

" ==== Nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize=20

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ==== Ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ==== FZF fixes
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
let g:fzf_layout = { 'up': '~40%' }

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

command! -nargs=* Wrap :call SetupWrapping()

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
