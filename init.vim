" Nvim configuration loader {{{
" Define global configuration and load subcomponent and layers

" NB: Force configuration update
" run `call dein#clear_state() || call dein#update()` to apply changes

" Utility functions {{{
function! init#NvimGetDir(suffix) "{{{
  return resolve(expand(g:nvim_dir . g:nvim_path_separator . a:suffix))
endfunction "}}}

function! init#NvimGetCacheDir(suffix) "{{{
  return resolve(expand(g:cache_dir . g:nvim_path_separator . a:suffix))
endfunction "}}}

function! init#NvimPreserve(command) "{{{
  " preparation: save last search and cursor position
  let l:_s = @/
  let l:l = line(".")
  let l:c = col(".")
  " do the business
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/ = l:_s
  call cursor(l:l, l:c)
endfunction "}}}

function! init#NvimStripTrailingWhitespace() "{{{
  call NvimPreserve("%s/\\s\\+$//e")
endfunction "}}}

function! init#EnsureExists(path) "{{{
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path))
  endif
endfunction "}}}

function! init#InsertIfNotExists(map, key, value) "{{{
  if !has_key(a:map, a:key)
    let a:map[a:key] = a:value
  endif
endfunction "}}}

function! init#SourceLayers(path, layer_list) "{{{
  for f in split(glob(a:path . g:nvim_path_separator . '*.nvim\|*.vim'), '\n')
    let l:layer_name = fnamemodify(f, ':t:r')
    if count(a:layer_list, l:layer_name)
      execute 'source ' . f
    endif
  endfor
endfunction "}}}

function! init#SourcePlugins() "{{{
  for p in g:cnf_nvim.enabled_plugins
    execute 'dein#add('. p . ')'
  endfor
endfunction "}}}


function! init#AddTags(path) "{{{ TBC usefull
  for f in split(glob(a:path . g:nvim_path_separator . '*.tags'), '\n')
    execute 'set tags+=' . f
  endfor
endfunction "}}}

function! init#LeaderDsp() " {{{
  let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '\c<CR>$', '', '')
  let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
  let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '^<SID>', '', '')
endfunction
" }}}
function! init#DfltConfig() "{{{ TBC clean useless vars
  " default settings {{{
  " core
  call init#InsertIfNotExists(g:cnf_nvim, 'default_indent', 2)
  call init#InsertIfNotExists(g:cnf_nvim, 'bin_dir', '')
  call init#InsertIfNotExists(g:cnf_nvim, 'cscopeprg', 'gtags-cscope')
  " plugins
  call init#InsertIfNotExists(g:cnf_nvim, 'completion_plugin', 'deoplete')
  call init#InsertIfNotExists(g:cnf_nvim, 'syntaxcheck_plugin', 'ale')
  call init#InsertIfNotExists(g:cnf_nvim, 'explorer_plugin', 'nerdtree')
  call init#InsertIfNotExists(g:cnf_nvim, 'statusline_plugin', 'airline')
  call init#InsertIfNotExists(g:cnf_nvim, 'fonts_plugin', 'none')

  " user interface
  call init#InsertIfNotExists(g:cnf_nvim, 'colorscheme', 'space-vim-dark')
  call init#InsertIfNotExists(g:cnf_nvim, 'force256', 0)
  call init#InsertIfNotExists(g:cnf_nvim, 'termtrans', 0)
  call init#InsertIfNotExists(g:cnf_nvim, 'enable_cursorcolumn', 0)
  call init#InsertIfNotExists(g:cnf_nvim, 'max_column', 80)
  call init#InsertIfNotExists(g:cnf_nvim, 'nerd_fonts', 0)
  call init#InsertIfNotExists(g:cnf_nvim, 'powerline_fonts', 0)

  " layers
  if !exists('g:cnf_nvim.layers')
    let g:cnf_nvim.layers = []
  endif

  " additional plugins
  if !exists('g:cnf_nvim.enabled_plugins')
    let g:cnf_nvim.enabled_plugins = []
  endif
  "}}}
endfunction "}}}

function! init#AskUser(dspTxt) "{{{
  call inputsave()
  let a:userInput = input(a:dspTxt)
  call inputrestore()
  return a:userInput
endfunction "}}}

"}}}

