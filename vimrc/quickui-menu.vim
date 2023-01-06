"======================================================================
"
" quickui-menu.vim - quickui 菜单插件
"
" 依赖 Vim 8.1 +popup 特性
"
" Maintainer: cuitggyy (at) google.com
" Last Modified: 2023/01/07 02:26:25
"
"======================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"------------------------------------------------------------------------------
" quickui 初始化
"------------------------------------------------------------------------------

if has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0
	finish
endif

call quickui#menu#reset()


"------------------------------------------------------------------------------
" 顶部菜单栏
"------------------------------------------------------------------------------
call quickui#menu#install("&File", [
			\ [ "&New File\t:tabnew", ':tabnew', ''],
			\ [ "&Open File\t:tabe", 'call feedkeys(":tabedit ")', ''],
			\ [ "-", '', ''],
			\ [ "&Save\t:w", 'write', ''],
			\ [ "Save &As\t:w %", 'call feedkeys(":write ")', ''],
			\ [ "Save All\t:wall", 'wall', ''],
			\ [ "&Close\t:tabc", 'tabclose', ''],
			\ [ "-", '', ''],
			\ [ "E&xit\t:qall", 'qall', ''],
			\ ])

call quickui#menu#install("&Edit", [
			\ ['&Strip Trail Spaces', 'call StripTrailSpaces()', ''],
			\ ['Update &Modified Datetime', 'call LastModifiedDatetime(15)', ''],
			\ ['-', '', ''],
			\ ['&Align Table', 'Tabularize /|', ''],
			\ ['-', '', ''],
			\ ['&Diff Original', 'DiffOrig', ''],
			\ ])

call quickui#menu#install("&Diff", [
			\ ["Diff &This\t\\dt", 'diffthis', ''],
			\ ["Diff &Split\t\\ds", 'call feedkeys(":vertical diffsplit ")', ''],
			\ ["Diff &Patch\t\\dp", 'call feedkeys(":vertical diffpatch ")', ''],
			\ ["Diff &Original\t\\do", 'DiffOrig', ''],
			\ ['-', '', ''],
			\ ["Diff &Update\t\\du", 'diffupdate', ''],
			\ ['-', '', ''],
			\ ["&Diff Off\t\\dq", 'diffoff!', ''],
			\ ])

call quickui#menu#install("&Build", [
			\ ["File &Execute\tF5", 'AsyncTask file-run', ''],
			\ ["File &Compile\tF9", 'AsyncTask file-build', ''],
			\ ["File E&make\tF7", 'AsyncTask emake', ''],
			\ ["File &Start\tF8", 'AsyncTask emake-exe', ''],
			\ ['-', '', ''],
			\ ["&Project Build\tShift+F9", 'AsyncTask project-build', ''],
			\ ["Project &Run\tShift+F5", 'AsyncTask project-run', ''],
			\ ["Project &Test\tShift+F6", 'AsyncTask project-test', ''],
			\ ["Project &Init\tShift+F7", 'AsyncTask project-init', ''],
			\ ['-', '', ''],
			\ ["T&ask List\tCtrl+F10", 'call MenuHelp_TaskList()', ''],
			\ ['E&dit Task', 'AsyncTask -e', ''],
			\ ['Edit &Global Task', 'AsyncTask -E', ''],
			\ ['&Stop Building', 'AsyncStop', ''],
			\ ])

call quickui#menu#install('&Tools', [
			\ ['&Spell %{&spell? "Off":"On"}', 'setlocal spell!', ''],
			\ ['&Paste %{&paste? "Off":"On"}', 'setlocal paste!', ''],
			\ ['-', '', ''],
			\ ['Line &Number %{&number? "Off":"On"}', 'set number!', ''],
			\ ['&Relative Number %{&relativenumber? "Off":"On"}', 'set relativenumber!', ''],
			\ ['&Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!', ''],
			\ ['-', '', ''],
			\ ['Switch &Buffer', 'call quickui#tools#list_buffer("FileSwitch tabe")', ''],
			\ ['List &Function', 'call quickui#tools#list_function()', ''],
			\ ['Display &Messages', 'call quickui#tools#display_messages()', ''],
			\ ['Display &Help', 'call quickui#tools#display_help("usr_01")', ''],
			\ ['-', '', ''],
			\ ["&Explore\tc-esc", ':Lexplore', ''],
			\ ["&Terminal\tc-`", ':split | terminal', ''],
			\ ])

