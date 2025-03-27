"===============================================================================
"
" tweak.vim - 调整插件默认选项配置
"
" 依赖 vim-plug 插件管理器及插件分组配置
"
" Maintainer: cuitggyy (at) google.com
" Last Modified: 2025/03/27 17:34:39
"
"===============================================================================


"-------------------------------------------------------------------------------
" vim-plug 插件安装使用列表
"-------------------------------------------------------------------------------
" 根据插件安装情况, 生成插件使用列表
if !exists('g:plugs') || type(g:plugs) != v:t_dict
	finish
endif
let s:plugged = {}
for key in keys(g:plugs) | let s:plugged[key] = 1 | endfor


"-------------------------------------------------------------------------------
" tomasr/molokai
"-------------------------------------------------------------------------------
if get(s:plugged, 'molokai', 0) == 1
	" If you prefer the scheme to match the original monokai background color
	let g:molokai_original = 0

	" attempts terminals to bring the 256 color
	let g:rehash256 = 1
endif


"-------------------------------------------------------------------------------
" tomasiser/vim-code-dark
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-code-dark', 0) == 1
	" If you don't like many colors and prefer the conservative style of the standard Visual Studio
	"let g:codedark_conservative = 1

	" Activates italicized comments (make sure your terminal supports italics)
	" 需要字库字体支持
	"let g:codedark_italics = 1

	" Make the background transparent
	"let g:codedark_transparent = 1
	" 修正 nvim 和 vim 之间的背景透明差异
	"if has('nvim') == 0
	"    let g:codedark_transparent = 1
	"else
	"    let g:codedark_transparent = 0
	"endif

	" If you have vim-airline, you can also enable the provided theme
	"let g:airline_theme = 'codedark'
endif


"-------------------------------------------------------------------------------
" arzg/vim-colors-xcode
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-colors-xcode', 0) == 1
	" Enable terminal 24-bit True Colour
	set termguicolors

	" If you would like to have italic comments
	" 需要字库字体支持
	"augroup vim-colors-xcode
	"    autocmd!
	"    autocmd vim-colors-xcode ColorScheme * highlight Comment cterm=italic gui=italic
	"    autocmd vim-colors-xcode ColorScheme * highlight SpecialComment cterm=italic gui=italic
	"augroup END

endif


"-------------------------------------------------------------------------------
" 依据时间段自动启用不同的色彩主题样式
"-------------------------------------------------------------------------------
" 应尽早加载 colorscheme 使其他插件正确配色
try
	let hour = str2nr(strftime('%H'))
	if hour > 8 && hour < 18
		colorscheme codedark
	else
		colorscheme xcodedarkhc
	endif
catch
	colorscheme molokai
endtry


