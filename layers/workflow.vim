" Core-layer for  workflow management {{{
" External plugins load {{{
" call dein#add('vimwiki/vimwiki')
" call dein#add('blindFS/vim-taskwarrior')
" call dein#add('powerman/vim-plugin-AnsiEsc')
" call dein#add('rouxb/taskwiki')
"WARN: external dependencies: {{{
" Taskwarrior: sudo dnf install task
" Tasklib: sudo pip install --upgrade git+git://github.com/tbabej/tasklib@develop
" Timewarrior: sudo dnf install timew [opt]
"}}}
call dein#add('plasticboy/vim-markdown')
"}}}

" Custom parameters {{{
" Vimwiki
let g:vimwiki_list = [{'path': g:wiki_dir
                \, 'path_html': g:wiki_dir. '/export/html/'
                \,'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'list'
" }}}

" Custom functions {{{
" }}}

" Custom remap {{{
  let g:lmap.w = { 'name' : '+VimWiki'}
  let g:lmap.w[' '] = { 'name' : '+VimWikiMake'}
  let g:lmap.w.T = ['VimwikiTabIndex', 'VimwikiTabIndex' ]
  let g:lmap.p = { 'name' : '+TaskWiki'}
" }}}

augroup workflowAutocmd "{{{
  autocmd!
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

