" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  " call minpac#add('...')
endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source ~/.config/nvim/init.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source ~/.config/nvim/init.vim | call minpac#clean()
command! PackStatus packadd minpac | source ~/.config/nvim/init.vim | call minpac#status()
command! PackUpdateAndQuit packadd minpac | source ~/.config/nvim/init.vim | call minpac#clean() | call minpac#update('', {'do': 'quit'})
