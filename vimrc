set nocompatible | filetype indent plugin on | syn on

fun! EnsureVamIsOnDisk(plugin_root_dir)
    let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
    if isdirectory(vam_autoload_dir)
        return 1
    else
        if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
            " I'm sorry having to add this reminder. Eventually it'll pay off.
            call confirm("Remind yourself that most plugins ship with ".
                        \"documentation (README*, doc/*.txt). It is your ".
                        \"first source of knowledge. If you can't find ".
                        \"the info you're looking for in reasonable ".
                        \"time ask maintainers to improve documentation")
            call mkdir(a:plugin_root_dir, 'p')
            execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
                        \       shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
            " VAM runs helptags automatically when you install or update plugins
            exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
        endif
        return isdirectory(vam_autoload_dir)
    endif
endfun

fun! SetupVAM()
    let c = get(g:, 'vim_addon_manager', {})
    let g:vim_addon_manager = c
    let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
    if !EnsureVamIsOnDisk(c.plugin_root_dir)
        echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
        return
    endif
    let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

    " Tell VAM which plugins to fetch & load:
    call vam#ActivateAddons([
                \  'ack',
                \  'ag',
                \  'align',
                \  'buf_it',
                \  'bundler%4280',
                \  'closetag',
                \  'ctrlp',
                \  'cucumber.zip',
                \  'dbext',
                \  'endwise',
                \  'fugitive',
                \  'git.zip',
                \  'mango',
                \  'molokai',
                \  'node',
                \  'node.js',
                \  'rake',
                \  'rails',
                \  'Scratch',
                \  'searchfold',
                \  'ShowMarks7',
                \  'Solarized',
                \  'Supertab',
                \  'surround',
                \  'Tagbar',
                \  'tagbar-phpctags',
                \  'taglist',
                \  'textobj-rubyblock',
                \  'The_NERD_Commenter',
                \  'tlib',
                \  'UltiSnips',
                \  'unimpaired',
                \  'vim-addon-mw-utils',
                \  'vim-airline',
                \  'vim-coffee-script',
                \  'vim-indent-object',
                \  'vim-javascript',
                \  'vim-jst',
                \  'vim-ruby',
                \  'vividchalk',
                \  'vim-signify',
                \ ], {'auto_install' : 0})
endfun
call SetupVAM()

filetype plugin indent on

set nocompatible
let mapleader=","
" set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Tabs and spaces stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent

" Wrap or not?
set nowrap
" setlinebreak

" Tabs and trailing spaces
" http://vimcasts.org/episodes/show-invisibles/
set list listchars=tab:▸\ ,trail:·
nmap <leader>l :set list!<CR>

" Searching
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*/cache/*,*.so,*.swp,*.zip,*.tgz,*.o,*.obj

" Status bar
set laststatus=2

" mouse on!
" set mouse=a

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" CtrlP configuration
let g:ctrlp_match_window = 'max:20,order:btt'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', 'find %s -type f']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v^\.|\.(swp|swo)$',
    \ }
let g:ctrlp_show_hidden = 0
let g:ctrlp_lazy_update = 125
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make set noexpandtab
au FileType python setlocal noexpandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
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

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" Enable syntastic syntax checking
let g:syntastic_quiet_warnings=0
let g:syntastic_check_on_open=0
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
"let g:syntastic_warning_symbol='⚠'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_warning_symbol='⚠'
"let g:syntastic_style_warning_symbol='😐'
"let g:syntastic_error_symbol='☠'
let g:syntastic_error_symbol='☠'
let g:syntastic_style_error_symbol='☠'
"let g:syntastic_style_error_symbol='😠'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" Use modeline overrides
set modeline
set modelines=10

set relativenumber

" Automatically save before commands like :next and :make
set autowrite

" Default color scheme
"syntax enable
set background=dark
set t_Co=256

let g:solarized_termtrans=1
colorscheme solarized

" Directories for swp files
"set backupdir=~/.vim/backup
"set directory=~/.vim/backup

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

function ShowSpaces(...)
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

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
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
nnoremap <SPACE> za
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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set cursorline                  " highlight current line
hi cursorline guibg=#333333     " highlight bg color of current line
hi CursorColumn guibg=#333333   " highlight cursor

set winwidth=79
set scrolloff=3
set showcmd
set wildmenu
set timeout timeoutlen=1000 ttimeoutlen=100
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
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
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
:map <leader>p :PromoteToLet<cr>

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

let g:agprg='ag --nogroup --column --smart-case --nocolor'

if filereadable(glob("~/.vim/vimrc.local"))
    source ~/.vim/vimrc.local
endif
