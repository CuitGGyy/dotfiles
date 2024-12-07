"==============================================================================
"
" config.vim - 功能扩展配置
"
" 自定义命令或函数, 无插件或外部依赖
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2024/12/07 18:34:45
"
"==============================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" 终端下功能键终端码矫正
"----------------------------------------------------------------------
function! s:key_escape(name, code)
	if has('nvim') == 0 && has('gui_running') == 0
		exec "set ".a:name."=\e".a:code
	endif
endfunction

call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')


"------------------------------------------------------------------------------
" 当前目录包含 .tags 或 tags 文件
" 或者当前文件所在目录向上级目录搜索直到碰到 .tags 或 tags 文件
" 或者 $XDG_CACHE_HOME/tags 目录下包含 tagfile 文件
"------------------------------------------------------------------------------
set tags=./.tags,./tags,.tags,tags,$XDG_CACHE_HOME/tags/tagfile


"------------------------------------------------------------------------------
" 离开 INSERT 插入模式自动关闭 PASTE 粘贴模式
"------------------------------------------------------------------------------
autocmd InsertLeave * set nopaste


"------------------------------------------------------------------------------
" 打开文件后自动恢复上一次退出前光标所在位置
"------------------------------------------------------------------------------
autocmd BufReadPost,FileReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line("$") |
			\	execute "normal! g'\"" | execute "normal! z." |
			\ endif


"------------------------------------------------------------------------------
" 如果最后一个窗口不可编辑就自动退出
"------------------------------------------------------------------------------
autocmd BufEnter *
	\ if 0 == len(filter(
	\	range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))'
	\	)) | quitall! |
	\ endif


"------------------------------------------------------------------------------
" 自动显示相对行号或绝对行号
"------------------------------------------------------------------------------

" 仅在当前在窗口非插入模式下自动显示相对行号, 其他情况均显示绝对行号
augroup AutoRelativeNumber
	autocmd!
	autocmd TabEnter,BufEnter,FocusGained,InsertLeave,WinEnter *
				\ if &number && mode() != "i"
				\ | set relativenumber |
				\ endif
	autocmd TabLeave,BufLeave,FocusLost,InsertEnter,WinLeave *
				\ if &number
				\ | set norelativenumber |
				\ endif
augroup END


"------------------------------------------------------------------------------
" 终端设置, 隐藏行号和侧边栏
"------------------------------------------------------------------------------
if has('terminal') && exists(':terminal') == 2
	if exists('##TerminalOpen')
		augroup VimTerminalGroup
			autocmd!
			autocmd TerminalOpen * setlocal nonumber signcolumn=no
			autocmd TerminalOpen * execute 'normal! i'
		augroup END
	endif
elseif has('nvim') && exists(':terminal') == 2
	augroup NvimTerminalGroup
		autocmd!
		autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
		autocmd TermOpen * startinsert
		autocmd TermClose * bdelete %
	augroup END
endif


"------------------------------------------------------------------------------
" quickfix 设置, 隐藏行号
"------------------------------------------------------------------------------
augroup QuickFixStyle
	autocmd!
	autocmd FileType qf setlocal nonumber
augroup END


"------------------------------------------------------------------------------
" 保存文件之前自动去除行尾多余空格
"------------------------------------------------------------------------------
function! StripTrailSpaces()
	let save_cursor = getpos('.')
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
command StripTrailSpaces call StripTrailSpaces()
if has('autocmd')
	autocmd BufWritePre,FileWritePre *.txt,*.vim,*.md,*.js,*.py,*.sh :StripTrailSpaces
endif


"------------------------------------------------------------------------------
" 自动修改文件的最后修改时间
"------------------------------------------------------------------------------
function! LastModifiedDatetime(headline)
	if line("$") > a:headline
		let l = a:headline
	else
		let l = line("$")
	endif
	if search("Last\ Modified:", 'nw')
		" 光标跳转到文件头部进行查找替换
		silent execute '1,' . l . 'g/[Ll]ast [Mm]odified: /s/[Ll]ast [Mm]odified: .*/Last Modified: ' . strftime('%Y\/%m\/%d %H:%M:%S')
		" 光标跳转回查找替换之前所在位置;
		" 保持光标停留在当前行, 并重新定位当前窗口, 使窗口中部显示光标所在行
		silent execute "normal! g''" | execute "normal! z."
	endif
	if search("Last-Modified:", 'nw')
		" 光标跳转到文件头部进行查找替换
		silent execute '1,' . l . 'g/[Ll]ast-[Mm]odified: /s/[Ll]ast-[Mm]odified: .*/Last-Modified: ' . strftime('%Y\/%m\/%d %H:%M:%S')
		" 光标跳转回查找替换之前所在位置;
		" 保持光标停留在当前行, 并重新定位当前窗口, 使窗口中部显示光标所在行
		silent execute "normal! g''" | execute "normal! z."
	endif
