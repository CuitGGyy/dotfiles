"==============================================================================
"
" plugins.vim - 对正在使用的插件调整默认配置
"
" 依赖 vim-plug 插件管理器; bundle.vim 插件使用列表
"
" Maintainer: cuitggyy (at) google.com
" Last Modified: 2023/04/10 06:32:50
"
"==============================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"------------------------------------------------------------------------------
" 根据 vim-plug 插件字典
"------------------------------------------------------------------------------
" 根据插件安装情况, 生成插件使用列表
if empty(g:plugs)
	finish
endif
let s:enabled = {}
for key in keys(g:plugs) | let s:enabled[key] = 1 | endfor


"------------------------------------------------------------------------------
" tomasr/molokai
"------------------------------------------------------------------------------
if get(s:enabled, 'molokai', 0) == 1
	" If you prefer the scheme to match the original monokai background color
	let g:molokai_original = 0

	" attempts terminals to bring the 256 color
	let g:rehash256 = 1
endif


"------------------------------------------------------------------------------
" tomasiser/vim-code-dark
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-code-dark', 0) == 1
	" If you don't like many colors and prefer the conservative style of the standard Visual Studio
	"let g:codedark_conservative = 1

	" Activates italicized comments (make sure your terminal supports italics)
	" 需要字库字体支持
	"let g:codedark_italics = 1

	" Make the background transparent
	"let g:codedark_transparent = 1
	" 修正 nvim 和 vim 之间的背景透明差异
	if has('nvim') == 0
		let g:codedark_transparent = 1
	else
		let g:codedark_transparent = 0
	endif

	" If you have vim-airline, you can also enable the provided theme
	"let g:airline_theme = 'codedark'
endif


"------------------------------------------------------------------------------
" arzg/vim-colors-xcode
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-colors-xcode', 0) == 1
	" Enable terminal 24-bit True Colour
	"set termguicolors

	" If you would like to have italic comments
	" 需要字库字体支持
	"augroup vim-colors-xcode
	"    autocmd!
	"    autocmd vim-colors-xcode ColorScheme * highlight Comment cterm=italic gui=italic
	"    autocmd vim-colors-xcode ColorScheme * highlight SpecialComment cterm=italic gui=italic
	"augroup END

endif


"------------------------------------------------------------------------------
" mhinz/vim-startify
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-startify', 0) == 1

	"let g:startify_session_dir = ''
	"let g:startify_session_autoload = 0

	" Use NERDTree bookmarks
	"let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

	" Read ~/.NERDTreeBookmarks file and takes its second column
	"function! s:nerdtreeBookmarks()
	"    let bookmarks = systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
	"    let bookmarks = bookmarks[0:-2] " Slices an empty last line
	"    return map(bookmarks, "{'line': v:val, 'path': v:val}")
	"endfunction
	"let g:startify_lists = [
	"        \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']}
	"        \]

	" returns all modified files of the current git repo
	" `2>/dev/null` makes the command fail quietly, so that when we are not
	" in a git repo, the list will be empty
	"function! s:gitModified()
	"    let files = systemlist('git ls-files -m 2>/dev/null')
	"    return map(files, "{'line': v:val, 'path': v:val}")
	"endfunction

	" same as above, but show untracked files, honouring .gitignore
	"function! s:gitUntracked()
	"    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	"    return map(files, "{'line': v:val, 'path': v:val}")
	"endfunction

	"let g:startify_lists = [
	"        \ { 'type': 'files', 'header': ['   MRU'], },
	"        \ { 'type': 'dir', 'header': ['   MRU '. getcwd()] },
	"        \ { 'type': 'sessions', 'header': ['   Sessions'], },
	"        \ { 'type': 'bookmarks', 'header': ['   Bookmarks'], },
	"        \ { 'type': function('s:gitModified'),  'header': ['   git modified'], },
	"        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked'], },
	"        \ { 'type': 'commands', 'header': ['   Commands'], },
	"        \ ]

	"let g:startify_skiplist = []

	" This will generate an ASCII art header using Figlet rather then having to create it by hand.
	"let g:startify_custom_header = startify#pad(split(system('figlet -w 100 VIM2020'), '\n'))

