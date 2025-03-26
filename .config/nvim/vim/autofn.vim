"===============================================================================
"
" autofn.vim - 自定义配置或自动化功能扩展
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2025/03/26 10:54:20
"
"===============================================================================


"-------------------------------------------------------------------------------
" 键盘功能按键输入键码修正
"-------------------------------------------------------------------------------
" 若按键键码存在问题, 可分别在终端模拟器, inputrc环境变量, 还有这里予以修复
"if !has('nvim') && !has('gui_running')
"	function! s:key_escape(name, code)
"		execute 'set ' . a:name . '=\e' . a:code
"	endfunction
"
"	call s:key_escape('<s-up>', '[1;2A')
"	call s:key_escape('<c-up>', '[1;5A')
"	"call s:key_escape('<c-s-up>', '[1;6A')
"	call s:key_escape('<s-down>', '[1;2B')
"	call s:key_escape('<c-down>', '[1;5B')
"	"call s:key_escape('<c-s-down>', '[1;6B')
"	call s:key_escape('<s-left>', '[1;2D')
"	call s:key_escape('<c-left>', '[1;5D')
"	"call s:key_escape('<c-s-Left>', '[1;6D')
"	call s:key_escape('<s-right>', '[1;2C')
"	call s:key_escape('<c-right>', '[1;5C')
"	"call s:key_escape('<c-s-right>', '[1;6C')
"
"	call s:key_escape('<f1>', 'OP')
"	call s:key_escape('<f2>', 'OQ')
"	call s:key_escape('<f3>', 'OR')
"	call s:key_escape('<f4>', 'OS')
"	call s:key_escape('<s-f1>', '[1;2P')
"	call s:key_escape('<s-f2>', '[1;2Q')
"	call s:key_escape('<s-f3>', '[1;2R')
"	call s:key_escape('<s-f4>', '[1;2S')
"	call s:key_escape('<s-f5>', '[15;2~')
"	call s:key_escape('<s-f6>', '[17;2~')
"	call s:key_escape('<s-f7>', '[18;2~')
"	call s:key_escape('<s-f8>', '[19;2~')
"	call s:key_escape('<s-f9>', '[20;2~')
"	call s:key_escape('<s-f10>', '[21;2~')
"	call s:key_escape('<s-f11>', '[23;2~')
"	call s:key_escape('<s-f12>', '[24;2~')
"
"	call s:key_escape('<s-home>', '[1;2H')
"	call s:key_escape('<c-home>', '[1;5H')
"	call s:key_escape('<s-end>', '[1;2F')
"	call s:key_escape('<c-end>', '[1;5F')
"	call s:key_escape('<insert>', '[2~')
"endif


"-------------------------------------------------------------------------------
" `tags`符号索引标签文件, 默认./tags;,tags
" 详细说明参考: https://www.zhihu.com/question/47691414/answer/373700711
"
" 前半部分“./tags;”代表在文件的所在目录下 (不是“:pwd”返回的Vim当前目录),
" 查找名字为“.tags”的符号文件, 后面一个分号代表查找不到的话向上递归到父目录,
" 直到找到tags文件或者递归到了根目录还没找到. 这样对于复杂工程很友好,
" 源代码都是分布在不同子目录中, 而只需要在项目顶层目录放一个tags文件即可;
" 逗号分隔的后半部分“tags”是指同时在Vim的当前目录(“:pwd”命令返回的目录,
" 可以用“:cd ..”命令改变) 下面查找tags文件。
"-------------------------------------------------------------------------------
set tags+=./tagfile;,tagfile


"-------------------------------------------------------------------------------
" 打开文件后自动恢复上一次退出前光标所在位置
"-------------------------------------------------------------------------------
autocmd BufReadPost,FileReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line('$') |
			\	execute "normal! g'\"" | execute 'normal! z.' |
			\ endif


"-------------------------------------------------------------------------------
" 如果最后一个窗口不可编辑就自动退出
"-------------------------------------------------------------------------------
autocmd BufEnter *
	\ if 0 == len(filter(
	\	range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))'
	\	)) | quitall! |
	\ endif


"-------------------------------------------------------------------------------
" 自动显示相对行号或绝对行号
" 仅在当前窗口的非插入模式下自动显示相对行号, 其他情况均显示绝对行号
"-------------------------------------------------------------------------------
augroup LineNumberAuto
	autocmd!
	autocmd TabEnter,BufEnter,FocusGained,InsertLeave,WinEnter *
				\ if &number && mode() != 'i'
				\ | set relativenumber |
				\ endif
	autocmd TabLeave,BufLeave,FocusLost,InsertEnter,WinLeave *
				\ if &number
				\ | set norelativenumber |
				\ endif
