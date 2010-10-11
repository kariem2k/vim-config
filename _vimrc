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
" set gfn=Courier_New:h10:cANSI
 colorscheme vibrantink
" colorscheme rdark
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

"------------------------------------
"General Mappings
"------------------------------------
nnoremap <silent> <C-F4> :BD<CR>
nnoremap <silent> <C-PageUp> :bnext<CR>
nnoremap <silent> <C-PageDown> :bprev<CR>
nnoremap <silent> <F5> :!./tests.sh<CR>
nnoremap <expr> <CR> :call pumvisible() ? "" : "<CR>"
imap <C-Space> <C-x><C-o>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1 
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set completeopt=longest,menuone
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

"" --------------------
"" OmniCppComplete
"" --------------------

"" 
"" set completeopt as don't show menu and preview
"set completeopt=menuone
"" Popup menu hightLight Group
"highlight Pmenu ctermbg=13 guibg=LightGray
"highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
"highlight PmenuSbar ctermbg=7 guibg=DarkGray
"highlight PmenuThumb guibg=Black
"" use global scope search
"let OmniCpp_GlobalScopeSearch = 1
"" 0 = namespaces disabled
"" 1 = search namespaces in the current buffer
"" 2 = search namespaces in the current buffer and in included files
"let OmniCpp_NamespaceSearch = 1
"" 0 = auto
"" 1 = always show all members
"let OmniCpp_DisplayMode = 1
"" 0 = don't show scope in abbreviation
"" 1 = show scope in abbreviation and remove the last column
"let OmniCpp_ShowScopeInAbbr = 0
"" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
"" 0 = don't display prototype in abbreviation
"" 1 = display prototype in abbreviation
"let OmniCpp_ShowPrototypeInAbbr = 1
"" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
"" 0 = hide access
"" 1 = show access
"let OmniCpp_ShowAccess = 1
"" This option can be use if you don't want to parse using namespace declarations in included files and want to add namespaces that are always used in your project.
"let OmniCpp_DefaultNamespaces = ["std"]
"" Complete Behaviour
"let OmniCpp_MayCompleteDot = 0
"let OmniCpp_MayCompleteArrow = 0
"let OmniCpp_MayCompleteScope = 0
"" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can change this behaviour with the OmniCpp_SelectFirstItem option.
"let OmniCpp_SelectFirstItem = 0
"
"
"
"
" Command: "C:\Program Files\vim\vim72\gvim.exe" -p --remote-tab-silent "%1" "%*"