endif


"------------------------------------------------------------------------------
" luochen1990/rainbow
"------------------------------------------------------------------------------
if get(s:enabled, 'rainbow', 0) == 1
	let g:rainbow_conf = {
				\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick3', 'darkorchid3',],
				\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta', 'lightred',],
				\	'guis': [''],
				\	'cterms': [''],
				\	'operators': '_,_',
				\	'contains_prefix': 'TOP',
				\	'parentheses_options': '',
				\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
				\	'separately': {
				\		'*': {},
				\		'markdown': {
				\			'parentheses_options': 'containedin=markdownCode contained',
				\		},
				\		'lisp': {
				\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3',],
				\		},
				\		'haskell': {
				\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
				\		},
				\		'ocaml': {
				\			'parentheses': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
				\		},
				\		'tex': {
				\			'parentheses_options': 'containedin=texDocZone',
				\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
				\		},
				\		'vim': {
				\			'parentheses_options': 'containedin=vimFuncBody,vimExecute',
				\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
				\		},
				\		'xml': {
				\			'syn_name_prefix': 'xmlRainbow',
				\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
				\		},
				\		'xhtml': {
				\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
				\		},
				\		'html': {
				\			'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
				\		},
				\		'lua': {
				\			'parentheses': ["start=/(/ end=/)/", "start=/{/ end=/}/", "start=/\\v\\[\\ze($|[^[])/ end=/\\]/"],
				\		},
				\		'perl': {
				\			'syn_name_prefix': 'perlBlockFoldRainbow',
				\		},
				\		'php': {
				\			'syn_name_prefix': 'phpBlockRainbow',
				\			'contains_prefix': '',
				\			'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
				\		},
				\		'stylus': {
				\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
				\		},
				\		'css': 0,
				\		'sh': 0,
				\		'vimwiki': 0,
				\		'nerdtree': 0,
				\	},
				\}
	let g:rainbow_active = 1
endif


"------------------------------------------------------------------------------
" itchyny/lightline
"------------------------------------------------------------------------------
if get(s:enabled, 'lightline.vim', 0) == 1
	let g:lightline = {}
	let g:lightline.active = {
				\	'left': [
				\		[ 'mode', 'paste', 'spell', ],
				\		[ 'bufnum', 'readonly', ],
				\		[ 'relativepath', ],
				\	],
				\	'right': [
				\		[ 'cursorposition', ],
				\		[ 'filetype', 'formatencoding', ],
				\		[ 'modified', ],
				\	],
				\ }
	let g:lightline.inactive = {
				\	'left': [
				\		[ 'bufnum', 'readonly', ],
				\		[ 'absolutepath', ],
				\	],
				\	'right': [
				\		[ 'cursorposition' ],
				\		[ 'modified' ],
				\	],
				\ }
	let g:lightline.component = {
				\	'lineinfo': '%c:%l/%L',
				\	'percent': '%p%%',
				\	'cursorposition': '%c:%l/%L %p%%',
				\	'formatencoding': '%{&fenc!=#""?&fenc:&enc} (%{&ff})',
				\ }
	let g:lightline.tabline = {
				\	'left': [
				\		[ 'tabs' ]
				\	],
				\	'right': [
				\		[ 'close' ]
				\	],
				\ }
	let g:lightline.tab = {
				\ 'active': [ 'tabnum', 'filename', 'modified', ],
				\ }

	" 调整 nvim 与 vim 之间的配色差异
	if has('nvim') == 0
		let g:lightline.colorscheme = 'codedark'
	else
		let g:lightline.colorscheme = 'deus'
		"let g:lightline.colorscheme = 'one'
	endif
endif


"------------------------------------------------------------------------------
" easymotion/vim-easymotion
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-easymotion', 0) == 1
	nnoremap s <Plug>(easymotion-s2)
endif