augroup END


"-------------------------------------------------------------------------------
" 保存文件之前自动去除行尾多余空格
"-------------------------------------------------------------------------------
function! StripTrailSpaces()
	let save_cursor = getpos('.')
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
command StripTrailSpaces call StripTrailSpaces()
autocmd BufWritePre,FileWritePre * :StripTrailSpaces


"-------------------------------------------------------------------------------
" 自动修改文件的最后修改时间
"-------------------------------------------------------------------------------
function! UpdateDatetime(pattern, replacement, limit_line)
	" 保存光标位置
	let last_cursor = getpos('.')
	" 保存搜索寄存器状态
	let last_search = getreg('/')

	" 光标跳转到文件头部进行查找替换
	"silent execute '1,'.limit_line.'g/[Ll]ast [Mm]odified: /s/[Ll]ast [Mm]odified: .*/Last Modified: '.strftime('%Y\/%m\/%d %H:%M:%S')
	"silent execute '1,'.limit_line.'g/[Ll]ast-[Mm]odified: /s/[Ll]ast-[Mm]odified: .*/Last-Modified: '.strftime('%Y\/%m\/%d %H:%M:%S')
	silent execute '1,'.a:limit_line.'g/'.a:pattern.'/s/'.a:pattern.'.*/'.a:replacement.' '.strftime('%Y\/%m\/%d %H:%M:%S')

	" 光标跳转回查找替换之前所在位置
	call setpos('.', last_cursor)
	" 恢复搜索寄存器状态
	call setreg('/', last_search)
endfunction

function! LastModifiedDatetime(headline)
	let limit_line = line('$') > a:headline ? a:headline : line('$')

	" 尝试更新 "Last Modified:" 或 "Last-Modified:"
	if search('Last\ Modified:', 'nw')
		call UpdateDatetime('[Ll]ast [Mm]odified:', 'Last Modified:', limit_line)
	elseif search('Last-Modified:', 'nw')
		call UpdateDatetime('[Ll]ast-[Mm]odified:', 'Last-Modified:', limit_line)
	endif
endfunction

command -nargs=1 LastModifiedDatetime call LastModifiedDatetime(<f-args>)

autocmd BufWritePre,FileWritePre * :LastModifiedDatetime 15


"-------------------------------------------------------------------------------
" 定义`DiffOrig`命令用于对比查看文件改动
"-------------------------------------------------------------------------------
if !exists(':DiffOrig')
	command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif


"-------------------------------------------------------------------------------
" 定义 tabline 标签栏文字显示风格
"-------------------------------------------------------------------------------
" 标签栏风格
" 0: 不显示标签编号, 仅显示标签名称
" 1: 显示标签编号和标签名称
let g:tablabel_number_style = 1

" 当显示标签编号时, 标签编号左右两侧修饰符
let g:tablabel_padding_left = ''
let g:tablabel_padding_right = ''

" 需要显示到`tabline`标签栏上的`buffer`缓冲区名称
function! NeatBuffer(bufnr, fnametype)
	let l:bname = bufname(a:bufnr)
	let l:btype = getbufvar(a:bufnr, '&buftype')
	let l:aname = getbufvar(a:bufnr, '__asc_bufname', '')
	if l:aname != ''
		return l:aname
	endif
	if l:bname != ''
		if a:fnametype == 0
			return fnamemodify(l:bname, ':t')
		elseif a:fnametype == 1
			return fnamemodify(l:bname, ':p')
		elseif a:fnametype == 2
			return fnamemodify(l:bname, ':h:t')
		else
			return fnamemodify(l:bname, ':t')
		endif
	else
		return '[No Name]'
	endif
endfunction

" `tabline`标签栏`buffer`缓冲区名称的显示形式
function! NeatTabLabel(num)
	let l:buflist = tabpagebuflist(a:num)
	let l:winnr = tabpagewinnr(a:num)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = NeatBuffer(l:bufnr, 0)
	let l:buftype = getbufvar(l:bufnr, '&buftype')

	if getbufvar(l:bufnr, '&modified') && getbufvar(l:bufnr, '&readonly')
		let l:symbol = '+-'
	elseif getbufvar(l:bufnr, '&modified')
		let l:symbol = '+'
	elseif getbufvar(l:bufnr, '&readonly')
		let l:symbol = '-'
	elseif !getbufvar(l:bufnr, '&modifiable')
		let l:symbol = '='
	else
		let l:symbol = ''
	endif

	if l:symbol != '' && g:tablabel_number_style == 1
		let l:label = g:tablabel_padding_left . a:num . g:tablabel_padding_right
					\ . ' ' . l:fname . ' ' . l:symbol
	elseif l:symbol == '' && g:tablabel_number_style == 1
		let l:label = g:tablabel_padding_left . a:num . g:tablabel_padding_right
					\ . ' ' . l:fname
	else
		let l:label = l:symbol . ' ' . l:fname
	endif

	return l:label
