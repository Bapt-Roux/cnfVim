" layer for  Sessions mgmt based on starty{{{
" External plugins load {{{
call dein#add('mhinz/vim-startify') "{{{
  let g:startify_session_dir = g:cache_dir . g:nvim_path_separator . 'sessions'
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1

  let g:startify_session_before_save = [] "Ex call NERDTreeTabsClose before save

  let g:startify_session_savevars = [
           \ 'g:startify_session_savevars',
           \ 'g:startify_session_savecmds',
           \ 't:tabDescriptor'
           \ ]
  let g:startify_session_sort = 1
  let g:startify_relative_path = 1
  let g:startify_bookmarks = [ {'n': '~/.cnfVim/init.vim'} ]
  let g:startify_padding_left = 2
  let g:startify_update_oldfiles = 1
  let g:startify_fortune_use_unicode = 1

  let g:startify_custom_indices = ['a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n',
                  \'s', ';', '.', 'p', 'y', 'f', 'g', 'c', 'r', 'l', 'q',
                  \'x', 'b', 'm', 'w', 'v', 'z']
"}}}
"}}}

" global layers variables {{{
" }}}

" Custom functions {{{
function! sessionsMgmt#LoadSession() "{{{
  let sessionToLoad = init#AskUser("Load Session: ")
  execute 'SLoad ' . sessionToLoad
endfunction"}}}
"}}}

" Custom remap {{{
  let g:lmap.s = { 'name' : '+Sessions'}
  let g:lmap.s.s = ['SSave',  'save-sessions']
  let g:lmap.s.l = ['sessionsMgmt#LoadSession()', 'load-sessions']
  let g:lmap.s.c = ['SClose', 'close-sessions']
  let g:lmap.s.d = ['SDelete', 'delete-sessions']
" }}}

augroup sessionsMgmtAutocmd "{{{
  autocmd!
  autocmd TabNewEntered * Startify
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
