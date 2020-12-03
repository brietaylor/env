set mouse=a
set clipboard=autoselect,unnamedplus
"execute pathogen#infect()

set tabstop=2
set shiftwidth=2
set expandtab
highlight ColorColumn ctermbg=black
set cc=80

auto BufNewFile,BufRead Jenkinsfile setf groovy

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'terraform': ['terraform'],
\ 'python': ['black'],
\ 'Jenkinsfile': ['checkci']
\}

let g:ale_linters = {
\ 'Jenkinsfile': ['checkci']
\}

let g:ale_fix_on_save = 1
let g:ale_python_pylint_executable="pylint-3"

"let g:ale_history_log_output = 1
"let g:ale_use_global_executables = 1
"let g:ale_completion_enabled = 1
"let g:ale_open_list = 1
