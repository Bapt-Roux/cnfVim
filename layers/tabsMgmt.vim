" layer for  Tabsmgmt{{{
" External plugins load {{{
"}}}

" global layers variables {{{
let g:usrTabName = {}
let g:prvTab = 1
let g:curTab = 1
" }}}

" Custom functions {{{
function! tabsMgmt#AskUser(dspTxt) "{{{
  call inputsave()
  let a:userInput = input(a:dspTxt)
  call inputrestore()
  return a:userInput
endfunction "}}}

function! tabsMgmt#RegisterTab(tabName) "{{{
  let a:tabDescr = {}
  "" tabs uid
  "let a:tabDescriptor['uid'] = TODO
  " tabs name
  if a:tabName ==# ''
    let a:tabDescr['name'] = tabsMgmt#AskUser('Enter tab name: ')
  else
    let a:tabDescr['name'] = a:tabName
  endif
  " tabs zoom status
  let a:tabDescr['zoom'] = 0
  return a:tabDescr
endfunction " }}}

function! tabsMgmt#FirstTab_hook() "{{{
  let t:tabDescriptor = tabsMgmt#RegisterTab('Sandbox')
  "update usrTabName
  let g:usrTabName[tabpagenr()] = t:tabDescriptor['name']
endfunction " }}}

function! tabsMgmt#RenameTab() "{{{
  let t:tabDescriptor['name'] = tabsMgmt#AskUser('Rename tab: ')
  "update usrTabName
  let g:usrTabName[tabpagenr()] = t:tabDescriptor['name']
endfunction "}}}

function! tabsMgmt#ToggleTab() "{{{
  execute 'tabnext ' . g:prvTab
endfunction "}}}


function! tabsMgmt#TabNew_hook() "{{{
  let t:tabDescriptor = tabsMgmt#RegisterTab('')
endfunction " }}}

function! tabsMgmt#TabEnter_hook() "{{{
  "update usrTabName
  let g:usrTabName[tabpagenr()] = t:tabDescriptor['name']
  "update history
  let g:prvTab = g:curTab
  let g:curTab = tabpagenr()
endfunction " }}}

function! tabsMgmt#TabClosed_hook() "{{{
endfunction " }}}
" }}}

" Custom remap {{{
  let g:lmap.l = { 'name' : '+layouts'}
  let g:lmap.l.r = ['call tabsMgmt#RenameTab()', 'rename-tab']
  let g:lmap.l.n = ['tabnew', 'new-tab']
  let g:lmap.l['<C-I>'] = ['call tabsMgmt#ToggleTab()', 'toggle-tab']
" }}}

augroup tabsMgmtAutocmd "{{{
  autocmd!
  autocmd VimEnter *  call tabsMgmt#FirstTab_hook()
  autocmd TabNew *  call tabsMgmt#TabNew_hook()
  autocmd TabEnter * call tabsMgmt#TabEnter_hook()
  autocmd TabClosed * call tabsMgmt#TabClosed_hook()
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

