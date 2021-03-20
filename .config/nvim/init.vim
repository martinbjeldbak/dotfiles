call plug#begin(stdpath('data') . '/plugged')

Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-surround'

Plug 'vim-test/vim-test'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
Plug 'tpope/vim-commentary'

" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Theme
Plug 'arcticicestudio/nord-vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

set termguicolors
syntax enable

set undofile

colorscheme nord
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

set number
set list " show whitespace

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:python3_host_prog = '/Users/madsenm1/.virtualenvs/py3nvim/bin/python'
let g:NERDTreeGitStatusUseNerdFonts = 1

let mapleader = ","

" Support indentation https://vim.fandom.com/wiki/Indenting_source_code
set expandtab
set shiftwidth=2
set softtabstop=2

set clipboard+=unnamedplus

set mouse=a
set smartcase

" simplify line keyboard mappings
map H ^
map L $

" remap space to search
nmap <Space> /\c
map <Leader>m :Ag<CR>
map <C-p> :Files<CR>
map <C-b> :Buffers<CR>

nmap <leader>w :w!<CR>
nmap <leader>wq :wq!<CR>

""" coc recommended setttings
set cmdheight=2

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

""" end coc config

"" fzf plugin

let g:fzf_preview_filelist_command = 'rg --files --ignore-case --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
nnoremap <C-b>     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <C-p>     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <Leader>m    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap <Leader>m "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"


" Use vim-devicons
let g:fzf_preview_use_dev_icons = 1

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Neoterm and vim-test
let test#strategy = "neovim" "neoterm
map <leader>a :w<CR>:TestSuite<CR>
map <leader>f :w<CR>:TestFile<CR>
map <leader>r :w<CR>:TestNearest<CR>
map <leader>l :w<CR>:TestLast<CR>
map <leader>v :w<CR>:TestVisit<CR>

" https://github.com/neoclide/coc.nvim/issues/617
" disable mapping to not break coc.nvim (I don't even use them anyways)
let g:endwise_no_mappings = 1
