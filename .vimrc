set nocompatible
filetype off " for NeoBundle
 
if has('vim_starting')
        set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
 
"NeoBundle で管理するプラグイン
NeoBundle 'Shougo/neocomplete'		" 補完
NeoBundle 'Shougo/unite.vim.git'	" ファイラ
NeoBundle 'scrooloose/nerdtree'		" ディレクトリーツリーの表示
NeoBundle 'thinca/vim-quickrun'		" \r ですぐに実行
NeoBundle 'Shougo/neosnippet'		" スニペット 
NeoBundle 'Shougo/neosnippet-snippets'	" スニペット
NeoBundle 'scrooloose/syntastic'	" シンタックス・チェック
NeoBundle 'ujihisa/neco-ghc'		" haskellの補完
NeoBundle 'eagletmt/ghcmod-vim'		" haskellの型を表示
NeoBundle 'Shougo/vimshell'			" shell

" 非同期処理用
NeoBundle 'Shougo/vimproc', {		
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
call neobundle#end()
filetype plugin indent on  " restore filetype
NeoBundleCheck

colorscheme desert


""""" setting
set number				" 行番号表示
set incsearch				" インクリメントサーチ
set wildmenu wildmode=list:full		" 
set nohlsearch				" 
set cursorline				" カーソル行の強調
set autoindent				" 自動インデント
set guifont=Monospace\ 12 
set guifontwide=Monospace\ 12 
set tabstop=4
set shiftwidth=4
set clipboard+=unnamed

vnoremap < <gv	"インデント後にビジュアルモードを解除しない
vnoremap > >gv	
nnoremap Y y$	" カーソル位置から行末までヤンク

""""" nerdtree
""nnoremap <silent><C-e> :NERDTreeToggle<CR>" 

""""" unite
nnoremap <silent><C-e> :Unite file -buffer-name=file<CR>

""""" quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['_'] = {
	\ 'runner'    : 'vimproc',
	\ 'runner/vimproc/updatetime' : 60,
	\ 'outputter' : 'error',
	\ 'outputter/error/success' : 'buffer',
	\ 'outputter/error/error'   : 'quickfix',
	\ 'outputter/buffer/split'  : ':rightbelow 8sp',
	\ 'outputter/buffer/close_on_empty' : 1,
	\ 'exec'	: ['%c %o %s -o %s:p:r', '%s:p:r %a'],
	\ }
let g:quickrun_config['tex'] = {
	\ 'command' : 'latexmk',
	\ 'exec'	: '%c %o %s',
	\ }
let g:quickrun_config['cpp'] = {
	\ 'command' : 'g++'	,
	\ 'cmdopt'	: '-std=c++11 -lm',
	\ }
let g:quickrun_config['haskell'] = {
	\ 'command' : 'ghc',
	\ }


au FileType qf nnoremap <silent><buffer>q :quit<CR>

let g:quickrun_no_default_key_mappings = 1
nnoremap <F5> :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <F5> :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

""""" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:haskellmode_completion_gch = 0

"""""" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_haskell_checkers = ['hlint']
let g:syntastic_tex_checkers = ['lacheck']