"-------------------------------------------------------------------------------
" itchyny/lightline
"-------------------------------------------------------------------------------
if get(s:plugged, 'lightline.vim', 0) == 1
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
				\		[ 'filetype', 'formatencoding', ],
				\		[ 'modified' ],
				\	],
				\ }
	let g:lightline.component = {
				\	'location': '%c:%l/%L',
				\	'progress': '%p%%',
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
	if has('nvim')
		let g:lightline.colorscheme = 'deus'
		"let g:lightline.colorscheme = 'one'
	else
		let g:lightline.colorscheme = 'codedark'
	endif
endif


"-------------------------------------------------------------------------------
" mhinz/vim-startify
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-startify', 0) == 1

	"let g:startify_session_dir = ''
	"let g:startify_session_autoload = 0

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


"-------------------------------------------------------------------------------
" luochen1990/rainbow
"-------------------------------------------------------------------------------
if get(s:plugged, 'rainbow', 0) == 1
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


"-------------------------------------------------------------------------------
" jiangmiao/auto-pairs
"-------------------------------------------------------------------------------
if get(s:plugged, 'auto-pairs', 0) == 1
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


"-------------------------------------------------------------------------------
" tpope/vim-surround
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-surround', 0) == 1
	" nothing
endif


"-------------------------------------------------------------------------------
" godlygeek/tabular
"-------------------------------------------------------------------------------
if get(s:plugged, 'tabular', 0) == 1

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


"-------------------------------------------------------------------------------
" kshenoy/vim-signature
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-signature', 0) == 1

"	mx           Toggle mark 'x' and display it in the leftmost column
"	dmx          Remove mark 'x' where x is a-zA-Z
"
"	m,           Place the next available mark
"	m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
"	m-           Delete all marks from the current line
"	m<Space>     Delete all marks from the current buffer
"	]`           Jump to next mark
"	[`           Jump to prev mark
"	]'           Jump to start of next line containing a mark
"	['           Jump to start of prev line containing a mark
"	`]           Jump by alphabetical order to next mark
"	`[           Jump by alphabetical order to prev mark
"	']           Jump by alphabetical order to start of next line having a mark
"	'[           Jump by alphabetical order to start of prev line having a mark
"	m/           Open location list and display marks from current buffer
"
"	m[0-9]       Toggle the corresponding marker !@#$%^&*()
"	m<S-[0-9]>   Remove all markers of the same type
"	]-           Jump to next line having a marker of the same type
"	[-           Jump to prev line having a marker of the same type
"	]=           Jump to next line having a marker of any type
"	[=           Jump to prev line having a marker of any type
"	m?           Open location list and display markers from current buffer
"	m<BS>        Remove all markers

	nnoremap <silent><tab>m :SignatureToggleSigns<cr>
	vnoremap <silent><tab>m :SignatureToggleSigns<cr>

	command! -nargs=0 SignatureToggleNext call signature#mark#Toggle('next')
	command! -nargs=0 SignatureToggleAtLine call signature#mark#ToggleAtLine()
	command! -nargs=0 SignaturePurgeLine call signature#mark#Purge('line')
	command! -nargs=0 SignaturePurgeAll call signature#mark#Purge('all')

	nnoremap <silent><space><space> :SignatureToggleAtLine<cr>
	vnoremap <silent><space><space> :SignatureToggleAtLine<cr>
	nnoremap <silent><backspace><space> :SignaturePurgeAll<cr>
	vnoremap <silent><backspace><space> :SignaturePurgeAll<cr>

endif


"-------------------------------------------------------------------------------
" easymotion/vim-easymotion
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-easymotion', 0) == 1

	" The default leader has been changed to <Leader><Leader> to avoid conflicts
	" with other plugins you may have installed. This can easily be changed back
	" to pre-1.3 behavior by rebinding the leader in your vimrc:
	"nnoremap <leader> <Plug>(easymotion-prefix)
	" All motions will then be triggered with <Leader> by default,
	" e.g. <Leader>s, <Leader>gE.

	"""" New feature in version 3.0
	" <Leader>f{char} to move to {char}
	"noremap <leader>f <Plug>(easymotion-bd-f)
	"nnoremap <leader>f <Plug>(easymotion-overwin-f)

	" s{char}{char} to move to {char}{char}
	"noremap s <Plug>(easymotion-overwin-f2)

	" Move to line
	"noremap <leader>L <Plug>(easymotion-bd-jk)
	"nnoremap <leader>L <Plug>(easymotion-overwin-line)

	" Move to word
	"noremap <leader>w <Plug>(easymotion-bd-w)
	"nnoremap <leader>w <Plug>(easymotion-overwin-w)

	"""" New feature in version 2.0
	"nnoremap s <Plug>(easymotion-s2)
	"nnoremap t <Plug>(easymotion-t2)

	"noremap / <Plug>(easymotion-sn)
	"onoremap / <Plug>(easymotion-tn)

	" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
	" Without these mappings, `n` & `N` works fine. (These mappings just provide
	" different highlight method and have some other features )
	"noremap n <Plug>(easymotion-next)
	"noremap N <Plug>(easymotion-prev)

	"""" Smartcase & Smartsign
	" This setting makes EasyMotion work similarly to Vim's smartcase option for global searches.
	"let g:EasyMotion_smartcase = 1
	"let g:EasyMotion_use_smartsign_us = 1 " US layout

	"Migemo feature (for Japanese user)
	"let g:EasyMotion_use_smartsign_jp = 1 " JP layout
	"let g:EasyMotion_use_migemo = 1

	"""" Minimal Configuration
	" Disable default mappings
	let g:EasyMotion_do_mapping = 0

	" Jump to anywhere you want with minimal keystrokes, with just one key binding.
	" `s{char}{label}`
	"nmap s <Plug>(easymotion-overwin-f)
	" or
	" `s{char}{char}{label}`
	" Need one more keystroke, but on average, it may be more comfortable.
	nnoremap s <Plug>(easymotion-overwin-f2)

	" Turn on case-insensitive feature
	let g:EasyMotion_smartcase = 1

	" JK motions: Line motions
	"map <leader>j <Plug>(easymotion-j)
	"map <leader>k <Plug>(easymotion-k)

endif


"-------------------------------------------------------------------------------
" kshenoy/vim-sneak
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-sneak', 0) == 1

	" enable label and jump
	let g:sneak#label = 1

	"replace f with Sneak
	"map f <Plug>Sneak_s
	"map F <Plug>Sneak_S

	"replace f and/or t with one-character Sneak
	"map f <Plug>Sneak_f
	"map F <Plug>Sneak_F
	"map t <Plug>Sneak_t
	"map T <Plug>Sneak_T

endif


"-------------------------------------------------------------------------------
" mg979/vim-visual-multi
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-visual-multi', 0) == 1

	let g:VM_default_mappings = 0

	if has('gui_running')
		let g:VM_mouse_mappings = 0
	endif

	let g:VM_maps = {}
	let g:VM_leader = { 'default':',', 'visual':',', 'buffer':',', }

	let g:VM_maps['Undo'] = 'u'
	let g:VM_maps['Redo'] = '<C-r>'

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


"-------------------------------------------------------------------------------
" preservim/nerdcommenter
"-------------------------------------------------------------------------------
if get(s:plugged, 'nerdcommenter', 0) == 1

	" Create default mappings
	let g:NERDCreateDefaultMappings = 0

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 0

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 0

	" Align line-wise comment delimiters flush left instead of following code indentation
	" one of 'none', 'left', 'start', or 'both'.
	let g:NERDDefaultAlign = 'left'

	" Tells the script to always remove the extra spaces when uncommenting
	" (regardless of whether NERDSpaceDelims is set)
	let g:NERDRemoveExtraSpaces = 0

	" Tells the script whether to remove alternative comment delimiters when uncommenting
	let g:NERDRemoveAltComs = 1

	" Add your own custom formats or override the defaults
	let g:NERDCustomDelimiters = {
				\ 'gitconfig': { 'left': '#', 'leftAlt': ';', },
				\ 'gitcommit': { 'left': '#', },
				\ 'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'h': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'cc': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'cpp': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'hpp': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'python': { 'left': '#', 'leftAlt': "'''", 'rightAlt': "'''", },
				\ 'php': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'lua': { 'left': '--', 'leftAlt': '--[[', 'rightAlt': ']]--', },
				\ 'javascript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'css': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'xml': { 'left': "<--", 'right': "-->"},
				\ 'html': { 'left': "<--", 'right': "-->"},
				\ 'ini': { 'left': '#', 'leftAlt': '"', },
				\ 'conf': { 'left': '#', },
				\ 'yaml': { 'left': '#', },
				\ 'json': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', },
				\ 'toml': { 'left': '#', },
				\ }

	" Set a language to use its alternate delimiters by default
	let g:NERDAltDelims_gitconfig = 0
	let g:NERDAltDelims_gitcommit = 0
	let g:NERDAltDelims_c = 0
	let g:NERDAltDelims_h = 0
	let g:NERDAltDelims_cc = 0
	let g:NERDAltDelims_cpp = 0
	let g:NERDAltDelims_hpp = 0
	let g:NERDAltDelims_python = 0
	let g:NERDAltDelims_php = 0
	let g:NERDAltDelims_lua = 0
	let g:NERDAltDelims_javascript = 0
	let g:NERDAltDelims_css = 0
	let g:NERDAltDelims_xml = 0
	let g:NERDAltDelims_html = 0
	let g:NERDAltDelims_ini = 0
	let g:NERDAltDelims_conf = 0
	let g:NERDAltDelims_yaml = 0
	let g:NERDAltDelims_json = 0
	let g:NERDAltDelims_toml = 0

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not
	" When this option is set to 1, NERDCommenterToggle will check all selected line,
	" if there have oneline not be commented, then comment all lines.
	let g:NERDToggleCheckAllLines = 0

	" Comment out the current line or text selected in visual mode.
	"noremap <leader>cc <Plug>NERDCommenterComment
	noremap gcc <Plug>NERDCommenterComment

	" Same as cc but forces nesting.
	"noremap <leader>cn <Plug>NERDCommenterNested

	" Toggles the comment state of the selected line(s).
	" If the topmost selected line is commented,
	" all selected lines are uncommented and vice versa.
	"noremap <leader>c<space> <Plug>NERDCommenterToggle
	nnoremap gc <Plug>NERDCommenterToggle

	" Comments the given lines using only one set of multipart delimiters.
	"noremap <leader>cm <Plug>NERDCommenterMinimal

	"Toggles the comment state of the selected line(s) individually.
	"noremap <leader>ci <Plug>NERDCommenterInvert
	vnoremap gc <Plug>NERDCommenterInvert

	" Comments out the selected lines with a pretty block formatted layout.
	"noremap <leader>cs <Plug>NERDCommenterSexy
	noremap gbc <Plug>NERDCommenterSexy

	" Same as cc except that the commented line(s) are yanked first.
	"noremap <leader>cy <Plug>NERDCommenterYank

	" Comments the current line from the cursor to the end of line.
	"noremap <leader>c$ <Plug>NERDCommenterToEOL

	" Adds comment delimiters to the end of line and goes into insert mode between them.
	"noremap <leader>cA <Plug>NERDCommenterAppend
	noremap gcA <Plug>NERDCommenterAppend

	" Adds comment delimiters at the current cursor position and inserts between. Disabled by default.
	"<Plug>NERDCommenterInsert

	" Switches to the alternative set of delimiters.
	"noremap <leader>ca <Plug>NERDCommenterAltDelims

	" Same as |NERDCommenterComment| except that the delimiters are aligned
	" down the left side (<leader>cl) or both sides (<leader>cb).
	"noremap <leader>cl <Plug>NERDCommenterAlignLeft
	"noremap <leader>cb <Plug>NERDCommenterAlignBoth

	" Uncomments the selected line(s).
	"noremap <leader>cu <Plug>NERDCommenterUncomment

endif


"-------------------------------------------------------------------------------
" ojroques/vim-oscyank
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-oscyank', 0) == 1

	" The available options with their default values are:
	let g:oscyank_max_length = 0  " maximum length of a selection, 0 for unlimited length
	let g:oscyank_silent     = 0  " disable message on successful copy
	let g:oscyank_trim       = 0  " trim surrounding whitespaces before copy
	let g:oscyank_osc52      = "\x1b]52;c;%s\x07"  " the OSC52 format string to use

	" Automatically copy text that was yanked into the unnamed register (")
	" as well as + and " when the clipboard isn't working:
	if (!has('nvim') && !has('clipboard_working'))
		" In the event that the clipboard isn't working, it's quite likely that
		" the + and * registers will not be distinct from the unnamed register. In
		" this case, a:event.regname will always be '' (empty string). However, it
		" can be the case that `has('clipboard_working')` is false, yet `+` is
		" still distinct, so we want to check them all.
		let s:VimOSCYankPostRegisters = ['', '+', '*']
		" copy text to clipboard on both (y)ank and (d)elete
		let s:VimOSCYankOperators = ['y', 'd']
		function! s:VimOSCYankPostCallback(event)
			if index(s:VimOSCYankPostRegisters, a:event.regname) != -1
						\ && index(s:VimOSCYankOperators, a:event.operator) != -1
				call OSCYankRegister(a:event.regname)
			endif
		endfunction
		augroup VimOSCYankPost
			autocmd!
			autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
		augroup END
	endif

	" In normal mode, <leader>c is an operator that will copy the given text to the clipboard.
	"nmap <leader>c <Plug>OSCYankOperator
	nmap <leader>y <Plug>OSCYankOperator

	" In normal mode, <leader>cc will copy the current line.
	"nmap <leader>cc <leader>c_
	nmap <leader>yy <leader>y_

	" In visual mode, <leader>c will copy the current selection.
	"vmap <leader>c <Plug>OSCYankVisual
	vmap <leader>y <Plug>OSCYankVisual

