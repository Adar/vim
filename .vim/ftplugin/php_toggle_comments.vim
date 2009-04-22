if exists("b:did_phptogglecomments_ftplugin")
  finish
endif
let b:did_phptogglecomments_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("*s:HideComments")
  function s:HideComments()
    :colo icansee_no_comments
  endfunction
endif

if !exists("*s:ShowComments")
  function s:ShowComments()
    :colo icansee
  endfunction
endif

if !exists("no_plugin_maps") && !exists("no_php_maps")
  if !hasmapto('<Plug>phptogglecommentsHideComments')
    map <unique> <buffer> <LocalLeader>c <Plug>phptogglecommentsHideComments
  endif
  noremap <buffer> <script> 
    \ <Plug>phptogglecommentsHideComments
    \ <SID>HideComments
  noremap <buffer> 
    \ <SID>HideComments
    \ :call <SID>HideComments()<CR>
  if !hasmapto('<Plug>phptogglecommentsShowComments')
    map <unique> <buffer> <LocalLeader>v <Plug>phptogglecommentsShowComments
  endif
  noremap <buffer> <script> 
    \ <Plug>phptogglecommentsShowComments
    \ <SID>ShowComments
  noremap <buffer> 
    \ <SID>ShowComments
    \ :call <SID>ShowComments()<CR>
endif

if !exists(":HideComments")
  command -range -buffer 
    \ HideComments
    \ :call s:HideComments()
endif
if !exists(":ShowComments")
  command -range -buffer 
    \ ShowComments
    \ :call s:ShowComments()
endif

let &cpo = s:save_cpo
