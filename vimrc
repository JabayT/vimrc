set nocompatible

"================================================= plugins ================================================
" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('wsdjeg/dein-ui.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('tpope/vim-surround')
  call dein#add('rhysd/conflict-marker.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('vim-scripts/sessionman.vim')

  call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'}) " lazy load on command executed
  call dein#add('vim-scripts/FSwitch', {'on_ft': ['c', 'cpp']}) " lazy load on file type 

  call dein#add('vim-scripts/L9')
  call dein#add('vim-scripts/FuzzyFinder')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('vim-airline/vim-airline')

  call dein#add('Valloric/YouCompleteMe')
  call dein#add('rdnetto/YCM-Generator')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')

  " python
  call dein#add('klen/python-mode', {'on_ft': ['py']})
  call dein#add('yssource/python.vim', {'on_ft': ['py']})
  call dein#add('vim-scripts/python_match.vim', {'on_ft': ['py']})
  call dein#add('vim-scripts/pythoncomplete', {'on_ft': ['py']})

  "rust
  call dein#add('rust-lang/rust.vim', {'on_ft': ['rs']})

  " and a lot more plugins.....

  " Required:
  call dein#end()
  call dein#save_state()
endif

" DISPLAY SETTINGS 
set background=dark
colorscheme solarized 
set scrolloff=2         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set undofile            " stores undo state even when files are closed (in undodir)
set cursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
"set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values "set cinoptions=:0g0t0(sus
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.
set undodir=~/.vimundo  " no backup~ files.

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set softtabstop=4
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
set laststatus=2        " the statusline is now always shown
set noshowmode          " don't show the mode ("-- INSERT --") at the bottom)"
set mouse=v
set nonu
set whichwrap=<,>,[,]
set nohls

" misc settings
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set mouse=a             " enables the mouse in all modes
set foldlevelstart=99   " all folds open by default"
if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif

set pastetoggle=<F7>

set tags=./tags;

let mapleader=","


"JABAY
if !exists("g:my_project_home")
    let g:my_project_home = getcwd()
endif
nnoremap <F3>  :exec ":grep -r --include=*.h* --include=*.cpp* '\\b<cword>\\b' ".g:my_project_home."/"
"inoremap <c-l> <right>
"substitute currrent word to unix style
"nnoremap <silent> <Leader>su :s/\([a-z]\)\([A-Z]\)/\1_\l\2/g<cr>
"substitute currrent word to camel case
"nnoremap <silent> <Leader>sc :s/\([a-z]\)_\([a-z]\)/\1\u\2/g<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              for plugins                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --------------------- fuzzyfinder ---------------------
" This turns on the mrufile and mrucmd modes
let g:fuf_modesDisable    = []
let g:fuf_mrufile_maxItem = 1000
let g:fuf_mrucmd_maxItem  = 400
let g:fuf_file_exclude    = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

nnoremap <Leader>fm :FufMruFile<CR>
nnoremap <Leader>fc :FufMruCmd<CR>

" --------------------- fswitch ---------------------
" A "companion" file is a .cpp file to an .h file and vice versa

" Opens the companion file in the current window
nnoremap <silent> <Leader>of :FSHere<cr>

" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Leader>sl :call FSwitch('%', 'wincmd l')<cr>

" Same as above, only opens it in window to the right
nnoremap <Leader>sr :call FSwitch('%', 'wincmd r')<cr>

" Creates a new window on the left and opens the companion file in it
nnoremap <Leader>sv :FSSplitLeft<cr>

" ------------------------------nerdtree-------------------------------------
nmap <leader>nt :NERDTreeToggle<CR>

" ----------------------------youcompleteme----------------------------------
"let g:ycm_server_keep_logfiles=1
"let g:ycm_server_log_level='debug'
let g:ycm_global_ycm_extra_conf = '~/.cache/dein/repos/github.com/Valloric/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tag_files = 1

nnoremap <leader>gi :YcmCompleter GoToInclude<cr>
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>f :YcmCompleter FixIt<cr>
nnoremap <leader>d :YcmDiags<cr>
nnoremap <F6> :YcmForceCompileAndDiagnostics<cr>    "force recomile with syntastic"
nnoremap <silent> <Leader>gy :YcmGenerateConfig<cr>
"YCM-Generator/config_gen.py  . -f
"/.vim/bundle/YCM-Generator/config_gen.py -f -C '-G "Unix Makefiles" -DCMAKE_BUILD_TYPE:STRING=Debug ' . 