" Init path configuration {{{
let g:nvim_path_separator='/'
let g:nvim_dir= '~' . g:nvim_path_separator . '.cnfVim' 
let g:cache_dir = g:nvim_dir . g:nvim_path_separator . 'cache'
" }}}

" Submodule configuration {{{
let g:cnf_nvim = {}
" Leader keys {{{
" TBC name to store vars
let mapleader = ' '
let g:mapleader = ' '
let maplocaleader = ','
let g:maplocaleader = ','
let g:cnf_nvim.glbLeader = ' '
let g:cnf_nvim.localLeader = ','
let g:lmap = {} " dict for leaderKey mappings
let g:llmap = {}
" }}}

" Users knobs {{{
let g:cnf_nvim.default_indent = 2
let g:cnf_nvim.colorscheme = 'spaceVim' "'spaceVim' 'molokai' 'solarized'
let g:cnf_nvim.force256 = 0
let g:cnf_nvim.termtrans = 0
let g:cnf_nvim.max_column = 80
let g:cnf_nvim.enable_cursorcolumn = 1
let g:cnf_nvim.powerline_fonts = 0
let g:cnf_nvim.nerd_fonts = 0
" }}}

" Layers {{{
let g:cnf_nvim.layers = [ 
    \ 'uiTheme',
    \ 'tabsMgmt',
    \ 'windowsMgmt',
    \ 'buffersMgmt',
    \ 'sessionsMgmt',
    \'nerdcommenter_wrper']
"}}}
" Extra plugins {{{
let g:cnf_nvim.extra_plugins = []
" }}}
" }}}

" Function hooks to tweak startup process {{{
" User hook beforeAll load {{{
function! init#BeforeAll_hook()
endfunction "}}}

" User hook after all startup {{{
function! init#AfterAll_hook()
" Global configuration {{{
  " smash escape {{{
  inoremap jk <Esc>
  inoremap kj <Esc>
  " escap and smash escape in terminal emulator
  tnoremap jk <C-\><C-n>
  tnoremap kj <C-\><C-n>
  tnoremap <Esc> <C-\><C-n>
  " }}}
  "timeout
  set timeoutlen=300  " mapping timeout
  set ttimeoutlen=50  " keycode timeout
  " Mouse 
  set mouse=a  " enable mouse
  set mousehide  " hide when characters are typed
  set history=1000  " number of command lines to remember
  set ttyfast  " assume fast terminal connection
  set viewoptions=folds,options,cursor,unix,slash  " unix/windows compatibility
  set clipboard=unnamed  " sync with OS clipboard
  set hidden  " allow buffer switching without saving
  set autoread  " auto reload if file saved externally
  set nrformats-=octal  " always assume decimal numbers
  set showcmd

  set modeline
  set modelines=5

  set noshelltemp  " use pipes

  " Whitespace
  set backspace=indent,eol,start  " allow backspacing everything in insert mode

  " Tabulation char
  set smarttab  " use shiftwidth to enter tabs
  set autoindent  " automatically indent to match adjacent lines
  " the amount of indent for a continuation line for vim script
  let g:vim_indent_cont = &shiftwidth * 2

  " Indentation <http://vim.wikia.com/wiki/Indenting_source_code>
  set expandtab
  let &shiftwidth = g:cnf_nvim.default_indent 
  let &tabstop = g:cnf_nvim.default_indent 
  let &softtabstop = g:cnf_nvim.default_indent

  " Highlight whitespace
  set list
  set shiftround
  set linebreak

  " Scrolling
  set scrolloff=10  " minimum number of lines above and below cursor
  set scrolljump=1  "minimum number of lines to scroll
  set sidescrolloff=5  " minimum number of columns to left and right of cursor
  set display+=lastline

  " Autocomplete
  set wildmenu
  set wildmode=list:full
  set wildignore+=*~,*.o,core.*,*.exe,.git/,.hg/,.svn/,.DS_Store,*.pyc
  set wildignore+=*.swp,*.swo,*.class,*.tags,tags,tags-*,cscope.*,*.taghl
  set wildignore+=.ropeproject/,__pycache__/,venv/,*.min.*,images/,img/,fonts/
  set wildignorecase

  " set splitbelow
  " set splitright

  " disable sounds
  set noerrorbells
  set novisualbell
  set t_vb=

  " searching
  set hlsearch  " highlight searches
  set incsearch  " incremental searching
  set ignorecase  " ignore case for searching
  set smartcase  " do case-sensitive if there's a capital letter

  " Directory management {{{
  " persistent undo
  if exists('+undofile')
    set undofile
    let &undodir = init#NvimGetCacheDir('undo')
  endif

  " backups
  set backup
  let &backupdir = init#NvimGetCacheDir('backup')

  " swap files
  let &directory = init#NvimGetCacheDir('swap')
  set noswapfile

  call init#EnsureExists(g:cache_dir)
  call init#EnsureExists(&undodir)
  call init#EnsureExists(&backupdir)
  call init#EnsureExists(&directory)
  "}}}

  " Ui configuration {{{
  set showmatch  " highlight matching braces/brackets/etc.
  set matchtime=2  " tens of a second to show matching parentheses
  set number
  set relativenumber
  set lazyredraw
  set laststatus=2
  set noshowmode
  set foldenable  " enable folds by default
  set foldmethod=marker  " fold marker
  set foldlevelstart=99  " open all folds by default

  set cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter * setlocal cursorline
  let &colorcolumn = g:cnf_nvim.max_column
  if g:cnf_nvim.enable_cursorcolumn
    set cursorcolumn
    autocmd WinLeave * setlocal nocursorcolumn
    autocmd WinEnter * setlocal cursorcolumn
  endif

  if has('gui_running') "TBC keep this
    " open maximized
    set lines=999 columns=9999
    set guioptions+=t  " tear off menu items
    set guioptions-=T  " toolbar icons
    if has('gui_gtk')
      set gfn=Ubuntu\ Mono\ 11
    endif
  endif
	"Coloration
  filetype plugin indent on
  syntax on
  "}}}