endfunction

" GUI 下的`tabline`标签栏`buffer`缓冲区名称的显示形式
function! NeatGuiTabLabel()
	let l:buflist = tabpagebuflist(v:lnum)
	let l:winnr = tabpagewinnr(v:lnum)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = NeatBuffer(l:bufnr, 0)

	if getbufvar(l:bufnr, '&modified') && getbufvar(l:bufnr, '&readonly')
		let l:symbol = '+-'
	elseif getbufvar(l:bufnr, '&modified')
		let l:symbol = '+'
	elseif getbufvar(l:bufnr, '&readonly')
		let l:symbol = '-'
	elseif !getbufvar(l:bufnr, '&modifiable')
		let l:symbol = '='
	else
		let l:symbol = ''
	endif

	if l:symbol != '' && g:tablabel_number_style == 1
		let l:label = g:tablabel_padding_left . v:lnum . g:tablabel_padding_right
					\ . ' ' . l:fname . ' ' . l:symbol
	elseif l:symbol == '' && g:tablabel_number_style == 1
		let l:label = g:tablabel_padding_left . v:lnum . g:tablabel_padding_right
					\ . ' ' . l:fname
	else
		let l:label = l:symbol . ' ' . l:fname
	endif

	return l:label
endfunction

" 设置 GUI 下的`tabline`标签栏提示: 显示当前标签有哪些窗口
function! NeatGuiTabTip()
	let tip = ''
	let bufnrlist = tabpagebuflist(v:lnum)
	for bufnr in bufnrlist
		" separate buffer entries
		if tip != ''
			let tip .= " \n"
		endif
		" Add name of buffer
		let name = NeatBuffer(bufnr, 1)
		let tip .= name
		" add modified/modifiable flags
		if getbufvar(bufnr, '&modified')
			let tip .= ' [+]'
		endif
		if getbufvar(bufnr, '&modifiable')==0
			let tip .= ' [-]'
		endif
	endfor
	return tip
endfunction

" 终端下显示的`tabline`标签栏
function! NeatTabLine()
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
		let s .= ' %{NeatTabLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		"let s .= '%=%#TabLine#%999XXclose'
		let s .= '%=%#TabLine#%999XX '
	endif

	return s
endfunction

if &tabline == ''
	" 标签栏默认`%N\ %f`, 也可以是`%M%t`
	" 标签栏最终实现逻辑, 每次调用动态调用生成
	set tabline=%!NeatTabLine()
	set guitablabel=%!NeatGuiTabLabel()
	set guitabtooltip=%!NeatGuiTabTip()
endif


"-------------------------------------------------------------------------------
" 色彩主题样式配置
"-------------------------------------------------------------------------------
" 旧版未加载任何主题的无色风格样式的颜色定义及修正

" 透明底暗绿字
"highlight SpecialKey term=bold ctermfg=77 guifg=#5fdf5f
" 黑底亮灰字
"highlight NonTextTodo term=bold cterm=bold ctermfg=248 ctermbg=233 gui=bold guifg=#a8a8a8 guibg=#101010
" 透明底青字
"highlight Directory term=bold ctermfg=11 guifg=cyan
" 红底白字
"highlight ErrorMsg term=standout ctermfg=15 ctermbg=1 guifg=#ffffff guibg=#800000
" 黄白底黑字
"highlight IncSearch term=reverse ctermfg=0 ctermbg=223 guifg=#000000 guibg=#ffdfaf
" 绿底黑字
"highlight Search term=reverse ctermfg=0 ctermbg=149 guifg=#000000 guibg=#afdf5f
" 透明底墨绿字
"highlight MoreMsg term=bold ctermfg=10 gui=bold guifg=seagreen
" 透明底高亮字
"highlight ModeMsg term=bold cterm=bold gui=bold
" 黑底暗灰字
"highlight LineNr term=underline ctermfg=248 ctermbg=233 guifg=#a8a8a8 guibg=#101010
" 透明底亮绿字
"highlight Question term=standout ctermfg=10 gui=bold guifg=green
" 橙黄底白字
"highlight StatusLine term=bold,reverse cterm=bold ctermbg=239 gui=bold guifg=white guibg=orange
" 深灰底浅白字
"highlight StatusLineNC term=reverse ctermbg=237 guibg=#3a3a3a
" 深灰底深灰字
"highlight VertSplit term=reverse ctermfg=237 ctermbg=237 guifg=#3a3a3a guibg=#3a3a3a
" 透明底紫字
"highligh Title term=bold ctermfg=13 gui=bold guifg=magenta

