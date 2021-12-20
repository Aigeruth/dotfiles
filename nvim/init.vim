" filetype plugin indent on
" syntax on
match ErrorMsg '\s\+$'

call plug#begin('~/.local/share/nvim/plugged')
" tools
Plug 'tpope/vim-fugitive'  " git plugin
Plug '/usr/local/opt/fzf' " installed via Homebrew
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" org mode
Plug 'nvim-lua/plenary.nvim'
Plug 'vhyrro/neorg'

" extensions
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" filetype plugins
Plug 'aklt/plantuml-syntax'
Plug 'w0rp/ale'  " langserver

" Colours
Plug 'https://github.com/NLKNguyen/papercolor-theme'

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

call plug#end()

"""
" Plugin configurations
"""
" Ale
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint', 'prettier'],
\  'python': ['black']
\}

"""
" File type configurations
"""
" autocmd FileType yaml setl indentkeys-=<:>
" autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Google style guide
" autocmd FileType java setlocal ts=2 sts=2 sw=2 expandtab