"------------------------------------------------------------------------------
" godlygeek/tabular
"------------------------------------------------------------------------------
if get(s:enabled, 'tabular', 0) == 1
	nnoremap <bar>= :Tabularize /=<cr>
	vnoremap <bar>= :Tabularize /=<cr>
	nnoremap <bar>, :Tabularize /,/l0<cr>
	vnoremap <bar>, :Tabularize /,/l0<cr>

	nnoremap <bar>; :Tabularize /;/l0<cr>
	vnoremap <bar>; :Tabularize /;/l0<cr>
	nnoremap <bar>: :Tabularize /:/r0<cr>
	vnoremap <bar>: :Tabularize /:/r0<cr>

	nnoremap <bar>l :Tabularize /\|/l0<cr>
	vnoremap <bar>l :Tabularize /\|/l0<cr>
	nnoremap <bar>r :Tabularize /\|/r0<cr>
	vnoremap <bar>r :Tabularize /\|/r0<cr>
endif


"------------------------------------------------------------------------------
" mg979/vim-visual-multi
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-visual-multi', 0) == 1
	let g:VM_default_mappings = 0

	if has('gui_running')
		let g:VM_mouse_mappings = 0
	endif

	let g:VM_maps = {}
	let g:VM_leader = { 'default':',', 'visual':',', 'buffer':',', }

	let g:VM_maps['Undo'] = 'u'
	let g:VM_maps['Redo'] = '<c-r>'

	let g:VM_maps['Find Under'] = '<C-n>'
	let g:VM_maps['Find Subword Under'] = '<C-n>'
	let g:VM_maps['Select Cursor Down'] = '<S-Down>'
	let g:VM_maps['Select Cursor Up'] = '<S-Up>'
	let g:VM_maps['Find Next'] = ''
	let g:VM_maps['Find Prev'] = ''
	let g:VM_maps['Goto Next'] = ']'
	let g:VM_maps['Goto Prev'] = '['
	let g:VM_maps['Seek Next'] = ''
	let g:VM_maps['Seek Prev'] = ''
	let g:VM_maps['Skip Region'] = 'q'
	let g:VM_maps['Remove Region'] = 'Q'

	if exists(':VMTheme')
		let g:VM_theme_set_by_colorscheme = 1
		if &background == 'dark'
			highlight VM_Extend ctermbg=24 ctermfg=237 guibg=#5f8787 guifg=#ffffff
			highlight VM_Cursor ctermbg=31 ctermfg=237 guibg=#00af87 guifg=#ffffff
			highlight VM_Insert ctermbg=239 ctermfg=237 guibg=#5f0087 guifg=#ffffff
			highlight VM_Mono ctermbg=180 ctermfg=235 guibg=#e05f51 guifg=#ffffff
		else
			highlight VM_Extend ctermbg=24 ctermfg=237 guibg=#AAF0D6 guifg=NONE
			highlight VM_Cursor ctermbg=31 ctermfg=237 guibg=#78dede guifg=#262626
			highlight VM_Insert ctermbg=239 ctermfg=237 guibg=#ffffaf guifg=#262626
			highlight VM_Mono ctermbg=180 ctermfg=235 guibg=#B23A2D guifg=#ffffff
		endif
	endif
endif


"------------------------------------------------------------------------------
" tpope/vim-surround
"---------------------------------------------------------------------------
if get(s:enabled, 'vim-surround', 0) == 1
	" nothing
endif