endfunction
command -nargs=1 LastModifiedDatetime call LastModifiedDatetime(<f-args>)
if has('autocmd')
	autocmd BufWritePre,FileWritePre *.vim :LastModifiedDatetime 15
	autocmd BufWritePre,FileWritePre *.py :LastModifiedDatetime 15
endif


"------------------------------------------------------------------------------
" 定义 DiffOrig 命令用于对比查看文件改动
"------------------------------------------------------------------------------
if !exists(":DiffOrig")
	command DiffOrig vert new | set buftype=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif


"----------------------------------------------------------------------
" tabline 标签栏文字显示风格配置
"----------------------------------------------------------------------
" 标签栏风格
" 0: 不显示标签编号, 仅显示标签名称
" 1: 显示标签编号和标签名称
let g:tablabel_number_style = 1

" 当显示标签编号时, 标签编号左右两侧修饰符
let g:tablabel_padding_left = ''
let g:tablabel_padding_right = ''

" 终端下显示的 tabline 标签栏
function! Vim_NeatTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XXclose'
	endif

	return s
endfunction

" 需要显示到 tabline 标签栏上的 buffer 缓冲区名称
function! Vim_NeatBuffer(bufnr, fullname)
	let name = bufname(a:bufnr)
	let bt = getbufvar(a:bufnr, '&buftype')
	let xname = getbufvar(a:bufnr, '__asc_bufname', '')
	if xname != ''
		return xname
	endif
	if getbufvar(a:bufnr, '&modifiable')
		if name == ''
			return '[No Name]'
		elseif bt == 'terminal'
			return '[Terminal]'
		else
			if a:fullname
				return fnamemodify(name, ':p')
			else
				let aname = fnamemodify(name, ':p')
				let sname = fnamemodify(aname, ':t')
				if sname == ''
					let test = fnamemodify(aname, ':h:t')
					if test != ''
						return '<'. test . '>'
					endif
				endif
				return sname
			endif
		endif
	else
		let bt = getbufvar(a:bufnr, '&buftype')
		if bt == 'quickfix'
			return '[Quickfix]'
		elseif bt == 'terminal'
			return '[Terminal]'
		elseif name != ''
			if a:fullname
				return '-'.fnamemodify(name, ':p')
			else
				return '-'.fnamemodify(name, ':t')
			endif
		else
		endif
		return '[No Name]'
	endif
endfunction

" tabline 标签栏 buffer 缓冲区名称的显示形式
function! Vim_NeatTabLabel(n)
	let l:buflist = tabpagebuflist(a:n)
	let l:winnr = tabpagewinnr(a:n)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)
	let l:buftype = getbufvar(l:bufnr, '&buftype')
	let l:num = a:n
	if getbufvar(l:bufnr, '&modified')
		if g:tablabel_number_style == 0
			return '+'.l:fname
		else
			return g:tablabel_padding_left.l:num.g:tablabel_padding_right.' '.l:fname.' +'
		endif
	else
		if g:tablabel_number_style == 0
			return ''.l:fname
		else
			return g:tablabel_padding_left.l:num.g:tablabel_padding_right.' '.l:fname
		endif
	endif
endfunction

" GUI 下的 tabline 标签栏 buffer 缓冲区名称的显示形式
function! Vim_NeatGuiTabLabel()
	let l:num = v:lnum
	let l:buflist = tabpagebuflist(l:num)
	let l:winnr = tabpagewinnr(l:num)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)

	if getbufvar(l:bufnr, '&modified')
		if g:tablabel_number_style == 0
			return '+'.l:fname
		else
			return g:tablabel_padding_left.l:num.g:tablabel_padding_right.' '.l:fname.' +'
		endif
	else
		if g:tablabel_number_style == 0
			return ''.l:fname
		else
			return g:tablabel_padding_left.l:num.g:tablabel_padding_right.' '.l:fname
		endif
	endif
endfunction

" 设置 GUI 下的 tabline 标签栏提示: 显示当前标签有哪些窗口
function! Vim_NeatGuiTabTip()
	let tip = ''
	let bufnrlist = tabpagebuflist(v:lnum)
	for bufnr in bufnrlist
		" separate buffer entries
		if tip != ''
			let tip .= " \n"
		endif
		" Add name of buffer
		let name = Vim_NeatBuffer(bufnr, 1)
		let tip .= name
		" add modified/modifiable flags
		if getbufvar(bufnr, "&modified")
			let tip .= ' [+]'
		endif
		if getbufvar(bufnr, "&modifiable")==0
			let tip .= ' [-]'
		endif
	endfor
	return tip
endfunction

