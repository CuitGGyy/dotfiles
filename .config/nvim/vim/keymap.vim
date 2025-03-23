"==============================================================================
"
" keymap.vim - 按键功能绑定映射
"
" 详细说明参考: https://yianwillis.github.io/vimcdoc/doc/map.html
" 依赖终端或系统的键码识别, 可结合键盘键位布局及键码识别情况予以修改
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2025/03/24 01:45:09
"
"==============================================================================


"------------------------------------------------------------------------------
"
"	有七种映射存在
"	- 用于普通模式: 输入命令时。
"	- 用于可视模式: 可视区域高亮并输入命令时。
"	- 用于选择模式: 类似于可视模式，但键入的字符对选择区进行替换。
"	- 用于操作符等待模式: 操作符等待中 ("d"，"y"，"c" 等等之后)。
"	- 用于插入模式: 也用于替换模式。
"	- 用于命令行模式: 输入 ":" 或 "/" 命令时。
"	- 用于终端模式: 在  :terminal  缓冲区里输入时。
"
"	特殊情况: 当在普通模式里为一个命令输入一个计数时，对 0 的映射会被禁用。这样在
"	输入一个带有 0 的计数时不会受到对 0 键映射的干扰。
"
"
"	关于每个映射命令对应的工作模式的概况。详情见下。
"		命 令                       模 式
"	:map   :noremap  :unmap     普通、可视、选择、操作符等待
"	:nmap  :nnoremap :nunmap    普通
"	:vmap  :vnoremap :vunmap    可视与选择
"	:smap  :snoremap :sunmap    选择
"	:xmap  :xnoremap :xunmap    可视
"	:omap  :onoremap :ounmap    操作符等待
"	:map!  :noremap! :unmap!    插入与命令行
"	:imap  :inoremap :iunmap    插入
"	:lmap  :lnoremap :lunmap    插入、命令行、Lang-Arg
"	:cmap  :cnoremap :cunmap    命令行
"	:tmap  :tnoremap :tunmap    终端作业
"
"
"	同样的信息用表格总结一下:
"															map-table
"			模式   | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
"	命令           +------+-----+-----+-----+-----+-----+------+------+
"	[nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
"	n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
"	[nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
"	i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
"	c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
"	v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
"	x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
"	s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
"	o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
"	t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
"	l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
"
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
" 设定 Vim 的 <leader> 键位
"------------------------------------------------------------------------------
let mapleader="\\"
let g:mapleader="\\"


"------------------------------------------------------------------------------
" Vim 常用功能键位
"------------------------------------------------------------------------------

" 快速保存
noremap <silent> <leader>w :write<cr>
" sudo 权限快速保存
"noremap <silent> <leader>W :write !sudo tee % > /dev/null

" 快速退出
noremap <silent> <leader>q :quit<cr>
" 全部保存并彻底退出
noremap <silent> <leader>Q :quit!<cr>
"noremap <silent> <leader>Q :confirm quitall<cr>

" 选择全部
noremap <leader>V ggvG

" 关闭高亮显示
noremap <silent> <leader><space> :nohl<cr>

" 当文件编码格式错乱时, 去除格式文件中的`^M`特殊字符
noremap <leader>M mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm

" `PASTE`粘贴模式开关键位
noremap <silent> <leader>p :set invpaste<cr>
" 离开`INSERT`模式自动关闭`PASTE`粘贴模式
autocmd InsertLeave * set nopaste

" <Shift>+<Insert>粘贴系统剪贴板内容
noremap <silent> <s-insert> "+gp
noremap! <silent> <s-insert> "+gp

" 复制到X11主选择区(primary selection)
"noremap <silent> <leader>y "*y
" 复制到系统剪贴板(clipboard)
"noremap <silent> <leader>y "+y

" `瘟到死`系统祖传默认键位
"noremap <silent> <c-c> "+y
"noremap! <silent> <c-c> "+y
"noremap <silent> <c-v> "+gp
"noremap! <silent> <c-v> "+gp


"------------------------------------------------------------------------------
" NORMAL, VISUAL, SELECT, OPERATOR-PENDING 模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
noremap <silent> <c-k> <up>
noremap <silent> <c-j> <down>
noremap <silent> <c-h> <left>
noremap <silent> <c-l> <right>
noremap <silent> <c-a> <home>
noremap <silent> <c-e> <end>
noremap <silent> <c-d> <del>