"------------------------------------------------------------------------------
" preservim/nerdcommenter
"------------------------------------------------------------------------------
if get(s:enabled, 'nerdcommenter', 0) == 1
	" Create default mappings
	let g:NERDCreateDefaultMappings = 0

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 0

	" Tells the script to always remove the extra spaces when uncommenting
	" (regardless of whether NERDSpaceDelims is set)
	let g:NERDRemoveExtraSpaces = 0

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 0

	" Align line-wise comment delimiters flush left instead of following code indentation
	" one of 'none', 'left', 'start', or 'both'.
	let g:NERDDefaultAlign = 'left'

	" Tells the script whether to remove alternative comment delimiters when uncommenting
	let g:NERDRemoveAltComs = 1

	" Add your own custom formats or override the defaults
	let g:NERDCustomDelimiters = {
				\ 'gitconfig': { 'left': '#', 'leftAlt': ';', },
				\ 'gitcommit': { 'left': '#', },
				\ 'python': { 'left': '#', 'leftAlt': "'''", 'rightAlt': "'''", },
				\ 'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'cpp': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'vue': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'yaml': { 'left': '#', },
				\ }

	" Set a language to use its alternate delimiters by default
	let g:NERDAltDelims_python = 0
	let g:NERDAltDelims_vue = 0

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not
	" When this option is set to 1, NERDCommenterToggle will check all selected line,
	" if there have oneline not be commented, then comment all lines.
	let g:NERDToggleCheckAllLines = 0

	if has('nvim') || v:version >= 820
		noremap <leader>cc <Plug>NERDCommenterComment
		"noremap <leader>cn <Plug>NERDCommenterNested
		noremap <leader>c<space> <Plug>NERDCommenterToggle
		"noremap <leader>cm <Plug>NERDCommenterMinimal
		"noremap <leader>ci <Plug>NERDCommenterInvert
		noremap <leader>cs <Plug>NERDCommenterSexy
		"noremap <leader>cA <Plug>NERDCommenterAppend
		noremap <leader>ca <Plug>NERDCommenterAltDelims
		noremap <leader>cu <Plug>NERDCommenterUncomment

		noremap <leader>c<leader> <Plug>NERDCommenterInvert
		noremap <leader><leader>c <Plug>NERDCommenterUncomment
	else
		nmap <leader>cc <Plug>NERDCommenterComment
		"nmap <leader>cn <Plug>NERDCommenterNested
		nmap <leader>c<space> <Plug>NERDCommenterToggle
		"nmap <leader>cm <Plug>NERDCommenterMinimal
		"nmap <leader>ci <Plug>NERDCommenterInvert
		nmap <leader>cs <Plug>NERDCommenterSexy
		"nmap <leader>cA <Plug>NERDCommenterAppend
		nmap <leader>ca <Plug>NERDCommenterAltDelims
		nmap <leader>cu <Plug>NERDCommenterUncomment

		nmap <leader>c<leader> <Plug>NERDCommenterInvert
		nmap <leader><leader>c <Plug>NERDCommenterUncomment

		vmap <leader>cc <Plug>NERDCommenterComment
		"vmap <leader>cn <Plug>NERDCommenterNested
		vmap <leader>c<space> <Plug>NERDCommenterToggle
		"vmap <leader>cm <Plug>NERDCommenterMinimal
		"vmap <leader>ci <Plug>NERDCommenterInvert
		vmap <leader>cs <Plug>NERDCommenterSexy
		"vmap <leader>cA <Plug>NERDCommenterAppend
		vmap <leader>ca <Plug>NERDCommenterAltDelims
		vmap <leader>cu <Plug>NERDCommenterUncomment

		vmap <leader>c<leader> <Plug>NERDCommenterInvert
		vmap <leader><leader>c <Plug>NERDCommenterUncomment
	endif
endif


"------------------------------------------------------------------------------
" jiangmiao/auto-pairs
"------------------------------------------------------------------------------
if get(s:enabled, 'auto-pairs', 0) == 1
	" All arguments follow are default 1
	let g:AutoPairsMapBS = 0
	let g:AutoPairsMapCh = 0
	let g:AutoPairsMapCR = 1
	let g:AutoPairsMapCenterLine = 0
	let g:AutoPairsMapSpace = 1
	let g:AutoPairsMapMultilineClose = 0

	" Default shortcuts
	let g:AutoPairsShortcutToggle = '<M-p>'
	let g:AutoPairsShortcutFastWrap = '<M-e>'
	let g:AutoPairsShortcutJump = '<M-n>'
	let g:AutoPairsShortcutBackInsert = '<M-b>'

	" Fly Mode
	let g:AutoPairsFlyMode = 0
