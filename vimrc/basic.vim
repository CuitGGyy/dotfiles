"==============================================================================
"
" basic.vim - 全局基础配置
"
" 仅用 Vim 内置命令, 无自定义命令或函数, 无许插件或外部依赖
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2023/02/21 05:59:39
"
"==============================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"------------------------------------------------------------------------------
" 交换文件, 备份撤销
"------------------------------------------------------------------------------
" 禁用兼容模式, 启用增强模式
set nocompatible

" 禁用交换文件
set noswapfile
" 交换文件刷新时延 (1000 ms)
"set updatetime=1000

" 写时备份
set writebackup

" 禁用备份
set nobackup
" 备份文件扩展名
set backupext=.bak
" 若启用备份, 则统一路径归并管理备份文件; nvim 与 vim 的备份文件格式不兼容
" 创建目录, 并且忽略可能出现的警告
if $XDG_CONFIG_HOME != ''
	set backupdir=$XDG_CACHE_HOME/temp
	silent! call mkdir(expand($XDG_CACHE_HOME.'/temp'), 'p', 0755)
else
	set backupdir=~/.cache/temp
	silent! call mkdir(expand('~/.cache/temp'), 'p', 0755)
endif

" 启用 undo 文件
set undofile
" 若启用了 undo 文件, 则统一路径归并管理 undo 文件; nvim 与 vim 的 undo 文件格式不兼容
" 创建目录, 并且忽略可能出现的警告
if $XDG_CONFIG_HOME != ''
	set undodir=$XDG_CACHE_HOME/undo
	silent! call mkdir(expand($XDG_CACHE_HOME.'/undo'), 'p', 0755)
else
	set undodir=~/.cache/undo
	silent! call mkdir(expand('~/.cache/undo'), 'p', 0755)
endif

" vim 使用文本文件 viminfo, nvim 使用二进制文件 shada
if has('nvim') == 0
	if $XDG_CACHE_HOME != ''
		set viminfo='100,<50,s10,h,n$XDG_CACHE_HOME/.viminfo
	else
		set viminfo='100,<50,s10,h,n$HOME/.cache/.viminfo
	endif
endif
" 各历史记录数量
set history=100

" 共享系统剪贴板 (兼容 X 图形界面系统)
set clipboard+=unnamed

" 自动切换目录
set autochdir
" 自动读取文件变动
set autoread

" 使用 Tab 标签页切换缓冲区（二者联动）
set switchbuf=useopen,usetab,newtab


"------------------------------------------------------------------------------
" 文件编码格式
"------------------------------------------------------------------------------
if has('multi_byte')
	" 内部工作编码
	set encoding=utf-8
	" 文件默认编码
	set fileencoding=utf-8
	" 打开文件时自动尝试下面顺序的编码
	set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,euc-jp,euc-kr,latin1
endif

" 如遇Unicode值大于255的文本, 不必等到空格再折行
set formatoptions+=m
" 合并两行中文时, 不在中间加空格
set formatoptions+=B
" 文件换行符, 默认使用 unix 换行符
set fileformats=unix,dos,mac

" unicode 双字符宽度
"set ambiwidth=double


"------------------------------------------------------------------------------
" 终端, 键鼠, 光标
"------------------------------------------------------------------------------
" 终端使用 256 色
if !has('gui_running')
	set t_Co=256
	if v:version >= 800
		set termguicolors
	endif
endif

" 防止tmux下vim的背景色显示异常
if &term =~ '256color' && $TMUX != ''
	" disable Background Color Erase (BCE)
	set t_ut=
endif

" 使终端进入termcap模式, 退出vim后终端不清理屏幕
"set t_ti=
"set t_te=

" 增强平滑刷新, 帮助复制粘贴
set ttyfast
" 打开功能键超时检测 (终端下功能键为一串 ESC 开头的字符串)
set ttimeout
" 功能键超时检测 50 毫秒
set ttimeoutlen=50
" 延迟绘制 (提升性能)
set lazyredraw

" 禁用视图模式响铃
set novisualbell
set vb t_vb=
" 禁用出现错误响铃
set noerrorbells

" Windows 禁用 ALT 操作菜单 (使得 ALT 可以用到 Vim里)
"set winaltkeys=no
" 点击鼠标动作
set mouse=a

" 设置 Backspace 键模式
set backspace=eol,start,indent
" 光标自动跳转
set whichwrap+=b,s,h,l,<,>,[,]


"------------------------------------------------------------------------------
" 交互界面显示
"------------------------------------------------------------------------------
" 界面左侧对齐间距
"set foldcolumn=0