"if !has('nvim') && !exists('g:colors_name')
"    " 更清晰的错误标注：默认一片红色背景, 语法高亮都被搞没了
"    " 只显示红色或者蓝色下划线或者波浪线
"    highlight clear SpellBad
"    highlight clear SpellCap
"    highlight clear SpellRare
"    highlight clear SpellLocal
"    if has('gui_running')
"        highlight SpellBad gui=undercurl guisp=red
"        highlight SpellCap gui=undercurl guisp=blue
"        highlight SpellRare gui=undercurl guisp=magenta
"        highlight SpellLocal gui=undercurl guisp=cyan
"    else
"        highlight SpellBad term=standout cterm=underline
"        highlight SpellCap term=underline cterm=underline
"        highlight SpellRare term=underline cterm=underline
"        highlight SpellLocal term=underline cterm=underline
"    endif
"
"    " 调整默认主题光标当前所在行配色
"    highlight CursorLine
"                \ term=underline cterm=underline ctermfg=NONE ctermbg=NONE
"                \ gui=underline guifg=NONE guibg=NONE
"    autocmd InsertEnter * highlight CursorLine
"                \ term=bold cterm=bold ctermfg=NONE ctermbg=NONE
"                \ gui=bold guifg=NONE guibg=NONE
"    autocmd InsertLeave * highlight CursorLine
"                \ term=underline cterm=underline ctermfg=NONE ctermbg=NONE
"                \ gui=underline guifg=NONE guibg=NONE
"
"    " 去掉 sign column 的白色背景
"    highlight SignColumn ctermbg=NONE guibg=NONE
"
"    " 修改行号为浅灰色, 默认主题的黄色行号很难看, 换主题可以仿照修改
"    highlight LineNr
"                \ term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
"                \ gui=NONE guifg=DarkGrey guibg=NONE
"endif


" 高亮显示注释中的自定义关键词
if v:version > 701
	" 自定义`Todo`,`Debug`高亮组匹配关键词
	" `\W`匹配一个非单词字符; `\zs`设置匹配的起始位置;
	" `\W\zs`从前面一个字符是非单词字符开始匹配;
	" `\v`开启魔法模式: `|`,`(`,`)`等正则特殊字符不需要转义, 可以直接使用;
	autocmd Syntax * call matchadd('NeatFixme', '\W\zs\v(FIXME|BUG):')
	autocmd Syntax * call matchadd('NeatHack', '\W\zs\v(HACK|WARN):')
	autocmd Syntax * call matchadd('NeatTodo', '\W\zs\v(TODO|XXX):')
	autocmd Syntax * call matchadd('NeatNote', '\W\zs\v(NOTE|NOTICE):')
else
	" 自定义`keyTodo`,`keyDebug`高亮组匹配关键词
	syntax match NeatFixme contained '\<\(FIXME\|BUG\):'
	syntax match NeatHack contained '\<\(HACK\|WARN\):'
	syntax match NeatTodo contained '\<\(TODO\|XXX\):'
	syntax match NeatNote contained '\<\(NOTE\|NOTICE\):'
endif
" 自定义高亮组反色显示
"highligh NeatFixme term=bold,reverse cterm=bold,reverse gui=bold,reverse
"highligh NeatHack term=bold,reverse cterm=bold,reverse gui=bold,reverse
"highligh NeatTodo term=bold,reverse cterm=bold,reverse gui=bold,reverse
"highligh NeatNote term=bold,reverse cterm=bold,reverse gui=bold,reverse
" 链接自定义高亮组配色至现有高亮组
highlight def link NeatFixme vimError
highlight def link NeatHack vimWarn
highlight def link NeatTodo vimTodo
highlight def link NeatNote vimBang


"-------------------------------------------------------------------------------
" GUI 界面字体参数及色彩主题样式配置
"-------------------------------------------------------------------------------

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


"-------------------------------------------------------------------------------
" TERMINAL 内嵌终端设置, 隐藏行号和侧边栏
"-------------------------------------------------------------------------------
augroup TerminalAuto
	autocmd!
	if has('terminal')
		autocmd TerminalOpen * setlocal nonumber norelativenumber signcolumn=no
		autocmd TerminalOpen * execute 'normal! i'
	elseif has('nvim')
		autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
		autocmd TermOpen * startinsert
	endif
