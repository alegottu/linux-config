" Shortcut to enter normal mode
inoremap kj <Esc>

" System copy + paste bindings
vnoremap <C-c> "+y
vnoremap <C-v> "+P

" Ensure visual-block mode still has a binding
nnoremap B <C-v>

" Add file tree shortcuts
inoremap <C-f> <Esc>:Lex<cr>:vertical resize 30<cr>
nnoremap <C-f> :Lex<cr>:vertical resize 30<cr>

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type filetype detection.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Enable hybrid line-numbers by default
set number relativenumber 

" Automatically switch to absoulte line-numbers in insert mode 
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Handle standard plugins
packadd termdebug

" Handle third party plugins
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'yegappan/lsp'

call plug#end()

let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\    name: 'clangd',
	\    filetype: ['c', 'cpp'],
	\    path: '/usr/local/bin/clangd',
	\    args: ['--background-index']
	\  },
  \ #{
	\    name: 'rustlang',
	\    filetype: ['rust'],
	\    path: '/usr/local/bin/rust-analyzer',
	\    args: [],
	\    syncInit: v:true
	\  }]

autocmd User LspSetup call LspAddServer(lspServers)
