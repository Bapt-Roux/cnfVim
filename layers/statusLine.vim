" Core-layer for  statusline and tabbar {{{
" External plugins load {{{
call dein#add('itchyny/lightline.vim')
"}}}

" Custom functions {{{
function! statusLine#tabName(nr)
  if has_key(g:usrTabName, a:nr)
    return g:usrTabName[a:nr]
  else
    return ""
  endif
endfunction
" }}}

" Statusline {{{
let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'relativepath', 'altfilename', 'modified' ]
  \     ]
  \   },
  \   'component': {
  \     'lineinfo': ' %3l:%-2v',
  \     'altfilename': '%{expand(@#)}',
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'pathname': 'statusLine#pathName',
  \   }
  \ }

let g:lightline.separator = {
  \   'left': '', 'right': ''
  \}

let g:lightline.subseparator = {
  \   'left': '', 'right': '' 
  \}
" }}}

" Tabline {{{
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

let g:lightline.tab = {
  \ 'active': [ 'tabnum', 'tabname', 'filename', 'modified' ],
  \ 'inactive': [ 'tabnum', 'tabname', 'modified' ] 
  \ }

let g:lightline.tab_component_function = {
  \ 'filename': 'lightline#tab#filename',
  \ 'modified': 'lightline#tab#modified',
  \ 'readonly': 'lightline#tab#readonly',
  \ 'tabnum': 'lightline#tab#tabnum',
  \ 'tabname': 'statusLine#tabName',
  \ }

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
" }}}

augroup StatusLineAutocmd "{{{
  autocmd!
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