"------------------------------------------------------------------------------
" INSERT, COMMAND 模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
noremap! <silent> <c-k> <up>
noremap! <silent> <c-j> <down>
noremap! <silent> <c-h> <left>
noremap! <silent> <c-l> <right>
noremap! <silent> <c-a> <home>
noremap! <silent> <c-e> <end>
noremap! <silent> <c-d> <del>


"------------------------------------------------------------------------------
" TERMINAL 模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
tnoremap <silent> <c-k> <up>
tnoremap <silent> <c-j> <down>
tnoremap <silent> <c-h> <left>
tnoremap <silent> <c-l> <right>
tnoremap <silent> <c-a> <home>
tnoremap <silent> <c-e> <end>
tnoremap <silent> <c-d> <del>


"------------------------------------------------------------------------------
" VISUAL 模式下搜索选定内容及连续缩进
"------------------------------------------------------------------------------

" 7.4 版本之前的视图模式选定内容搜索功能
" 7.4 版本之后已经默认支持该功能
if v:version < 740
	" `COMMAND`模式执行命令字符串
	function! CmdLine(str)
		call feedkeys(":" . a:str)
	endfunction
	"`VISUAL`模式获取选定内容
	function! VisualSelection(direction, extra_filter) range
		let l:saved_reg = @"
		execute "normal! vgvy"

		let l:pattern = escape(@", "\\/.*'$^~[]")
		let l:pattern = substitute(l:pattern, "\n$", "", "")

		if a:direction == 'gv'
			call CmdLine("Ack '" . l:pattern . "' " )
		elseif a:direction == 'replace'
			call CmdLine("%s" . '/'. l:pattern . '/')
		endif

		let @/ = l:pattern
		let @" = l:saved_reg
	endfunction
	"`VISUAL`模式按下`*`或`#`键,`搜索当前选定内容
	vnoremap <silent> * :<c-v>call VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>
	vnoremap <silent> # :<c-v>call VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>
endif

"`VISUAL`模式按下`<`或`>`键缩进后保持选定可连续缩进
vnoremap <silent> < <gv
vnoremap <silent> > >gv

"`NORMAL`模式按下一次`<`或`>`键即可单行左右缩进一次
nnoremap <silent> < <<
nnoremap <silent> > >>


"------------------------------------------------------------------------------
" <leader>+数字键 切换[Tab]标签页
"------------------------------------------------------------------------------
noremap <silent> <leader>1 1gt<cr>
noremap <silent> <leader>2 2gt<cr>
noremap <silent> <leader>3 3gt<cr>
noremap <silent> <leader>4 4gt<cr>
noremap <silent> <leader>5 5gt<cr>
noremap <silent> <leader>6 6gt<cr>
noremap <silent> <leader>7 7gt<cr>
noremap <silent> <leader>8 8gt<cr>
noremap <silent> <leader>9 9gt<cr>
noremap <silent> <leader>0 10gt<cr>


"------------------------------------------------------------------------------
" <Tab>+数字键 切换[Tab]标签页
" 所有[Tab]标签页功能触发前导键位全部设定为<Tab>键
"------------------------------------------------------------------------------
noremap <silent> <tab>1 1gt<cr>
noremap <silent> <tab>2 2gt<cr>
noremap <silent> <tab>3 3gt<cr>
noremap <silent> <tab>4 4gt<cr>
noremap <silent> <tab>5 5gt<cr>
noremap <silent> <tab>6 6gt<cr>
noremap <silent> <tab>7 7gt<cr>
noremap <silent> <tab>8 8gt<cr>
noremap <silent> <tab>9 9gt<cr>
noremap <silent> <tab>0 10gt<cr>


"------------------------------------------------------------------------------
" [Tab]标签页: 创建, 关闭, 上一个, 下一个, 左移, 右移
" 其实还可以用原生的<Ctrl>+<PgUp>, <Ctrl>+<PgDn>来切换标签
"------------------------------------------------------------------------------
noremap <silent> <tab>n :tabnew<cr>
noremap <silent> <tab>c :tabclose<cr>
noremap <silent> <tab><insert> :tabnew<cr>
noremap <silent> <tab><delete> :tabclose<cr>

" 在一个新[Tab]标签页打开内嵌终端
noremap <silent> <tab>t :tab terminal<cr>

" 仅保留当前标签页，关闭其他所有标签页
noremap <silent> <tab>o :tabonly<cr>

" 用标签页显示所有缓冲区
noremap <silent> <tab>s :tab sball<cr>

" 在一个新标签页打开内嵌终端
noremap <silent> <tab>t :tab terminal<cr>

" 在当前路径下以新标签页打开文件
noremap <tab>e :tabedit <c-r>=expand('%:p:h')<cr>/
" 返回家目录以新标签页打开文件
noremap <tab>E :tabedit <c-r>=expand('~')<cr>/

" 所有标签页循环显示
noremap <silent> <tab>] :tabnext<cr>
noremap <silent> <tab>[ :tabprevious<cr>

" 7.0 版本之前的标签左右移动功能
if v:version < 700
	" 左移标签页
	function! Tab_MoveLeft()
		let l:tabnr = tabpagenr() - 2
		if l:tabnr >= 0
			exec 'tabmove '.l:tabnr
		endif
	endfunc
	noremap <silent> <tab><tab>[ :call Tab_MoveLeft()<cr>
	" 右移标签页
	function! Tab_MoveRight()
		let l:tabnr = tabpagenr() + 1
		if l:tabnr <= tabpagenr('$')
			exec 'tabmove '.l:tabnr
		endif
	endfunc
	noremap <silent> <tab><tab>] :call Tab_MoveRight()<cr>
" 7.0 版本之后支持的标签左右移动功能
else
	" 左移标签页
	noremap <silent> <tab><tab>[ :-tabmove<cr>
	" 右移标签页
	noremap <silent> <tab><tab>] :+tabmove<cr>
endif

" 当前标签页与上一个标签页之间两者循环切换
augroup last_tab
	autocmd!
	autocmd TabLeave * let g:last_tab = tabpagenr()
	if !exists('g:last_tab')
		let g:last_tab = tabpagenr()
	endif
	noremap <silent> <s-tab> :execute 'tabnext '.g:last_tab<cr>
augroup end


"------------------------------------------------------------------------------
" 缓冲区及分割窗口: 创建, 删除, 下一个, 上一个, 左移, 右移
"------------------------------------------------------------------------------
" 查看寄存器列表
noremap <silent> <leader>lr :register<cr>

" 查看缓冲区列表
noremap <silent> <leader>ls :buffers<cr>
" 打开缓冲区
noremap <leader><leader>b :buffers<cr>:buffer

" 在当前路径下以当前缓冲区打开文件
noremap <leader>e :edit <c-r>=expand('%:p:h')<cr>/
" 当前缓冲区返回家目录打开文件
noremap <leader>E :edit <c-r>=expand('~')<cr>/

" 横向等距分割当前窗口
noremap <silent> <leader>sp :split<cr>:blast<cr>
" 纵向等距分割当前窗口
noremap <silent> <leader>vs :vsplit<cr>:blast<cr>

" 横向等距分割窗口显示所有缓冲区
noremap <silent> <leader>ba :ball<cr>
" 纵向等距分割窗口显示所有缓冲区
noremap <silent> <leader>bv :vertical ball<cr>

" 跳转到下一个已被修改的缓冲区
noremap <silent> <leader>bm :bmodified<cr>

" 当前窗口删除当前缓冲区
noremap <silent> <leader>bd :bdelete!<cr>

" 当前窗口切换缓冲区
noremap <silent> <leader>b] :bnext<cr>
noremap <silent> <leader>b[ :bprevious<cr>

" 在当前缓冲区与上一个缓冲区之间循环切换
augroup last_buf
	autocmd!
	autocmd BufLeave * let g:last_buf = bufnr('$')
	if !exists('g:last_buf')
		let g:last_buf = bufnr('$')
	endif
	noremap <leader>bb :execute 'buffer '.g:last_buf<cr>
augroup end


"------------------------------------------------------------------------------
" 内嵌终端分割窗口
"------------------------------------------------------------------------------
" 在右侧分割窗口打开终端
"noremap <m-`> :leftabove terminal<cr>
" 在右下分割窗口打开终端
noremap <m-\> :rightbelow terminal<cr>


"------------------------------------------------------------------------------
" 快速修复列表
"------------------------------------------------------------------------------
" 遍历所有窗口检查 quickfix 列表缓冲区是否存在
function! IsQuickfixOpen()
	for win in range(1, winnr('$'))
		let buf = winbufnr(win)
		if getbufvar(buf, '&buftype') == 'quickfix'
			return v:true
		endif
	endfor
	return v:false
endfunction
function! ToggleQuickfix(command)
	if IsQuickfixOpen()
		cclose
	else
		execute a:command
	endif
endfunction

" 映射 <tab>q 切换 Quickfix 窗口
noremap <silent> <tab>q :call ToggleQuickfix('copen 15')<cr>
if has('nvim')
	" 映射 <tab>q 切换 Quickfix 窗口
	noremap <silent> <f4> :call ToggleQuickfix('cwindow 15')<cr>
endif


"------------------------------------------------------------------------------
" 窗口切换: <Ctrl>+hjkl
" 分割窗口缓冲区的光标移动键位
"------------------------------------------------------------------------------
noremap <silent> <c-k> <c-w>k
noremap <silent> <c-j> <c-w>j
noremap <silent> <c-h> <c-w>h
noremap <silent> <c-l> <c-w>l
noremap <silent> <c-,> <c-w>p
noremap! <silent> <c-k> <esc><c-w>k
noremap! <silent> <c-j> <esc><c-w>j
noremap! <silent> <c-h> <esc><c-w>h
noremap! <silent> <c-l> <esc><c-w>l
noremap! <silent> <c-,> <esc><c-w>p


"------------------------------------------------------------------------------
" 窗口切换: <Tab>+`hjkl`, <Tab>+`上下左右`
" 分割窗口缓冲区的光标移动键位
"------------------------------------------------------------------------------
" <Tab>+`hjkl` 窗口之间移动光标
noremap <silent> <tab>h <c-w>h
noremap <silent> <tab>j <c-w>j
noremap <silent> <tab>k <c-w>k
noremap <silent> <tab>l <c-w>l
noremap <silent> <tab>, <c-w>p

" <Tab>+`上下左右` 窗口之间移动光标
noremap <silent> <tab><left> <c-w>h
noremap <silent> <tab><down> <c-w>j
noremap <silent> <tab><up> <c-w>k
noremap <silent> <tab><right> <c-w>l
noremap <silent> <tab><backspace> <c-w>p


"------------------------------------------------------------------------------
" `TERMINAL`内嵌终端窗口切换
"------------------------------------------------------------------------------
" 终端窗口功能键
if !has('nvim') && v:version > 740
	set termwinkey=<c-w>
endif

" 终端窗口切换
tnoremap <silent> <tab><left> <c-\><c-n><c-w>h
tnoremap <silent> <tab><down> <c-\><c-n><c-w>j
tnoremap <silent> <tab><up> <c-\><c-n><c-w>k
tnoremap <silent> <tab><right> <c-\><c-n><c-w>l
tnoremap <silent> <tab><backspace> <c-\><c-n><c-w>p

" 脱离终端插入编辑(INSERT)进入终端选择视图(VISUAL)
tnoremap <silent> <tab><leader> <c-\><c-n>


"------------------------------------------------------------------------------
" diff 文件对比
"------------------------------------------------------------------------------
noremap <silent> <leader>do :DiffOrig<cr>
noremap <silent> <leader>dq :diffoff!<cr>
noremap <silent> <leader>dt :diffthis<cr>
noremap <silent> <leader>du :diffupdate<cr>
noremap <leader>ds :vertical diffsplit <c-r>=expand('%:p:h')<cr>/
noremap <leader>dp :vertical diffpatch <c-r>=expand('%:p:h')<cr>/


"------------------------------------------------------------------------------
" netrw 文件浏览器
"------------------------------------------------------------------------------
noremap <silent> <m-e> :Lexplore<cr>
noremap! <silent> <m-e> :Lexplore<cr>


"------------------------------------------------------------------------------
" spell 拼写检查
"------------------------------------------------------------------------------
"noremap <leader>zs :setlocal spell spelllang=en_us<cr>