endif


"------------------------------------------------------------------------------
" skywind3000/asyncrun
"------------------------------------------------------------------------------
if get(s:enabled, 'asyncrun.vim', 0) == 1
	" 自动打开 quickfix window 高度为 10
	let g:asyncrun_open = 10

	" 任务结束时候响铃提醒
	let g:asyncrun_bell = 1

	" 设置 F10 打开/关闭 Quickfix 窗口
	nnoremap <f4> :call asyncrun#quickfix_toggle(10)<cr>

	" F9 编译 C/C++ 文件
	"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

	" F5 运行文件
	"nnoremap <silent> <F5> :call ExecuteFile()<cr>

	" F7 编译项目
	"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

	" F8 运行项目
	"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

	" F6 测试项目
	"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

	" 更新 cmake
	"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

	" Windows 下支持直接打开新 cmd 窗口运行
	"if has('win32') || has('win64')
	"    nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
	"endif
endif

"------------------------------------------------------------------------------
" skywind3000/vim-quickui
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-quickui', 0) == 1
	" 取得本文件所在的目录
	let s:vimrc = fnamemodify(resolve(expand('<sfile>:p')), ':h')

	" 加载 quickmenu 配置文件
	execute 'source '. fnameescape(s:vimrc. '/'. 'quickui-menu.vim')
	"execute 'source '. fnameescape(s:vimrc. '/'. 'terminal-help.vim')

endif


"------------------------------------------------------------------------------
" skywind3000/vim-auto-popmenu
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-auto-popmenu', 0) == 1

	" 启用 apc 插件, 默认值: 1
	let g:apc_enable = 0
	let b:apc_enable = 0

	" 设定需要生效的文件类型，如果是 '*'' 的话，代表所有类型
	let g:apc_enable_ft = { 'text':1, 'markdown':1, 'vim':1, 'php':1, }

	" 映射 tab 键, 默认值: 1
	let g:apc_enable_tab = 1

	" 触发补全最小字符数, 默认值: 2
	let g:apc_min_length = 2

	" 忽略补全关键词列表, 默认值: []
	let g:apc_key_ignore = []

	" 触发补全菜单快捷键, 默认值: "\<c-n>"
	"let g:apc_triger = "\<c-n>"

	" 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
	set cpt=.,k,w,b

	" 不要自动选中第一个选项。
	set completeopt=menu,menuone,noselect

	" 禁止在下方显示一些啰嗦的提示
	set shortmess+=c

	function! ApcToggle()
		if b:apc_enable
			execute 'ApcDisable'
		else
			execute 'ApcEnable'
		endif
	endfunction
	command -nargs=0 ApcToggle call ApcToggle()

endif


"------------------------------------------------------------------------------
" skywind3000/vim-dict
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-dict', 0) == 1
	" Add additional dict folders
	let g:vim_dict_dict = [
				\ '~/.vim/dict',
				\ '~/.config/nvim/dict',
				\ ]
	" File type override
	"let g:vim_dict_config = {
	"            \ 'html':'html,javascript,css',
	"            \ 'markdown':'test',
	"            \ }
	" Disable certain types
	"let g:vim_dict_config = {'text': ''}
endif


"------------------------------------------------------------------------------
" sheerun/vim-polyglot
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-polyglot', 0) == 1

	"let g:polyglot_disabled = [ 'markdown' ]
	"let g:polyglot_disabled = [ 'autoindent' ]
	"let g:polyglot_disabled = [ 'ftdetect' ]

endif


"==============================================================================