"}}}
endfunction " }}}
"}}}

""" DO NOT EDIT {{{
" PreCore Hook  and core components loading{{{
call init#BeforeAll_hook()
call init#DfltConfig()
"}}}

" Core configuration load {{{
  " dein setup {{{
  set nocompatible
  set all&  " reset everything to their defaults
  let s:layer_path = init#NvimGetDir('layers')
  let s:dein_path = s:layer_path . g:nvim_path_separator
      \ . 'dein.vim'
  execute 'set runtimepath+=' . s:dein_path
  call dein#begin(init#NvimGetDir('bundle'))
  call dein#add(init#NvimGetDir('layers') . g:nvim_path_separator . 'dein.vim')
  "}}}
  " vim-leader setup {{{
  call dein#add('taohex/vim-leader-guide')
  let g:leaderDict = {}
  let g:leaderDict[' '] = g:lmap
  let g:leaderDict[' ']['name'] = '<Leader>'
  let g:leaderDict[','] = g:llmap
  let g:leaderDict[',']['name'] = '<LocalLeader>'
  call leaderGuide#register_prefix_descriptions("", "g:leaderDict")
  let g:leaderGuide_displayfunc = [function("init#LeaderDsp")]
  " Position Bottom
  let g:leaderGuide_vertical = 0
  let g:leaderGuide_position = 'botright'
  " Master leaderGuide shortcuts
  nnoremap <silent><nowait> <Leader> :<C-u>LeaderGuide '<Space>'<CR>
  vnoremap <silent><nowait> <Leader> :<C-u>LeaderGuideVisual '<Space>'<CR>
  map <Leader>. <Plug>leaderguide-global
  " Local leaderGuide shortcuts
  nnoremap <silent><nowait> <LocalLeader> :<C-u>LeaderGuide  ','<CR>
  vnoremap <silent><nowait> <LocalLeader> :<C-u>LeaderGuideVisual  ','<CR>
  map <LocalLeader>. <Plug>leaderguide-buffer
  "}}}
" }}}

" Layers loading and extra-plugins loading {{{
call init#SourceLayers(g:nvim_dir . g:nvim_path_separator . 'layers', g:cnf_nvim.layers)
" Load extra plugins
if exists('g:cnf_nvim.extra_plugins')
  for plugin in g:cnf_nvim.extra_plugins
    call dein#add(plugin)
  endfor
endif
"}}}

" endConfig Hook {{{
call init#AfterAll_hook()
call dein#end()
if dein#check_install()
  call dein#install()
endif
autocmd VimEnter * call dein#call_hook('post_source')
"}}}
"}}}

"}}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

