call plug#begin('~/.config/nvim/.vim/plugged')

" UI & util
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'rizzatti/dash.vim', { 'on': 'Dash' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular' " to line up text
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-signify'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'dense-analysis/ale'

Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'bronson/vim-trailing-whitespace'
Plug 'janko-m/vim-test'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'sheerun/vim-polyglot' " includes lots of languages
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'css', 'scss'] }
Plug 'skammer/vim-css-color', { 'for': ['html', 'css', 'scss'] }
Plug 'tpope/vim-commentary'
Plug 'vim-latex/vim-latex', { 'for': 'tex' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'ekalinin/Dockerfile.vim'

" Uncommented until I learn how to use them
" Plug 'cespare/vim-bclose'
" Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Tmux integration
" Plug 'jpalardy/vim-slime' " send text to tmux session
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'

" Haskell
" Plug 'bitc/vim-hdevtools',  { 'for': 'haskell' }
" Plug 'eagletmt/neco-ghc',   { 'for': 'haskell' }
" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
" Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
" Plug 'raichoo/haskell-vim', { 'for': 'haskell' }
" Plug 'Shougo/vimproc.vim',  { 'for': 'haskell', 'do': 'make' }

" Ruby
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
" Plug 'scrooloose/nerdcommenter', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " automatically add 'end'
" Plug 'p0deje/vim-ruby-interpolation', { 'for': 'ruby' }
" Plug 'stefanoverna/vim-i18n', { 'for': 'ruby' }

" CSS color highlighter
Plug 'ap/vim-css-color', { 'for': ['css', 'sass', 'scss', 'less'] }

" Python
Plug 'nvie/vim-flake8', { 'for': 'python' } " python syntax checker

" JavaScript
Plug 'pangloss/vim-javascript'
" Plug 'jaawerth/nrun.vim'
" Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install'  }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" Themes
" Plug 'altercation/vim-colors-solarized'
" Plug 'lifepillar/vim-solarized8'
" Plug 'iCyMind/NeoSolarized'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'
" Plug 'tomasr/molokai'
" Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
" Plug 'hzchirs/vim-material'

call plug#end()

let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

set shell=/bin/zsh

autocmd VimEnter * wincmd l

" have long lines wrap by default
set nocompatible
set wrap
set linebreak

set hlsearch         " highlight search
set ignorecase       " be case insensitive when searching
set smartcase        " be case sensitive when input has a capital letter

set textwidth=100 " wasxtwidth to 70 to cause wrapping
set wrapmargin=0
set history=256       " Number of things to remember in history.
set timeoutlen=250    " Time to wait after ESC (default causes an annoying delay)
set nolist
set shiftround        " round indent to multiple of 'shiftwidth'
set breakindent
set autoindent
" set cursorline " highlight current line
" set showbreak=\
set showbreak=>\ \ \
set cpo=n
set cc=100 " highlight column 100
set hidden " allow switching buffer without saving"
let g:airline_highlighting_cache=1 " https://github.com/vim-airline/vim-airline/issues/1026

" Whitespace defaults
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show “invisible” characters
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

set mousehide       " Hide mouse after chars typed

set novisualbell    " No blinking
set noerrorbells    " No noise
set vb t_vb=        " disable any beeps or flashes on error

set termguicolors   " enable true color support


" set autowrite        " Writes on make/shell commands

set modeline
set modelines=5

set laststatus=2
" set shortmess=atI
set showcmd

set foldenable       " Turn on folding
set foldmethod=syntax
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldlevel=100    " Don't autofold anything (but I can still fold manually)


set number " show file numbers

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir -p ~/.config/nvim/undodir > /dev/null 2>&1
  set undodir=~/.config/nvim/undodir
  set undofile
endif

" Remember last location in file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" autocmd BufEnter * silent! lcd %:p:h

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

" Turn off the christmas lights
nnoremap <Leader><cr> :nohlsearch<cr>

" Remove whitespace with ,tw
nnoremap <Leader>tw :%s/\s\+$//e<CR>

" fix regexes default regex handling by
" auto-inserting \v before every REGEX.
nnoremap / /\\v
vnoremap / /\\v

let g:is_posix = 1
let mapleader = ","

set fo+=o  " Automatically insert the current comment
           " leader after hitting 'o' or 'O' in Normal mode.
set fo-=r  " Do not automatically insert a comment leader after an enter
set fo-=t  " Do no auto-wrap text using textwidth (does not
           " apply to comments)

"
""""""""""""""""""""""""""
" Coc.nvim
" https://github.com/neoclide/coc.nvim
""""""""""""""""""""""""""
" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" To make airline show the diagnostic information from coc, you can configure airline like:
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'


autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType javascript.jsx set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""

" nmap <leader>= :TagbarToggle<CR>
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

""""""""""""""""""""""""""
" vim-slime and tmux related settings
""""""""""""""""""""""""""

let g:tmux_navigator_save_on_switch = 1

""""""""""""""""""""""""""
" Ruby and Rails
""""""""""""""""""""""""""

" Neoterm and vim-test
let test#strategy = "neovim" "neoterm
map <leader>a :w<CR>:TestSuite<CR>
map <leader>f :w<CR>:TestFile<CR>
map <leader>r :w<CR>:TestNearest<CR>
map <leader>l :w<CR>:TestLast<CR>
map <leader>v :w<CR>:TestVisit<CR>

"On Neovim the "basic" and "neovim" strategies will run test commands using Neovim's terminal, and leave you in insert mode, so that you can just press "Enter" to close the terminal session and go back to editing. If you want to scroll through the test command output, you'll have to first switch to normal mode. The built-in mapping for exiting terminal insert mode is CTRL-\ CTRL-n, which is difficult to press, so I recommend mapping it to CTRL-o:


if has('nvim')
  tmap <C-o> <C-\><C-n>
end

let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'

" Useful maps
tnoremap <Esc> <C-\><C-n> " map esc to exit terminal mode
" print caller information for ruby
" https://tenderlovemaking.com/2016/02/05/i-am-a-puts-debuggerer.html
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" Rails commands
" command! Troutes :T rake routes
" command! -nargs=+ Troute :T rake routes | grep <args>
" command! Tmigrate :T rake db:migrate<Paste>

"
"
""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""

let g:airline#extensions#ale#enabled = 1


let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop']
\}

