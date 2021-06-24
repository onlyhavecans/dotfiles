let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = '/usr/local/bin/python3'
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

let mapleader   = ","

" =====================================
" vim plug
" =====================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  let g:plug_window = 'tabnew'

" Start with the look
Plug 'phanviet/vim-monokai-pro'

" Put a status on it
Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#ale#enabled = 1
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='base16_monokai'

" File browsing
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
  nnoremap <Leader>n :NERDTreeToggle<Enter>
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let NERDTreeShowBookmarks = 1
  let NERDTreeWinSize = 30
  " Exit Vim if NERDTree is the only window left.
  autocmd BufEnter * if !has("gui_vimr") && tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" File navigation
Plug 'jremmen/vim-ripgrep'
  " Search word under cursor
  noremap <Leader>s :Rg<CR>
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  nnoremap <C-p> :Files<CR>
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
  let g:fzf_layout = { 'up': '~30%' }

" Environment & intigrations
Plug 'tpope/vim-obsession'
Plug 'direnv/direnv.vim'              " load and respect direnv
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
  let g:tmux_navigator_disable_when_zoomed = 1
Plug 'wellle/tmux-complete.vim'       " Add all of tmux to deoplete completion
  let g:tmuxcomplete#trigger = ''     " Use deoplete

" Git
Plug 'tpope/vim-fugitive'     " git commands
Plug 'tpope/vim-rhubarb'      " Make fugitive do github
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter' " Shows edits from git in gutter
  noremap <Leader>h :GitGutterLineHighlightsToggle<CR>
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager    = 0
  " Signs almost obnoxiously bright
  highlight GitGutterAdd    guifg=#74e800 ctermfg=2
  highlight GitGutterChange guifg=#e8e800 ctermfg=3
  highlight GitGutterDelete guifg=#fc007e ctermfg=1

" Editing tools
Plug 'kana/vim-textobj-user'   " needed for below
Plug 'kana/vim-textobj-entire' " ae and ie for entire file movement
Plug 'mg979/vim-visual-multi'  " Sublime's multi coursor w/ ^N
Plug 'tpope/vim-eunuch'        " Unix commands as first class
Plug 'tpope/vim-surround'      " cs\" and cs' for surrounding
Plug 'tpope/vim-repeat'        " Make surround repeatable with .
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  vmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1

" Prose Writing
Plug 'itspriddle/vim-marked'  " Marked 2 preview
Plug 'junegunn/goyo.vim'      " Minimal text writing
  nmap <Leader>m :Goyo<CR>
Plug 'junegunn/limelight.vim' " typewriter writers mode
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

" Generic code handling
Plug 'rizzatti/dash.vim'    " Spawn :Dash
  nmap <silent> <leader>d <Plug>DashSearch
Plug 'blueyed/delimitMate'  " Auto add closing braces
Plug 'tpope/vim-endwise'    " Close my definitions like I close my braces
Plug 'tpope/vim-commentary' " comment things with gc g<motion>c
  vnoremap <Leader>c :Commentary<CR>
  nnoremap <Leader>c :Commentary<CR>

" Big Lang
Plug 'fatih/vim-go'                  " I write too much go
  " don't jump to errors after metalinter is invoked
  let g:go_jump_to_error = 0
  " run go imports on file save
  let g:go_fmt_command = "goimports"
  " automatically highlight variable your cursor is on
  let g:go_auto_sameids = 0
Plug 'danihodovic/vim-ansible-vault' " Vault decrypt support
Plug 'dougireton/vim-chef'           " Sets filetypes chef and makes `gf` work with recipes
Plug 'LokiChaos/vim-tintin'          " tintin is rare to support
Plug 'sheerun/vim-polyglot'          " Most language support
  let g:polyglot_disabled = ['markdown', 'go']

Plug 'dense-analysis/ale' " Laguage Server
  let g:ale_fix_on_save = 1
  let g:ale_floating_preview = 1
  let g:ale_fixers = {'*': ['remove_trailing_lines']}

Plug 'andrewstuart/vim-kubernetes' " gives KubeApply and KubeDelete
call plug#end()


" =====================================
" Cool shortcuts
" =====================================
" <F1> = Help
" <F2> = Toggle line numbers
nnoremap <F2> :set invnumber<CR>
" <F3> = Toggle NerdTree
nnoremap <F3> :NERDTreeToggle<CR>
" <F4> = change directory to current file's pwd
nnoremap <F4> :cd %:p:h<CR>:pwd<CR>
" <F5> = None
" <F6> = Refactor
" <F7> = Toggle paste mode
set pastetoggle=<F7>
" <F8> = Next buffer
" <F9> = None
" nonmap <F9> <nop>

" // = clears search highlight
nnoremap <silent> // :nohlsearch<CR>

" XX = The oppisite of ZZ, quit all NO SAVE
nnoremap XX :qall!<CR>

" <Leader>b = blagfix (strip curlies)
nnoremap <Leader>b :StraightenQuotes<CR>

" <Leader>e = open vimrc in a split for quick editing
nnoremap <leader>e :tabnew $MYVIMRC<cr>

" <Leader>f = toggle all folding
noremap <Leader>f zi

" <Leader>p = paste in next line
inoremap <Leader>p :normal pu<CR>
nnoremap <Leader>p :pu<CR>

" <Leader>P = paste in previous line
inoremap <Leader>P :normal pu!<CR>
nnoremap <Leader>P :pu!<CR>

" <Leader>q = Auto rewrap
vnoremap <Leader>q gq
nnoremap <Leader>q gqap

" <Leader>r = Reload vim config
noremap <Leader>r :source $MYVIMRC<CR>

" <Leader>t = TabNext
nnoremap <Leader>t :tabNext<CR>

" <Leader>w = Strip all whitespace
nnoremap <Leader>w :StripTrailingWhitespaces<CR>

" :w!! = write a file as sudo
cmap w!! w !sudo tee % >/dev/null

" :Q = quit all fast
command! -nargs=0 Quit :qall!


" =====================================
" My special NeoVim behaviors
" =====================================
set termguicolors
colorscheme monokai_pro

set list listchars=tab:→\ ,trail:∙,nbsp:+ " Display tabs and trailing spaces
set clipboard+=unnamedplus " macOS clipboard
set laststatus=2           " Needed for *line plugins
set linebreak              " Wrap lines at convenient points
set mouse=a                " Mouse Correctly in macOS
set noshowmode             " mode is in the *line
set nowrap                 " Default to not wrapping
set scrolloff=5            " Start scrolling vertically before margin
set sidescrolloff=5        " Start scrolling horizontally before margin
set wildmenu               " ctrl-n and ctrl-p in completion
set undofile               " Persistent Undo, stored globally
set autowrite              " Save on buffer switch

" How do you like your whitespace?
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" =====================================
" AutoCommands
" =====================================

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Strip Whitespace on write
autocmd BufWritePre * %s/\s\+$//e

" =====================================
" My Functions
" =====================================

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


" =====================================
" Source plugin specific setting
" =====================================
silent! source ~/.config/local/init.vim
