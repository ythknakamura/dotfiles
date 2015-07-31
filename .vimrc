set nocompatible
filetype off " for NeoBundle
 
if has('vim_starting')
        set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
 
" NeoBundle で管理するプラグインを追加します。
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-watchdogs'
call neobundle#end()
filetype plugin indent on  " restore filetype
NeoBundleCheck


set number
set incsearch
set wildmenu wildmode=list:full
set nohlsearch
set cursorline

noremap <Space>ht :GhcModType<CR>
noremap <Space>hh :GhcModTypeClear<CR>
noremap <Space>hT :GhcModTypeInsert<CR>
