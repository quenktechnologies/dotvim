let g:path_to_configs = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:path_to_dot_vim = g:path_to_configs . '/.vim'
let g:path_to_vimrcd = g:path_to_dot_vim . '/vimrc.d'

execute 'source' g:path_to_vimrcd . '/reset'
execute 'source' g:path_to_vimrcd . '/preferences'

function! s:SourceRecursive(path)
  if isdirectory(a:path)
    s:SourceRecursive(a:path)
  else
    for f in split(glob(a:path), '\n')
      execute 'source' f
    endfor
  endif
endfunction

function! s:sourceLocal()
  if filereadable('.vimlocal')
    echo "Source .vimlocal file? (y/[n])"
    if(getchar() == 'y')
      source .vimlocal
      endif
  endif
endfunction

call s:SourceRecursive(g:path_to_vimrcd . '/*.vim')

call s:sourceLocal()
