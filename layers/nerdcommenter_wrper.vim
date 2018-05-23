" Core-layer for various utility plugins {{{

" External plugins load {{{
call dein#add('scrooloose/nerdcommenter') "{{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1 " Use alternate display
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}
"}}}

" Custom functions {{{
" }}}

" Custom remap {{{
" }}}

augroup nerdcommenterAutocmd "{{{
  autocmd!
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0



