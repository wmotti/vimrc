command! PackUpdate packadd minpac | source ~/.vim/vimrc | call minpac#update()
command! PackClean  packadd minpac | source ~/.vim/vimrc | call minpac#clean()
command! PackUpdateAndQuit packadd minpac | source ~/.vim/vimrc | call minpac#update() | call minpac#clean() | qall

packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('rking/ag.vim')
call minpac#add('jeetsukumaran/vim-buffergator')
call minpac#add('tpope/vim-bundler')
call minpac#add('kien/ctrlp.vim')
call minpac#add('tpope/vim-cucumber')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-git')
call minpac#add('goatslacker/mango.vim')
call minpac#add('tomasr/molokai')
call minpac#add('vim-scripts/neat.vim')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-dispatch')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('ervandew/supertab')
call minpac#add('kana/vim-textobj-user')
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('kchmck/vim-coffee-script')
call minpac#add('pangloss/vim-javascript')
call minpac#add('tpope/vim-rbenv')
call minpac#add('ngmy/vim-rubocop')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-vividchalk')
call minpac#add('skalnik/vim-vroom')
call minpac#add('benmills/vimux')
call minpac#add('jgdavey/vim-turbux')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('vim-scripts/gitignore')
call minpac#add('tpope/vim-rsi')
call minpac#add('tpope/vim-sleuth')
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('smerrill/vcl-vim-plugin')
call minpac#add('slim-template/vim-slim')
call minpac#add('jodosha/vim-devnotes')
call minpac#add('DataWraith/auto_mkdir')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('vim-utils/vim-ruby-fold')
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('godlygeek/tabular')
call minpac#add('terryma/vim-multiple-cursors')
call minpac#add('jceb/vim-orgmode')
call minpac#add('vim-scripts/utl.vim')
call minpac#add('tpope/vim-repeat')
call minpac#add('vim-scripts/taglist.vim')
call minpac#add('majutsushi/tagbar')
call minpac#add('tpope/vim-speeddating')
call minpac#add('chrisbra/NrrwRgn')
call minpac#add('mattn/calendar-vim')
call minpac#add('inkarkat/vim-SyntaxRange')

