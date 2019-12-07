if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let current_compiler = "ruby"

CompilerSet makeprg=ruby\ -c\ %
CompilerSet errorformat=%f:%l:%m