endif


"===============================================================================


"-------------------------------------------------------------------------------
" skywind3000/asyncrun
"-------------------------------------------------------------------------------
if get(s:plugged, 'asyncrun.vim', 0) == 1

	" 自动打开 quickfix window 高度为 10
	let g:asyncrun_open = 15

	" 任务结束时候响铃提醒
	let g:asyncrun_bell = 1

	" 设置 F4 打开/关闭 Quickfix 窗口
	nnoremap <f4> :call asyncrun#quickfix_toggle(15)<cr>

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


"-------------------------------------------------------------------------------
" skywind3000/asynctasks
"-------------------------------------------------------------------------------
if get(s:plugged, 'asynctasks', 0) == 1
	" nothing
endif


"-------------------------------------------------------------------------------
" skywind3000/vim-terminal-help
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-terminal-help', 0) == 1

	"which key will be used to toggle terminal window, default to <m-=>.
	" NOTE: macos iterm2 need setting `Profiles`->`Keys`->`Left Option key`->`Esc+`
	let g:terminal_key = '<m-`>'

	" initialize working dir: 0 for unchanged, 1 for file path and 2 for project root.
	let g:terminal_cwd = 0

	" new terminal height, default to 10.
	let g:terminal_height = 15

	" where to open the terminal, default to rightbelow.
	let g:terminal_pos = 'rightbelow'

	" specify shell rather than default one.
	"let g:terminal_shell =

	" command to open the file in vim, default to tab drop.
	"let g:terminal_edit = 'tab drop'

	" set to term to kill term session when exiting vim.
	"let g:terminal_kill = 'term'

	" set to 0 to hide terminal buffer in the buffer list.
	let g:terminal_list = 0

	" set to 1 to set winfixheight for the terminal window.
	"let g:terminal_fixheight = 1

	"set to 1 to close window if process finished.
	"let g:terminal_close = 0

