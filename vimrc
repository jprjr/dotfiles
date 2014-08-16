set nocompatible
set lazyredraw

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

set foldmethod=marker

" utf8

" run a local .vimrc
set exrc

" pathogen
execute pathogen#infect()

" tagbar
nmap <F8> :TagbarToggle<CR>

" colors
colors solarized
set background=light

" syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 1
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']
nmap <F9> :SyntasticCheck<CR>

" airline
let g:airline_theme = 'zenburn'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
match ExtraWhitespace /\s\+$/