set nocompatible     " Vim behavior, not Vi.
set scrolloff=3
set ai
set showcmd
set encoding=utf-8   " Use UTF-8 encoding
set nobackup         " Don't backup
set nowritebackup    " Write file in place
set noswapfile       " Don't use swap files (.swp)
set autoread         " Autoreload buffers
set autowrite        " Automatically save changes before switching buffers
syntax on            " Enable syntax highlight
filetype plugin indent on
set laststatus=2                                                             " Always display the status line
set ruler                                                                    " Show the cursor position all the time
set cursorline                                                               " Highlight current cursor line
set statusline=%<%f\ %h%m%r%=\ %{devnotes#statusline()}\ %-14.(%l,%c%V%)\ %P " Status line format
set list                          " Show invisible chars
set listchars=""                  " Reset listchars
set list listchars=tab:»·,trail:· " Set listchars for tabs and trailing spaces

let mapleader="\<Space>"

" Tabs and spaces stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Wrap or not?
set nowrap
" setlinebreak


" Search
set hlsearch    " Highlight matches
set incsearch   " Incremental searching
set showmatch
set ignorecase  " Searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Bells
set visualbell t_vb=
set novisualbell

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*/cache/*,*.so,*.swp,*.zip,*.tgz,*.o,*.obj

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" buffergator configuration
let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = 1
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
nmap <leader>kk :BuffergatorMruCycleNext<cr>
nmap <leader>bl :BuffergatorOpen<cr>
"nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" CtrlP configuration
"nmap <leader>p :CtrlP<cr>
"nmap <leader>bb :CtrlPBuffer<cr>
"nmap <leader>bm :CtrlPMixed<cr>
"nmap <leader>bs :CtrlPMRU<cr>
let g:ctrlp_use_caching = 0
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --path-to-agignore\ $HOME/.agignore

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind , (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap , :Ag<SPACE>
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
let g:ctrlp_match_window = 'max:20,order:btt'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|\_site)$',
    \ 'file': '\v^\.|\.(swp|swo|png|jpg|jpeg)$',
    \ }
let g:ctrlp_show_hidden = 0
let g:ctrlp_lazy_update = 125
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_working_path_mode = 'r'

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"function s:setupWrapping()
"  set wrap
"  set wm=2
"  set textwidth=72
"endfunction
"
"function s:setupMarkup()
"  call s:setupWrapping()
"  map <buffer> <Leader>p :Mm <CR>
"endfunction

" make and python use real tabs
au FileType make set noexpandtab
au FileType python setlocal noexpandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
au FileType rake setlocal ts=2 sts=2 sw=2 expandtab
au FileType cucumber setlocal ts=2 sts=2 sw=2 expandtab
au FileType smarty setlocal ts=4 sts=4 sw=4 expandtab
au FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
au FileType sass setlocal ts=2 sts=2 sw=2 expandtab

" *.tpl files are smarty templates
au BufRead,BufNewFile *.tpl set ft=smarty

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" features files are cucumber files
au BufRead,BufNewFile *.features set ft=cucumber

" coffee files!
" au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
" compile on write
"au BufWritePost *.coffee silent CoffeeMake -b | cwindow | redraw!
" lint on write
"au BufWritePost *.coffee silent CoffeeLint! | cwindow

autocmd BufNewFile,BufRead *.haml setl foldmethod=indent nofoldenable
autocmd! FileType nofile setl foldmethod=indent nofoldenable

"au BufRead,BufNewFile *.txt call s:setupWrapping()

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
"map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
"map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

set relativenumber

" Automatically save before commands like :next and :make
set autowrite

" Default color scheme
set background=dark
set t_Co=256

"let g:solarized_termtrans=1
colorscheme molokai

" wrap test function
command! -nargs=* Wrap set wrap linebreak nolist showbreak=…

" utility function to preserve cursor position
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" show and trim spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

"function! <SID>TrimSpaces()
"   " Preparation: save last search, and cursor position.
"   let _s=@/
"   let l = line(".")
"   let c = col(".")
"   " Do the business:
"   %s/\s\+$//ec
"   " Clean up: restore previous search history, and cursor position
"   let @/=_s
"   call cursor(l, c)
"endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
"nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <F12>     :SyntasticCheck<CR>
"nnoremap <silent> <F5> :call <SID>TrimSpaces()<CR>
nmap <F6> :call Preserve("%s/\\s\\+$//ec")<CR>
nmap <F7> :call Preserve("normal gg=G")<CR>

nnoremap <F3> "=strftime("%Y%m%d%H%M%p")<CR>P
inoremap <F3> <C-R>=strftime("%Y%m%d%H%M%p")<CR>

" tabs shortcuts
" map <C-S-]> gt
" map <C-S-[> gT
" map <C-1> 1gt
" map <C-2> 2gt
" map <C-3> 3gt
" map <C-4> 4gt
" map <C-5> 5gt
" map <C-6> 6gt
" map <C-7> 7gt
" map <C-8> 8gt
" map <C-9> 9gt
" map <C-0> :tablast<CR>

" copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"set <F20>=[25~
"set <F13>=[25~1
"set <F14>=[25~2
"
"map <F13> 1gt
"map <F14> 2gt
"
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

map ç gT
map ° gt
map Q :q

set foldmethod=syntax
set foldlevelstart=1
"nnoremap <SPACE> za
"nnoremap <C-Space> zi
let g:php_folding=2
let g:PHP_vintage_case_default_indent = 1

nnoremap <silent> <F8> :TlistToggle<CR>

if has("autocmd") && exists("+omnifunc")
      autocmd Filetype *
          \   if &omnifunc == "" |
          \     setlocal omnifunc=syntaxcomplete#Complete |
          \   endif
endif

set winwidth=79
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down>  <Nop>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

" unicode symbols
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
""let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
""let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊ '
"let g:airline_symbols.linenr = '␤ '
"let g:airline_symbols.linenr = '¶ '
"let g:airline#extensions#branch#symbol = '⎇ '
""let g:airline_symbols_paste = 'ρ'
""let g:airline_symbols_paste = 'Þ'
"let g:airline_symbols_paste = '∥'
let g:airline_theme = 'molokai'
let g:airline#extensions#branch#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>pl :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PS TO JUMP TO SPECIFIC CTRLP TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! zeus rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CtrlPClearCache<cr>\|:CtrlP app/views<cr>
map <leader>gc :CtrlPClearCache<cr>\|:CtrlP app/controllers<cr>
map <leader>gm :CtrlPClearCache<cr>\|:CtrlP app/models<cr>
map <leader>gh :CtrlPClearCache<cr>\|:CtrlP app/helpers<cr>
map <leader>gl :CtrlPClearCache<cr>\|:CtrlP lib<cr>
map <leader>gp :CtrlPClearCache<cr>\|:CtrlP public<cr>
map <leader>gs :CtrlPClearCache<cr>\|:CtrlP public/stylesheets<cr>
map <leader>gf :CtrlPClearCache<cr>\|:CtrlP features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CtrlPClearCache<cr>\|:CtrlPTag<cr>
map <leader>f :CtrlPClearCache<cr>\|:CtrlP<cr>
map <leader>F :CtrlPClearCache<cr>\|:CtrlP %%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :silent call RunTestFile()<cr>
map <leader>T :silent call RunNearestTest()<cr>
map <leader>a :silent call RunTests('')<cr>
map <leader>c :w\|:silent !script/features<cr>
map <leader>w :w\|:silent !script/features --profile wip<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
      :w
    end
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"====[ Make the 81st column stand out ]====================
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

highlight WhiteOnRed ctermbg=red ctermfg=white
"=====[ Highlight the match in red ]=============
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" disable backspace key to learn CTRL+w
map <Backspace> <Nop>

" run test
":map <leader>r :!greenbar bundle exec ruby<cr>
":map <leader>re :!greenbar bundle exec ruby -Itest %<cr>

" Greenbar
"function! RunGreenbarTest(file)
"  return SendTestToTmux(a:file)
"endfunction
"
"function! RunGreenbarFocusedTest(file, line)
"  return SendFocusedTestToTmux(a:file, a:line)
"endfunction

" run test (rspec version)
":map <leader>r :!greenbar bundle exec ruby<cr>
":map <leader>re :!greenbar bundle exec rspec %<cr>

:map <leader>dn DevNotes()

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

"nnoremap <leader>e :call FzyCommand("find -type f", ":e")<cr>
"nnoremap <leader>v :call FzyCommand("find -type f", ":vs")<cr>
"nnoremap <leader>s :call FzyCommand("find -type f", ":sp")<cr>
nnoremap <C-p> :call FzyCommand("fd -t f", ":e")<CR>

if filereadable(glob("~/.vim/vimrc.local"))
    source ~/.vim/vimrc.local
endif
