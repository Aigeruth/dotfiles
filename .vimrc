filetype plugin indent on
syntax on
match ErrorMsg '\s\+$'

call plug#begin('~/.local/share/nvim/plugged')
" tools
Plug 'tpope/vim-fugitive'  " git plugin
Plug '/usr/local/opt/fzf' " installed via Homebrew
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" extensions
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" filetype plugins
Plug 'ledger/vim-ledger'
Plug 'aklt/plantuml-syntax'
Plug 'w0rp/ale'  " langserver

" Integrations
Plug 'robertbasic/vim-hugo-helper'
Plug 'tyru/open-browser.vim'

" Colours
Plug 'https://github.com/NLKNguyen/papercolor-theme'

" OrgMode
Plug 'jceb/vim-orgmode'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'mattn/calendar-vim'
Plug '~/.vim/taglist'
Plug 'majutsushi/tagbar'

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
autocmd FileType yaml setl indentkeys-=<:>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Google style guide
autocmd FileType java setlocal ts=2 sts=2 sw=2 expandtab
