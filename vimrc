set nocompatible

" Syntax highlighting, numbering
set number
syntax on
set ruler

" Modeline
set modeline
set modelines=5

" tabs
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
" Keep tabs for Makefiles
autocmd BufEnter ?akefile* set noet

" utf8
set fencs=utf-8,default,latin1

" run a local .vimrc
set exrc

" pathogen
execute pathogen#infect()

" tagbar
nmap <F8> :TagbarToggle<CR>

" zenburn
colors zenburn

" syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']
nmap <F9> :SyntasticCheck<CR>