augroup END


"-------------------------------------------------------------------------------
" QuickFix 快速修复列表窗口设置
"-------------------------------------------------------------------------------
augroup QuickFixAuto
	autocmd!

	" 清空 quickfix 列表
	autocmd FileType qf nnoremap <buffer><silent> dq :call setqflist([], 'r')<bar>:cclose<cr>

	" NORMAL 模式 dd 删除 quickfix 指定行
	function! RemoveQuickfixEntry(index)
		" 获取当前 quickfix 列表
		let qflist = getqflist()
		if a:index < 1 || a:index > len(qflist)
			return
		endif

		" 保存当前光标位置
		"let row = line('.')
		"let col = col('.')
		let cursor_pos = getcurpos()

		" 保存最后搜索寄存器状态
		let last_search = getreg('/')

		" 从列表中删除指定行
		call remove(qflist, a:index - 1)
		" 重新设置 quickfix 列表
		call setqflist(qflist, 'r')

		" 恢复光标位置
		"call cursor(row, col)
		call setpos('.', cursor_pos)
		" 恢复搜索寄存器状态
		call setreg('/', last_search)
	endfunction
	autocmd FileType qf nnoremap <buffer><silent> dd :call RemoveQuickfixEntry(line('.'))<cr>

	" VISUAL 模式 d 删除 quickfix 选择的行
	function! RemoveQuickfixBlock(from, to)
		" 获取当前 quickfix 列表
		let qflist = getqflist()
		let rest = []

		" 确保 from <= to
		if a:from > a:to
			let temp = a:from
			let a:from = a:to
			let a:to = temp
		endif

		" 过滤掉选中的行
		for i in range(len(qflist))
			if i + 1 < a:from || i + 1 > a:to
			call add(rest, qflist[i])
			endif
		endfor

		" 更新 quickfix 列表
		call setqflist(rest, 'r')
	endfunction
	autocmd FileType qf vnoremap <buffer><silent> d <esc>:call RemoveQuickfixBlock(line("'<"), line("'>"))<cr>
augroup END


"-------------------------------------------------------------------------------
" netrw 文件管理器选项参数
"-------------------------------------------------------------------------------
" 历史记录存储路径
if exists('$XDG_CACHE_HOME') && !empty('$XDG_CACHE_HOME')
	let g:netrw_home = expand($XDG_CACHE_HOME)
else
	let g:netrw_home = expand('~/.cache/')
endif
" 历史记录最大数量
let g:netrw_dirhistmax = 10

" 不显示横幅
let g:netrw_banner = 0

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
" 排序选项: 忽略大小写敏感
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


"-------------------------------------------------------------------------------
" 使 nvim 或 vim 支持 OSC52 控制序列码, 实现跨 ssh 复制文本
"-------------------------------------------------------------------------------
" 参考 https://www.sxrhhh.top/blog/2024/06/06/neovim-copy-anywhere/
" nvim 相关说明 :help clipboard-osc52
if exists('$SSH_TTY') || exists('$SSH_CONNECTION')
" 使用插件 https://github.com/ojroques/vim-oscyank
endif


"-------------------------------------------------------------------------------
" 操作系统的回车换行符存在差异, 导致剪贴板内容不一致
"-------------------------------------------------------------------------------
"if executable('win32yank.exe')
"  set clipboard+=unnamedplus
"  let g:clipboard = {
"        \ 'name': 'win32yank',
"        \ 'copy': {
"        \   '+': 'win32yank.exe -i --crlf',
"        \   '*': 'win32yank.exe -i --crlf',
"        \ },
"        \ 'paste': {
"        \   '+': 'win32yank.exe -o --lf',
"        \   '*': 'win32yank.exe -o --lf',
"        \ },
"        \ 'cache_enabled': 0
"        \ }
"endif


"-------------------------------------------------------------------------------
" 依据时间段自动启用不同的色彩主题样式
"-------------------------------------------------------------------------------
" 应尽早加载 colorscheme 使其他插件能正确配色
"function! UpdateColorscheme()
"	try
"		let hour = str2nr(strftime('%H'))
"		if hour > 8 && hour < 18
"			colorscheme codedark
"			"colorscheme molokai
"		else
"			colorscheme xcodedarkhc
"			"colorscheme molokai
"		endif
"	catch
"		colorscheme habamax
"	endtry
"endfunction
"" 每次进入更新主题
"autocmd VimEnter * call UpdateColorscheme()