let g:jsx_ext_required = 0

" Fugitive
" map <Leader>c :Gcommit<CR>
" map <Leader>s :Gstatus<CR>
" map <Leader>p :Gpull<CR>
" map <Leader>o :Gpush<CR>

nnoremap <leader>b c-]<CR>

""""""""""""""""""""""""""
" ghc-mod (not a vim plugin)
""""""""""""""""""""""""""

" Reload
map <silent> tu :call GHC_BrowseAll()<CR>
" Type Lookup
map <silent> tw :call GHC_ShowType(1)<CR>

" show type of function under curser when f1
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
" show further information type classes, data constructors or
" functions, including the source location of definition
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""

let NERDTreeWinSize=35
map <C-t> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeMapJumpNextSibling = '' " conflicts with vim-tmux-navigator C-j
let g:NERDTreeWinPos = "right"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

""""""""""""""""""""""""""
" Mustache/handlebars
""""""""""""""""""""""""""

let g:mustache_abbreviations = 1

""""""""""""""""""""""""""
" Gundo
""""""""""""""""""""""""""

nnoremap <leader>u :GundoToggle<CR>

""""""""""""""""""""""""""
" ag
""""""""""""""""""""""""""
" let g:ackprg = 'ag --nogroup --nocolor --column'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


""""""""""""""""""""""""""
" startify
""""""""""""""""""""""""""
" let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, '~/.config/nvim/nvimrc.plugins', '~/.zshrc' ]
" if has('nvim')
"   au! TabNewEntered * Startify
" endif


""""""""""""""""""""""""""
" fzf.vim / old ctrlp
""""""""""""""""""""""""""

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap t <C-]>
nnoremap T <C-t>
" map <Leader>. :Tags<CR>
map <Leader>m :Ag<CR>
map <C-p> :Files<CR>
map <C-b> :Buffers<CR>

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" colorscheme base16-tomorrow-night
" colorscheme base16-eighties
colorscheme gruvbox
" colorscheme vim-material
" set t_Co=256
" let g:solarized_termcolors=256
set background=dark
" colorscheme solarized8_dark_flat

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"
""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""

let g:airline_theme = 'gruvbox'
" let g:tmuxline_preset = 'minimal'
" let g:airline#extensions#tmuxline#enabled = 0
"
"" airline settings
" remove separators
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" remove unused modes
" set second section to filename
" let g:airline_section_b="%f"
" empty third and fourth sections
" let g:airline_section_c=""
" let g:airline_section_x=""
" put filetype in fifth section
" let g:airline_section_y="%Y"
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" let g:limelight_conceal_ctermfg = (&bg == 'dark') ? 'red' : 'gray'

let g:goyo_width = 100

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set linespace=7
  set scrolloff=999
  set listchars=
  " Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set linespace=0
  set list
  set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
  " Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

""""""""""""""""""""""""""
" vim-unimpared
""""""""""""""""""""""""""

nmap > [
nmap < ]
omap > [
omap < ]
xmap > [
xmap < ]


""""""""""""""""""""""""""
" https://github.com/SirVer/ultisnips
""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""""""""""""""""""""""""""
" signify
""""""""""""""""""""""""""

let g:signify_vcs_list = ['git']


""""""""""""""""""""""""""
" Unorganized  stuff
""""""""""""""""""""""""""

" Hide ~ chars at end of file
" https://github.com/neovim/neovim/issues/2067
" hi EndOfBuffer ctermfg=bg

" Leader-<movement> for moving around in windows
" nmap <C-h> <C-w><C-h>
" nmap <C-j> <C-w><C-j>
" nmap <C-k> <C-w><C-k>
" nmap <C-l> <C-w><C-l>
" nmap <leader>h <C-w><C-h>
" nmap <leader>j <C-w><C-j>
" nmap <leader>k <C-w><C-k>
" nmap <leader>l <C-w><C-l>
"
" More natural split opening
set splitbelow
set splitright