" 总是显示行号
set number
" 显示相对行号
set relativenumber

" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
if v:version >= 800
	set signcolumn=yes
endif

" 总是显示标签栏
set showtabline=2

" 总是显示状态栏
set laststatus=2

" 命令行高度
set cmdheight=1

" 在状态栏下面显示 Vim 工作模式
set showmode
" 右下角显示按键指令片段
set showcmd

" 光标行列位置标尺
set ruler
" 高亮显示光标所在行
set cursorline
" 光标移动保持所在列
set nostartofline
" 光标触发滚动时的保留行数
set scrolloff=5

" 上下分割窗口时, 默认在下边显示新窗口
set splitbelow
" 左右分割窗口时, 默认在右边显示新窗口
set splitright


"------------------------------------------------------------------------------
" 状态栏显示形式
"------------------------------------------------------------------------------
set statusline=															" 清空状态了
set statusline+=%<														" 向左对齐
set statusline+=\ [														" 左分割符
set statusline+=%{toupper(mode())}										" 工作模式
set statusline+=%{&paste?\"\|P\":\"\"}%{&spell?\"\|S\":\"\"}			" 粘贴模式拼写检查
set statusline+=\:%n													" 缓冲区编号
set statusline+=]														" 右分割符
set statusline+=\ %(%R\ \|\ %)											" 文件只读状态
set statusline+=%f														" 相对路径文件名
set statusline+=%=														" 向右对齐
set statusline+=\ %(%M\ %)												" 可编辑状态
set statusline+=%y														" 文件类型
set statusline+=\ %{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}		" 文件编码
set statusline+=\ (%{&fileformat})										" 文件格式
set statusline+=\ \|\ %c:%l/%L\ %p%%									" 光标位置行列信息


"------------------------------------------------------------------------------
" 搜索匹配命令补全
"------------------------------------------------------------------------------
" 扩展正则表达式
set magic

" 搜索时忽略大小写
set ignorecase
" 智能搜索大小写判断, 默认忽略大小写, 除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch
" 查找输入时动态增量显示查找结果
set incsearch

" 启用增强补全
set wildmenu
" 命令补全显示形式, 默认为 full
set wildmode=longest:full
" 命令补全搜索选项, 默认为 ''
"set wildoptions=pum


"------------------------------------------------------------------------------
" 缩进格式语法高亮代码折叠
"------------------------------------------------------------------------------
" 自动缩进
set autoindent
" 启用智能缩紧
"set smartindent
" 打开 C/C++ 语言缩进优化
set cindent

" 关闭自动换行
set nowrap
" 长行不能完全显示时显示当前屏幕能显示的部分。
" 默认值为空, 长行不能完全显示时显示 @
set display=lastline

" 设置缩进宽度
set shiftwidth=4
" 缩进列数对齐
set shiftround

" 设置 TAB 宽度
set tabstop=4
" 禁止展开 tab (noexpandtab)
set noexpandtab
" 如果后面设置了 expandtab 那么展开 tab 为多少字符
set softtabstop=4

" 显示匹配的括号
set showmatch
" 显示括号匹配的时间
set matchtime=2

" 设置显示制表符等隐藏分割符
set list
" 隐藏分割符显示列表 (支持 Unicode 字符或字符编码)
set listchars=tab:\|\ ,space:\ ,trail:.,extends:>,precedes:<,nbsp:␣
if v:version > 810
	set listchars+=multispace:.,lead:.
endif

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
"set errorformat=%.\ %#-->\ %f:%l:%c,%f(%l):%m,%f:%l:%c:%m,%f:%l:%m

" 允许 Vim 自带脚本根据文件类型自动设置缩进格式
if has('autocmd')
	filetype plugin on
	filetype indent on
endif

" 允许 Vim 自带脚本根据文件类型自动设置语法高亮
if has('syntax')
	syntax enable
	syntax on

	" 高亮显示注释中的自定义关键词
	"syntax match keyTodo contained '\<\(TODO\|FIXME\|XXX\|BUG\|HACK\|NOTE\|WARNING\):'
	"highlight def link keyTodo Todo
endif

" 代码折叠设置
if has('folding')
	" 允许代码折叠
	set foldenable
	" 代码折叠默认使用缩进
	set foldmethod=indent
	" 默认打开所有缩进
	set foldlevel=99

	" 搜索时不展开代码折叠
	"set foldopen-=search
	" 撤销时不展开代码折叠
	"set foldopen-=undo
endif