call quickui#menu#install('&Plugins', [
			\ ['%{b:apc_enable? "Disable":"Enable"} &APC', 'ApcToggle', 'Auto Popup Completetion'],
			\ ['-', '', ''],
			\ ['Plugins &Status', 'PlugStatus', 'List plugins status'],
			\ ['&Update Plugins', 'PlugUpdate', 'Update used plugins'],
			\ ['&Clean Plugins', 'PlugClean', 'Clean unused plugins'],
			\ ['-', '', ''],
			\ ['Up&grade vim-plug', 'PlugUpgrade', 'Upgrade vim-plug'],
			\ ])

call quickui#menu#install('&Help', [
			\ ['&About', 'call quickui#textbox#open(["Hello world!"], {"close":"button", "title":"Dialog"})', ''],
			\ ['-', '', ''],
			\ ['&Help', 'execute "normal! K"', 'Help'],
			\ ])


"----------------------------------------------------------------------
" 光标所在位置的上下文关联弹出菜单
"----------------------------------------------------------------------
let g:context_menu_k = [
			\ ["&Peek Definition\t\\k=;", 'call quickui#tools#preview_tag("")'],
			\ ["S&earch in Project\t\\k-", 'execute "silent! grep " . expand("<cword>")'],
			\ [ '-', '', ''],
			\ [ "Find &From Ctags\t\\cz", 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
			\ [ '-', '', ''],
			\ ['P&ython Docs', 'call quickui#tools#python_help("")', 'python3'],
			\ ]


"----------------------------------------------------------------------
" 界面风格和色彩主题
"----------------------------------------------------------------------

" 显示 quickui 菜单提示
let g:quickui_show_tip = 1

" 边框显示风格
let g:quickui_border_style = 2

" quickui 色彩主题
if &background == 'dark'
	"let g:quickui_color_scheme = 'gruvbox'
	let g:quickui_color_scheme = 'papercol_dark'
	"let g:quickui_color_scheme = 'solarized'
	"let g:quickui_color_scheme = 'system'
else
	"let g:quickui_color_scheme = 'borland'
	let g:quickui_color_scheme = 'papercol_light'
endif

" 修正 quickui 弹出补全菜单的色彩
if get(g:, 'quickui_color_pmenu', 0) == 0
	if get(g:, 'quickui_color_theme', '') != 'vim'
		highlight! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
		highlight! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
	endif
endif

" preview window size
let g:quickui_preview_w = 100
let g:quickui_preview_h = 15

" specofy color group
"highlight! QuickBG ctermfg=0 ctermbg=7 guifg=black guibg=gray
"highlight! QuickSel cterm=bold ctermfg=0 ctermbg=2 gui=bold guibg=brown guifg=gray
"highlight! QuickKey term=bold ctermfg=9 gui=bold guifg=#f92772
"highlight! QuickOff ctermfg=59 guifg=#75715e
"highlight! QuickHelp ctermfg=247 guifg=#959173


"----------------------------------------------------------------------
" 菜单功能快捷键
"----------------------------------------------------------------------

" 顶部菜单栏快捷键绑定
nnoremap <silent><space><space> :call quickui#menu#open()<cr>
nnoremap <silent><tab><space> :call quickui#menu#open()<cr>

" 上下文关联菜单快捷键
nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
nnoremap <silent><tab><cr> :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>

if has('gui_running') || has('nvim')
	noremap <c-f10> :call MenuHelp_TaskList()<cr>
endif