endif


"-------------------------------------------------------------------------------
" skywind3000/vim-quickui
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-quickui', 0) == 1

	" 取得本文件所在的目录
	let s:dirvim = fnamemodify(resolve(expand('<sfile>:p')), ':h')

	" 加载 quickmenu 配置文件
	execute 'source '. fnameescape(s:dirvim . '/quickui.vim')

endif


"-------------------------------------------------------------------------------
" skywind3000/vim-auto-popmenu
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-auto-popmenu', 0) == 1

	" 启用 apc 插件, 默认值: 1
	let g:apc_enable = 0
	let b:apc_enable = 0

	" 设定需要生效的文件类型，如果是 '*'' 的话，代表所有类型
	"let g:apc_enable_ft = '*'
	let g:apc_enable_ft = {
				\ 'c': 1,
				\ 'cpp': 1,
				\ 'python': 1,
				\ 'php': 1,
				\ 'vim': 1,
				\ 'lua': 1,
				\ 'markdown': 1,
				\ 'text': 1,
				\ }

	" 映射 tab 键, 默认值: 1
	"let g:apc_enable_tab = 1

	" 触发补全最小字符数, 默认值: 2
	"let g:apc_min_length = 2

	" 触发补全菜单快捷键, 默认值: '\<c-n>'
	"let g:apc_triger = '\<c-n>'
	"let b:apc_triger = '\<c-x>\<c-o>'

	" 是否启用回车键选择当前词, 默认值: 0
	"let g:apc_cr_confirm = 0

	" 忽略补全关键词列表, 默认值: []
	"let g:apc_key_ignore = []

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


"-------------------------------------------------------------------------------
" skywind3000/vim-dict
"-------------------------------------------------------------------------------
if get(s:plugged, 'vim-dict', 0) == 1

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


