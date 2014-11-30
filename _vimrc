set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


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
set noeb vb t_vb= "Disable audiobell
set vb t_vb= "Disable audiobell
if has("gui_gtk2")
    set guifont=UbuntuMono\ 10
elseif has("gui_macvim")
    set guifont=Monospace\ 12
elseif has("gui_win32")
    set guifont=Monospace\ 10
end
" colorscheme vibrantink
 colorscheme rdark
" colorscheme ir_black

" au GUIEnter * simalt ~x

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
nnoremap <silent> <F5> :!./crun.sh<CR>
nnoremap <expr> <CR> :call pumvisible() ? "" : "<CR>"
imap <C-Space> <C-x><C-o>
map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR> 

"------------------------------------
"Clang_Complete
"------------------------------------
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_close_preview = 1
let g:clang_periodic_quickfix = 1
let g:clang_complete_copen = 1

"" --------------------
"" MiniBufExpl
"" --------------------
"let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
"let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
"let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
"let g:miniBufExplMaxSize = 1 " <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.
""let g:miniBufExplForceSyntaxEnable = 1 " There is a Vim bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
""let g:miniBufExplorerMoreThanOne = 1 " Setting this to 0 will cause the MBE window to be loaded even
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1 
""let g:miniBufExplMapWindowNavArrows = 1
"highlight MBENormal guibg=LightGray guifg=DarkGray
"highlight MBEChanged guibg=Red guifg=DarkRed
"highlight MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=Black
"highlight MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black

""---------------------
"" TagList
"" --------------------
"" F4: Switch on/off TagList
"nnoremap <silent> <F4> :TlistToggle<CR>
""let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
"let Tlist_Show_One_File = 1 " Displaying tags for only one file~
"let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
"let Tlist_Sort_Type = "order" " sort by order or name
"let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
"let Tlist_Compact_Format = 1 " Remove extra information and blank lines from the taglist window.
"let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
"let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
"let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
"let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
"let Tlist_WinWidth = 40
"" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
"" very slow, so I disable this
"" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.

"
"
" Command: "C:\Program Files\vim\vim72\gvim.exe" -p --remote-tab-silent "%1" "%*"
