" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif


function! PackInit() abort
  packadd minpac

  call minpac#init({'progress_open': 'none'})
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  source ~/.config/nvim/packages.vim
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate call PackInit() | source ~/.config/nvim/init.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | source ~/.config/nvim/init.vim | call minpac#clean()
command! PackStatus call PackInit() | source ~/.config/nvim/init.vim | call minpac#status()
command! PackUpdateAndQuit call PackInit() | source ~/.config/nvim/init.vim | call minpac#clean() | call minpac#update('', {'do': 'quit'})
