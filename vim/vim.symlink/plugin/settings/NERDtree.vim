" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let NERDTreeIgnore = ['\.pyc$']

" F3 to run
map <F3> :NERDTreeToggle<CR>

" Also map <leader>n for ipad time
noremap <Leader>n :NERDTreeToggle<CR>

" open it if nothing specified
autocmd vimenter * if !argc() | NERDTree | endif
