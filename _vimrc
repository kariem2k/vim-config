set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
runtime macros/matchit.vim
behave mswin

if has('win32')
    let s:vim_files = expand('$HOME/vimfiles')
else
    let s:vim_files = expand('$HOME/.vim')
endif

execute pathogen#infect()
call plug#begin(s:vim_files . '/plugged')
let fzf_dir = s:vim_files . '/.fzf'

if has('win32')
    Plug 'junegunn/fzf', { 'dir': fzf_dir } "Need to install it manually
else
    Plug 'junegunn/fzf', { 'dir': fzf_dir, 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/dbext.vim'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
if has('win32') "Disable it for now, on windows
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif
call plug#end()
"""
" Customizations

" GUI
set guioptions=embr
set nobackup
set nowrap
set ignorecase
set incsearch
set showmatch
set nohlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set smartindent
set keymodel-=stopsel
set encoding=utf-8   
"set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
set noeb vb t_vb= "Disable audiobell
set vb t_vb= "Disable audiobell
set laststatus=2
set number 
set relativenumber

syntax enable

let s:uname = system("uname")
if has("gui_gtk2")
    set guifont=UbuntuMono\ 10
elseif s:uname == "Darwin\n"
    set guifont=Inconsolata\ for\ Powerline:h15
elseif has("gui_win32")
    set guifont=Powerline\ consolas:h10:cANSI
end
"
set t_Co=256   " This is may or may not needed.

let &backupdir = s:vim_files . '/backup,.'
let &directory = s:vim_files . '/temp//,.'
let &undodir = s:vim_files . '/undo,.'

"---------------------------------------
"Increase/Decrease Numbers
"---------------------------------------
noremap <c-kPlus> <c-A>
noremap <c-kMinus> <c-X>

"----------------------------------------
"General File Mappings
"----------------------------------------
autocmd BufNewFile,BufRead *.vb set ft=vbnet
autocmd BufNewFile,BufRead *.nsh set ft=nsis
autocmd! BufNewFile,BufRead *.sc set filetype=glsl
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
"-------------------------------------
"NERDTree
"-------------------------------------
" F3: Switch on/off TagList
nnoremap <silent> <F3> :execute "NERDTreeToggle " . getcwd()<CR>
let NERDTreeWinPos = "left"
let NERDTreeQuitOnOpen = 1

"--------------------------------------
"RagTag
"--------------------------------------
let g:ragtag_global_maps = 1 

"--------------------------------------
"FuzzyFInder
"--------------------------------------
let g:fuf_enumeratingLimit = 50
nnoremap <silent> <C-S-B> :FufBuffer<CR>
"nmap <C-S-N> :FufFile root<CR>
nmap <C-S-N> :FufFile<CR>

let g:fuf_abbrevMap = {
    \   "^r" : [ "**/", ],
    \   "^/" : [ "**/", ],
    \   "^m/" : [ "app/models/*", ],
    \   "^v/" : [ "app/views/**/*", ],
    \   "^c/" : [ "app/controllers/*", ],
    \   "^h/" : [ "app/helpers/*", ],
    \   "^cfg/" : [ "config/**/*", ],
    \   "^pub/" : [ "public/**/*", ], 
    \   "^s/" : [ "src/**/*", ],
    \   "^t/" : [ "test/**/*", ],
    \ } 

"-----------------------------------
" Tags
" To generate tags for something global like OpenGL or stl or anything, to
" ~/.tags dir and it will be loaded
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.tags/gl /usr/include/GL/" 
"-----------------------------------
set tags=./

for f in split(glob('~/.tags/*'), '\n')
    exec 'set tags+=' . f
endfor

function! UPDATE_TAGS()
  let _f_ = expand("%:p")
  let _cmd_ = '"ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q ."'
  let _resp = system(_cmd_)
  unlet _cmd_
  unlet _f_
  unlet _resp
endfunction
"autocmd BufWritePost *.cpp,*.h,*.c call UPDATE_TAGS()
"------------------------------------
"General Mappings
"------------------------------------
nnoremap <silent> <C-F4> :BD<CR>
nnoremap <silent> <C-PageUp> :bnext<CR>
nnoremap <silent> <C-PageDown> :bprev<CR>
imap <C-Space> <C-x><C-o>
map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR> 
set nostartofline
"------------------------------------
"Clang_Complete
"------------------------------------
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_close_preview = 1
let g:clang_periodic_quickfix = 1
let g:clang_complete_copen = 1

""---------------------------------------------
"CtrlP
""--------------------------------------------
let g:ctrlp_root_markers = ['.projectrootdir']

"Filetypes
let g:sql_type_default = "sqlserver" 
au BufNewFile,BufRead *.ser set filetype=sqlserver 

let g:sw_exe = s:vim_files . '/3rdparty/workbench/sqlwbconsole.exe'
let g:sw_tmp = s:vim_files . '/3rdparty/tmp'
""DBExt
"autocmd! VimEnter *.sql DBCompleteTables
"autocmd! VimEnter *.sql DBCompleteViews
"autocmd! VimEnter *.sql DBCompleteProcedures

"" --------------------
"" MiniBufExpl
"" --------------------
"let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
"let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
"let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
"let g:miniBufExplMaxSize = 1 " <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.
"let g:miniBufExplForceSyntaxEnable = 1 " There is a Vim bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
"let g:miniBufExplorerMoreThanOne = 1 " Setting this to 0 will cause the MBE window to be loaded even
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplSetUT = 1
""hi MBENormal               guifg=#808080 guibg=fg
"hi MBEChanged              guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal        guifg=#FFFFFF guibg=#d8d4d4
"hi MBEVisibleChanged       guifg=#F1266F guibg=#d8d4d4
"hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=#382d2d
"hi MBEVisibleActiveChanged guifg=#F1266F guibg=#382d2d

""---------------------
""rg
""---------------------
let g:rg_command = 	'rg --vimgrep -i'


let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'sql': {
\			'parentheses': ['start=/\c^\s*begin\>/ fold end=/\c^\s*end\W*$/ fold'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}


let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endi
"For consolas font on windows
let g:airline_symbols.space = "\ua0"
let g:airline_left_sep = "\u2b80" "use double quotes here
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"
"
if has('gui_running')
    set background=dark
else
    set background=dark
endif
colorscheme papercolor


""-------------------------------------------------------------------------
if filereadable("~/_vimrc_machinespecific.vim")
    source ~/_vimrc_machinespecific.vim
endif

if has('win32')
    au GUIEnter * simalt ~x
elseif s:uname == "Darwin\n"
    set lines=999 columns=9999
endif
