" Core-layer for  statusline and tabbar {{{
" External plugins load {{{
call dein#add('itchyny/lightline.vim')
"}}}

" Custom functions {{{
" }}}

" Custom layout {{{
let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': {
  \     'lineinfo': ' %3l:%-2v',
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }

let g:lightline.separator = {
  \   'left': '', 'right': ''
  \}

let g:lightline.subseparator = {
  \   'left': '', 'right': '' 
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
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