"------------------------------------------------------------------------------
" vim-airline/vim-airline
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-airline', 0) == 1
	"let g:airline_powerline_fonts = 0
	"if !exists('g:airline_symbols')
	"	let g:airline_symbols = {}
	"endif
	"let g:airline_symbols.linenr = ''
	"let g:airline_symbols.readonly = ''
	"let g:airline_symbols.branch = ''
	"let g:airline_left_sep = ''
	"let g:airline_left_alt_sep = ''
	"let g:airline_right_sep = ''
	"let g:airline_right_alt_sep = ''
	"let g:airline_exclude_preview = 1
	"let g:airline_theme='dark'
	let g:airline_section_b = '%n'

	" This is disabled by default; add the following to vimrc enable the extension
	let g:airline#extensions#tabline#enabled = 1
	" Separators can be configured independently for the tabline
	"let g:airline#extensions#tabline#left_sep = ' '
	"let g:airline#extensions#tabline#left_alt_sep = '|'
	" 'default'|'jsformatter'|'unique_tail'|'unique_tail_improved'
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

	" integrates with a variety of plugins
	"let g:airline#extensions#ale#enabled = 0
	"let g:airline#extensions#branch#enabled = 0
	"let g:airline#extensions#syntastic#enabled = 0
	"let g:airline#extensions#fugitiveline#enabled = 0
	"let g:airline#extensions#csv#enabled = 0
	"let g:airline#extensions#vimagit#enabled = 0
endif


"------------------------------------------------------------------------------
" tpope/vim-commentary
"---------------------------------------------------------------------------
if get(s:enabled, 'vim-commentary', 0) == 1
	" 根据文件类型设置注释字符串
	autocmd FileType shell,python setlocal commentstring=#%s
	autocmd FileType c,cpp setlocal commentstring=//%s

	" 快捷键绑定
	xmap <leader>cc gc
	nmap <leader>cc gcc
	nmap <leader>cu gcu

	xmap <leader>c<space> gc
	nmap <leader>c<space> gcc
	nmap <leader><leader>c gcgc
endif


"------------------------------------------------------------------------------
" Raimondi/delimitMate
"------------------------------------------------------------------------------
if get(s:enabled, 'delimitMate', 0) == 1
	" Default shortcuts
	"inoremap <BS> <Plug>delimitMateBS
	"inoremap <S-BS> <Plug>delimitMateS-BS
	"inoremap <S-Tab> <Plug>delimitMateS-Tab
	"inoremap <C-G>g <Plug>delimitMateJumpMany
endif


"------------------------------------------------------------------------------
" skywind3000/vim-terminal-help
"------------------------------------------------------------------------------
if get(s:enabled, 'vim-terminal-help', 0) == 1

	"which key will be used to toggle terminal window, default to <m-=>.
	let g:terminal_key =

	" initialize working dir: 0 for unchanged, 1 for file path and 2 for project root.
	let g:terminal_cwd = 1

	" new terminal height, default to 10.
	let g:terminal_height = 30

	" where to open the terminal, default to rightbelow.
	"let g:terminal_pos =

	" specify shell rather than default one.
	"let g:terminal_shell =

	" command to open the file in vim, default to tab drop.
	"let g:terminal_edit

	" set to term to kill term session when exiting vim.
	"let g:terminal_kill

	" set to 0 to hide terminal buffer in the buffer list.
	"let g:terminal_list

	" set to 1 to set winfixheight for the terminal window.
	"let g:terminal_fixheight = 1

	"set to 1 to close window if process finished.
	"let g:terminal_close = 0

endif


"------------------------------------------------------------------------------
" preservim/nerdtree
"------------------------------------------------------------------------------
if get(s:enabled, 'nerdtree', 0) == 1

	let g:NERDTreeWinPos = "right"
	let g:NERDTreeWinSize = 35

	let NERDTreeIgnore = ['\~$', '\.pyc$', '__pycache__']
	"let NERDTreeMinimalUI = 1
	"let NERDTreeChDirMode = 1
	let NERDTreeShowHidden = 1
	let NERDTreeShowBookmarks = 1
	let NERDTreeShowAutoCenter = 1
	let NERDTreeShowLineNumbers = 1

	map <leader>[ :NERDTreeToggle<cr>

	"map <leader>nn :NERDTreeToggle<cr>
	"map <leader>nb :NERDTreeFromBookmark<space>
	"map <leader>nf :NERDTreeFind<cr>

endif