" Moving between tabs
nmap <leader>n :tabnext<CR>
nmap <leader>N :tabprev<CR>

" Moving between buffers
" nmap <leader>n :bnext<CR>
" nmap <leader>N :bprevious<CR>

" get rid of annoying backup behaviour
set nobackup
set nowritebackup
set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile

" ,a to Ack
" nnoremap <leader>a :Ack
" Rotating among results in an ack search
" map <C-n> :cn<CR>
" map <C-p> :cp<CR>

" ease of use keyboard mappings (why do I care about top/bottom of screen?)
map H ^
map L $

" remap space bar to search, case insensitive
nmap <Space> /

" UNINDENT with Shift-Tab
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

nmap <leader>w :w!<CR>
nmap <leader>wq :wq!<CR>

imap <C-BS> <C-W>

" Close buffer without closing window
" https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
" map <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Spell checking
" set spell
autocmd BufNewFile,BufRead *.tex set spell
set spelllang=en_us ",da

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


" https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
" augroup ft_rb
"     au!
"     au FileType ruby setlocal re=1 foldmethod=manual
" augroup END

" autoclose plugin
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}', '|':'|' }
let g:AutoCloseProtectedRegions = ["Character"]

" don't need /g after :s or :g
set gdefault


" For vim-latex grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex' instead of 'tex', which results in vim-latex not being loaded. The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_IgnoreLevel = 7
let g:Tex_SmartKeyDot=0 " do not convert ... to \ldots
let g:Tex_CompileRule_pdf = "xelatex -synctex=1 -shell-escape -interaction=nonstopmode $*"
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_MultipleCompileFormats = "pdf, aux"
let g:Tex_Env_frame = "\\begin{frame}{<++>}\<CR><++>\<CR>\\end{frame}"
let g:Tex_Env_figure = "\\begin{figure}\<CR>\\centering\<CR>\\includegraphics[width=\\linewidth]{<+file+>}\<CR>\\caption{<+caption text+>}\\label{fig:<+label+>}\<CR>\\end{figure}<++>"

" Switches between xelatex and pdflatex compilers
function! SwitchLaTeXCompilers()
  let oldCompileRule=g:Tex_CompileRule_pdf
  let g:Tex_CompileRule_pdf = "pdflatex -synctex=1 -shell-escape -interaction=nonstopmode $*"
  call Tex_RunLaTeX()
  let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
map <Leader>lx :<C-U>call SwitchLaTeXCompilers()<CR>


" Rebind vim-latex C-j to jump to <++>
imap <C-g> <Plug>IMAP_JumpForward
nmap <C-g> <Plug>IMAP_JumpForward

nmap <leader>d :Dash!<CR>

nnoremap <silent> <C-Left> :tabp<CR>
nnoremap <silent> <C-Right> :tabn<CR>
" nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Bash-like autocomplete
set wildmode=longest,list,full
set wildmenu

" Set filetype for unknown types
au BufRead,BufNewFile .secrets.yml.enc set filetype=eruby.yaml
au BufRead,BufNewFile *.tikz set filetype=tex
au BufRead,BufNewFile .exports set filetype=sh
au BufRead,BufNewFile .aliases set filetype=sh
au BufRead,BufNewFile .bowerrc set filetype=json
au BufRead,BufNewFile .eslintrc set filetype=json
au BufRead,BufNewFile brakeman.ignore set filetype=json
au BufRead,BufNewFile .reek set filetype=yaml
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,Thorfile,config.ru,Capfile} set ft=ruby

augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
  "       \:call <SID>StripTrailingWhitespaces()
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
  autocmd Filetype python setlocal ai
  autocmd Filetype python setlocal shiftwidth=4
  autocmd Filetype python setlocal tabstop=4
  autocmd Filetype python setlocal sta
  autocmd Filetype python setlocal expandtab
  autocmd Filetype python setlocal fo=croql
augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

set ffs=unix,dos,mac " Default file types
set mouse+=a

if has('gui_running')
  set guioptions=egmrt

  "Remove menubar and toolbar
  set guioptions -=m
  set guioptions -=T
endif

" OS specific settings below
if has('win32')
  map <C-t> :tabnew<CR>
  map <M-left> :tabprev<CR>
  map <M-right> :tabnext<CR>

  if has('gui_running')
    set guifont=Consolas:h11
    set gfn=Consolas:h9:cANSI
    set backspace=2
  endif
endif

if has('mac')
  let g:Tex_ViewRule_pdf = "open -a Skim"

  if has('gui_running')
    set transparency=1
    set guifont=Inconsolata\ Nerd\ Font:h13
    set guioptions-=r
  endif

  " Make yanking work
  " http://vim.wikia.com/wiki/Mac%5FOS%5FX%5Fclipboard%5Fsharing
  set clipboard=unnamed
endif
