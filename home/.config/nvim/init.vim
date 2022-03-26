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
  let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#coc#show_coc_status = 1
  let g:airline#extensions#fzf#enabled = 1
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='base16_monokai'

" File navigation
Plug 'jremmen/vim-ripgrep'
  " Search word under cursor
  noremap <Leader>s :Rg<CR>
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  nnoremap <C-p> :Files<CR>
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
  let g:fzf_layout = { 'up': '~30%' }
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeGitStatusUseNerdFonts = 1

" Environment & intigrations
Plug 'tpope/vim-obsession'
Plug 'direnv/direnv.vim'              " load and respect direnv
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
  let g:tmux_navigator_disable_when_zoomed = 1

" Git
Plug 'tpope/vim-fugitive'     " git commands
Plug 'tpope/vim-rhubarb'      " Make fugitive do github
Plug 'airblade/vim-gitgutter' " Shows edits from git in gutter
  noremap <Leader>h :GitGutterLineHighlightsToggle<CR>
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager    = 0
  " Signs almost obnoxiously bright
  highlight GitGutterAdd    guifg=#74e800 ctermfg=2
  highlight GitGutterChange guifg=#e8e800 ctermfg=3
  highlight GitGutterDelete guifg=#fc007e ctermfg=1

" Editing tools
Plug 'kana/vim-textobj-user'           " needed for below
Plug 'kana/vim-textobj-entire'         " ae & ie for entire file text obj
Plug 'mg979/vim-visual-multi'          " Sublime's multi coursor w/ ^N
Plug 'wellle/targets.vim'              " i in, a an, I inside for quotes and braces
Plug 'michaeljsmith/vim-indent-object' " ai, ii, aI, & iI for indent based text obj
Plug 'tpope/vim-abolish'               " Super powered Substitition with Subvert
Plug 'tpope/vim-eunuch'                " Unix commands as first class
Plug 'tpope/vim-surround'              " cs\" and cs' for surrounding
Plug 'tpope/vim-repeat'                " Make surround repeatable with .
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  vmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)

" Prose Writing
Plug 'itspriddle/vim-marked'  " Marked 2 preview
Plug 'godlygeek/tabular'      " format tables
Plug 'preservim/vim-markdown' " Get hype with markdown
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_new_list_item_indent = 2
  let g:vim_markdown_folding_disabled = 1

" Generic code handling
Plug 'rizzatti/dash.vim'    " Spawn :Dash
  nmap <silent> <leader>d <Plug>DashSearch
Plug 'blueyed/delimitMate'  " Auto add closing braces
Plug 'tpope/vim-endwise'    " Close my definitions like I close my braces
Plug 'tpope/vim-commentary' " comment things with gc g<motion>c
  vnoremap <Leader>c :Commentary<CR>
  nnoremap <Leader>c :Commentary<CR>
Plug 'dense-analysis/ale'
  let g:ale_disable_lsp = 1
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Lang server
  let g:coc_global_extensions = [
        \'coc-css',
        \'coc-go',
        \'coc-json',
        \'coc-pyright',
        \'coc-rust-analyzer',
        \'coc-sh',
        \'coc-yaml',
        \]
  " c-space to trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()
  " Navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)
  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Run the Code Lens action on the current line.
  nmap <leader>cl  <Plug>(coc-codelens-action)

" Big Lang
Plug 'danihodovic/vim-ansible-vault' " Vault decrypt support
Plug 'dougireton/vim-chef'           " Sets filetypes chef and makes `gf` work with recipes
Plug 'LokiChaos/vim-tintin'          " tintin is rare to support
Plug 'sheerun/vim-polyglot'          " Most language support
Plug 'rust-lang/rust.vim'            " Force rust
  let g:rustfmt_autosave = 1

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
nnoremap <F6> <Plug>(coc-refactor)
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
set wildmenu               " ctrl-n and ctrl-p in completion
set undofile               " Persistent Undo, stored globally
set autowrite              " Save on buffer switch

" How do you like your whitespace?
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set expandtab

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h15

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" =====================================
" AutoCommands
" =====================================

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Strip Whitespace on write
autocmd BufWritePre * %s/\s\+$//e

" Highlight what I yank for 3 seconds
au TextYankPost * silent! lua vim.highlight.on_yank {timeout=3000}

" =====================================
" My Functions
" =====================================

" ==== Straighten Quotes
function! <SID>StraightenQuotes()
    " Preparation save last search, and cursor position.
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
    " Preparation save last search, and cursor position.
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
function! <SID>SetupWrapping()
  set wrap linebreak nolist
  set showbreak=…
endfunction
command! Wrap call <SID>SetupWrapping()

function! <SID>TitleCase()
  '<,'>s#\v(\w)(\S*)#\u\1\L\2#g
endfunction
command! -range TitleCase call <SID>TitleCase()

" =====================================
" Source plugin specific setting
" =====================================
silent! source ~/.config/local/init.vim
