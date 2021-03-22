if has('vim_starting')
  if &compatible
    set nocompatible
  endif
endif

let g:loaded_python_provider = 1
let g:python3_host_prog = glob('~/.asdf/shims/python3')


" ==== Most ALE settings need to be loaded before plugins
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}


" ==== I use some alt plugins, again preload
let g:polyglot_disabled = ['markdown', 'go']


" ==== vim plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:plug_window = 'tabnew'
call plug#begin('~/.local/share/nvim/plugged')

" Start with the look
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File browsing
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }

" Play better w/ tmux
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
Plug 'wellle/tmux-complete.vim'

" General behaviors
Plug 'jremmen/vim-ripgrep'    " Use ripgrep everywhere
Plug 'blueyed/delimitMate'    " Auto add closing braces
Plug 'airblade/vim-gitgutter' " Shows edits from git in gutter
Plug 'direnv/direnv.vim'      " load and respect direnv
Plug 'itspriddle/vim-marked'  " Marked 2 preview
Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'} " GhostText Browser support

" The tpope section
Plug 'tpope/vim-commentary' " comment things with gc g<motion>c
Plug 'tpope/vim-endwise'    " Close my definitions like I close my braces
Plug 'tpope/vim-fugitive'   " Do git in vim
Plug 'tpope/vim-markdown', {'for': 'markdown'} " Good markdown highlighting
Plug 'tpope/vim-repeat'     " Make surround repeatable with .
Plug 'tpope/vim-rhubarb'    " Make fugitive do github
Plug 'tpope/vim-surround'   " cs\" and cs' for surrounding

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Text Alignment plugin
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'

" Big Lang
Plug 'sheerun/vim-polyglot'   " Most language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'golang', 'tag': '*'} " Better go
Plug 'dougireton/vim-chef'    " Sets filetypes chef and makes `gf` work with recipes
Plug 'LokiChaos/vim-tintin'   " tintin is rare to support
Plug 'dense-analysis/ale'     " Laguage Server

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()


" ==== My Cool shortcuts
let mapleader   = ","

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
noremap <Leader>r :so $MYVIMRC<CR>

" <Leader>s = Search under word in my current search obsession
noremap <Leader>s :Rg<CR>

" <Leader>t = TabNext
nnoremap <Leader>t :tabNext<CR>

" <Leader>w = Strip all whitespace (from yadr-whitespace-killer.vim)
nnoremap <Leader>w :StripTrailingWhitespaces<CR>

" <C-p> the fast file Ctrl-p from Subl
nnoremap <C-p> :Files<CR>

" :w!! = write a file as sudo
cmap w!! w !sudo tee % >/dev/null

" :Q = quit all fast
command! -nargs=0 Quit :qall!


" ==== My special NeoVim behaviors
set clipboard+=unnamedplus " macOS clipboard
set linebreak " Wrap lines at convenient points
set list listchars=tab:→\ ,trail:∙,nbsp:+ " Display tabs and trailing spaces
set mouse=a " Mouse Correctly in macOS
set nowrap " Default to not wrapping
set wildmenu " ctrl-n and ctrl-p in completion


" ==== How do you like your whitespace?
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2


" ==== Colorscheme
set termguicolors
colorscheme monokai_pro
let g:airline_theme='base16_monokai'


" ==== Needed for Powerline, Airline, Lightline, etc
set laststatus=2
set noshowmode " Disable native mode display


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
set scrolloff     =5 "Start scrolling at 8 lines from margins
set sidescrolloff =15
set sidescroll    =1
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="


" ==== airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1


" ==== deoplete
let g:tmuxcomplete#trigger = ''
let g:deoplete#enable_at_startup = 1


" ==== GitGutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager    = 0
" Signs almost obnoxiously bright
highlight GitGutterAdd    guifg=#74e800 ctermfg=2
highlight GitGutterChange guifg=#e8e800 ctermfg=3
highlight GitGutterDelete guifg=#fc007e ctermfg=1


" ==== vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1


" ==== Nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 30
" Start NERDTree when Vim (NOT VimR) is started without file arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if !has("gui_vimr") && argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if !has("gui_vimr") && tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" ==== Ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif


" ==== FZF fixes
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
let g:fzf_layout = { 'up': '~30%' }


" ==== GhostText
augroup nvim_ghost_user_autocommands
  au User www.reddit.com,www.stackoverflow.com set filetype=markdown
  au User *github.com set filetype=markdown
augroup END


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


" ==== Sourcing plugin specific setting
if filereadable(glob("~/.config/local/init.vim"))
  source ~/.config/local/init.vim
endif