" 标签栏最终设置, 在 macvim 下是 %M%t
set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}
set guitabtooltip=%{Vim_NeatGuiTabTip()}


"------------------------------------------------------------------------------
" netrw 参数设置
"------------------------------------------------------------------------------
" 历史记录存储路径
if $XDG_CONFIG_HOME != ''
	let g:netrw_home = $XDG_CACHE_HOME
else
	let g:netrw_home = '~/.cache/'
endif

" 历史记录最大数量
let g:netrw_dirhistmax = 10

" 显示横幅
let g:netrw_banner = 1

" additional splitting control:
"g:netrw_preview	g:netrw_alto	result
"		0				0			|:aboveleft|
"		0				1			|:belowright|
"		1				0			|:topleft|
"		1				1			|:botright|
" 窗口分割方式，与 g:netrw_alto 共同作用
let g:netrw_preview = 0
" 窗口显示位置，与 g:netrw_preview 共同作用
let g:netrw_alto = 0

" 设置目录列表样式为树形
let g:netrw_liststyle = 3

" 设置文件浏览器宽度百分比
let g:netrw_winsize = 30

" 排序依据
let g:netrw_sort_by = 'time'
" 排序选项
"let g:netrw_sort_options = 'i'
" 排序方向
let g:netrw_sort_direction = 'reverse'

" 默认的删除工具使用 trash
let g:netrw_localrmdir = 'trash'

" 打开文件使用窗口方式
" 1 - 用水平拆分窗口打开文件
" 2 - 用垂直拆分窗口打开文件
" 3 - 新建标签页打开文件
" 4 - 用前一个窗口打开文件
let g:netrw_browse_split = 4


"------------------------------------------------------------------------------
" 色彩主题样式配置
"------------------------------------------------------------------------------
" 调整旧版默认主题样式
if has('nvim') == 0 && v:version < 800
	" 更清晰的错误标注：默认一片红色背景, 语法高亮都被搞没了
	" 只显示红色或者蓝色下划线或者波浪线
	highlight clear SpellBad
	highlight clear SpellCap
	highlight clear SpellRare
	highlight clear SpellLocal
	if has('gui_running')
		highlight SpellBad gui=undercurl guisp=red
		highlight SpellCap gui=undercurl guisp=blue
		highlight SpellRare gui=undercurl guisp=magenta
		highlight SpellLocal gui=undercurl guisp=cyan
	else
		highlight SpellBad term=standout cterm=underline
		highlight SpellCap term=underline cterm=underline
		highlight SpellRare term=underline cterm=underline
		highlight SpellLocal term=underline cterm=underline
	endif

	" 调整默认主题光标当前所在行配色
	highlight CursorLine
				\ term=underline cterm=underline ctermfg=NONE ctermbg=NONE
				\ gui=underline guifg=NONE guibg=NONE
	autocmd InsertEnter * highlight CursorLine
				\ term=bold cterm=bold ctermfg=NONE ctermbg=NONE
				\ gui=bold guifg=NONE guibg=NONE
	autocmd InsertLeave * highlight CursorLine
				\ term=underline cterm=underline ctermfg=NONE ctermbg=NONE
				\ gui=underline guifg=NONE guibg=NONE
endif


" 去掉 sign column 的白色背景
highlight SignColumn ctermbg=NONE guibg=NONE

" 修改行号为浅灰色, 默认主题的黄色行号很难看, 换主题可以仿照修改
highlight LineNr
			\ term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
			\ gui=NONE guifg=DarkGrey guibg=NONE


" 设置配色主题, 会在所有 runtimepaths 的 colors 目录寻找同名配置
try
	" 复刻 vscode
	colorscheme codedark
	" 复刻 monokai
	"colorscheme molokai
	" 复刻 xcode
	"colorscheme xcodedarkhc
catch
	" 系统自带主题
	colorscheme habamax
endtry


"------------------------------------------------------------------------------
" GUI 界面字体参数及色彩主题样式配置
"------------------------------------------------------------------------------

if has('gui_running')
	" 包含工具栏, 仅支持Win32, GTK+, Motif, Photon, MacVim
	set guioptions-=T

	" 添加Tab页, 仅支持GTK, Motif, MacOS/X, Haiku, MS-Windows
	set guioptions-=e

	" 根据操作系统设置显示字体
	if has('mac') || has('macunix') || has('darwin')
		set guifont=Monaco:h14,SF\ Mono:h14,Microsoft\ YaHei:14
		" 开启字体平滑抗锯齿
		set antialias
	elseif has('win64') || has('win32') || has('win16')
		set guifont=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
	elseif has('gui_gtk2')
		set guifont=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
	elseif has('linux')
		set guifont=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
	elseif has('unix')
		set guifont=Monospace\ 12
	endif

endif

