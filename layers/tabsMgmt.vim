" layer for  Tabsmgmt{{{
" External plugins load {{{
"}}}

" global layers variables {{{
" }}}
" Custom functions {{{
function! tabsMgmt#AskUser(dspTxt) "{{{
  call inputsave()
  let a:userInput = input(a:dspTxt)
  call inputrestore()
  return a:userInput
endfunction "}}}

function! tabsMgmt#RegisterTab() "{{{
  let a:tabDescr = {}
  "" tabs uid
  "let a:tabDescriptor['uid'] = TODO
  " tabs name
  let a:tabDescr['name'] = tabsMgmt#AskUser('Enter tab name: ')
  " tabs position
  let a:tabDescr['pos'] = tabpagenr()
  " tabs zoom status
  let a:tabDescr['zoom'] = 0
  return a:tabDescr
endfunction " }}}

function! tabsMgmt#FirstTab_hook() "{{{
  let t:tabDescriptor = {}
  "" tabs uid
  "let t:tabDescriptor['uid'] = TODO
  " tabs name
  let t:tabDescriptor['name'] = "Sandbox"
  " tabs position
  let t:tabDescriptor['pos'] = tabpagenr()
  " tabs zoom status
  let t:tabDescriptor['zoom'] = 0


endfunction " }}}

function! tabsMgmt#TabNew_hook() "{{{
  "update pos
  let t:tabDescriptor = tabsMgmt#RegisterTab()
endfunction " }}}

function! tabsMgmt#TabEnter_hook() "{{{
  "update pos
  let t:tabDescriptor['pos'] = tabpagenr()
endfunction " }}}
" }}}

" Custom remap {{{
" }}}

augroup tabsMgmtAutocmd "{{{
  autocmd!
  autocmd VimEnter *  call tabsMgmt#FirstTab_hook()
  autocmd TabNew *  call tabsMgmt#TabNew_hook()
  autocmd TabEnter * call tabsMgmt#TabEnter_hook()
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

