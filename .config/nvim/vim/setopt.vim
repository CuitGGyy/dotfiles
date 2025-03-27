"==============================================================================
"
" setopt.vim - 全局基础选项配置设定
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2025/03/27 04:14:04
"
"==============================================================================


"------------------------------------------------------------------------------
" 交换文件, 备份撤销
"------------------------------------------------------------------------------
" 禁用兼容模式, 启用增强模式
set nocompatible

" 禁用交换文件
set noswapfile
" 交换文件刷写延时 默认4000毫秒
set updatetime=1000

" 写时备份
set writebackup

" 禁用备份
set nobackup
" 备份文件扩展名
set backupext='~'
" nvim 备份目录默认.,$XDG_STATE_HOME/nvim/backup/
" nvim 与 vim 的备份文件格式不兼容, 可能出现警告;
" vim bakcup 目录统一在 $XDG_CACHE_HOME/nvim/backup/
if !has('nvim')
	if $XDG_CACHE_HOME != ''
		set backupdir=$XDG_CACHE_HOME/nvim/backup
		silent! call mkdir(expand('$XDG_CACHE_HOME/nvim/backup'), 'p', 0755)
	else
		set backupdir=$HOME/.cache/nvim/backup
		silent! call mkdir(expand('$HOME/.cache/nvim/backup'), 'p', 0755)
	endif
endif

" 启用 undo 文件
set undofile
" nvim undo目录默认.,$XDG_STATE_HOME/nvim/undo/
" nvim 与 vim 的 undo 文件格式不兼容, 可能出现警告;
" vim undo 目录统一在 $XDG_CACHE_HOME/nvim/undo/
if !has('nvim')
	if $XDG_CACHE_HOME != ''
		set undodir=$XDG_CACHE_HOME/nvim/undo
		silent! call mkdir(expand('$XDG_CACHE_HOME/nvim/undo'), 'p', 0755)
	else
		set undodir=$HOME/.cache/nvim/undo
		silent! call mkdir(expand('$HOME/.cache/nvim/undo'), 'p', 0755)
	endif
endif

" vim 使用文本文件 viminfo, 默认在 ~/.viminfo
" nvim 使用二进制文件 shada, 默认在 $XDG_STATE_HOME/nvim/shada/
if !has('nvim')
	if $XDG_CACHE_HOME != ''
		set viminfo='100,<50,s10,h,n$XDG_CACHE_HOME/.viminfo
	else
		set viminfo='100,<50,s10,h,n$HOME/.cache/.viminfo
	endif
endif

" 各历史记录数量
set history=1000

" 共享系统剪贴板 (兼容 X 图形界面系统)
set clipboard+=unnamed
if v:version > 730
set clipboard+=unnamedplus
endif

" 自动切换目录
set autochdir
" 自动读取文件变动
set autoread

" 使用 Tab 标签页切换缓冲区（二者联动）
set switchbuf+=useopen,usetab,newtab
if has('nvim') || v:version > 820
set switchbuf+=uselast
endif


"------------------------------------------------------------------------------
" 文件编码格式
"------------------------------------------------------------------------------
" 内部工作编码
set encoding=utf-8
" 文件默认编码
set fileencoding=utf-8
" 打开文件时按编码序列自动尝试
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,default,latin1

" 文件换行符, 默认使用 unix 换行符
set fileformats=unix,dos,mac

" 文件格式选项用于显示, 默认值'tcqj'
" 如遇Unicode值大于255的文本, 不必等到空格再折行
set formatoptions+=m
" 合并两行中文时, 不在中间加空格
set formatoptions+=B

"set formatoptions=		" 清空默认值
"set formatoptions+=1
"set formatoptions+=q	" Continue comments with gq
"set formatoptions+=c	" Auto-wrap comments using textwidth
"set formatoptions+=r	" Continue commends when pressing Enter
"set formatoptions+=n	" Recognize numbered lists
"set formatoptions+=2	" Use indent from 2nd line of a paragraph
"set formatoptions+=t	" Autowrap lines using text width value
"set formatoptions+=j	" remove a comment leader when joining lines.
						" Only break if the line was not longer than
						" 'textwidth' when the insert started and only at a
						" white character that has been entered during the
						" current insert command.
"set formatoptions+=lv

" unicode 双字符宽度
"set ambiwidth=double


"------------------------------------------------------------------------------
" 终端, 键鼠, 光标
"------------------------------------------------------------------------------
" 终端使用 256 色
if !has('gui_running')
	set t_Co=256
	if v:version > 740
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
" 打开功能键超时检测 (终端下功能键为一串 ^Esc 开头的字符串)
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

" Windows 禁用 Alt 操作菜单 (使得 Alt 可以用到 Vim 里)
set winaltkeys=no
" 点击鼠标动作
set mouse=a

" 启用按键序列等待时限
set timeout
" 按键序列等待时限, 默认1000毫秒
set timeoutlen=500

" 设置 Backspace 键模式
set backspace=eol,start,indent
" 光标自动跳转
set whichwrap+=b,s,h,l,<,>,[,]


"------------------------------------------------------------------------------
" 交互界面显示
"------------------------------------------------------------------------------
" 背景明暗风格
set background=dark

" 总是显示行号
set number
" 显示相对行号
set relativenumber

" 总是显示左侧边栏图标指示列(用于显示 mark/gitdiff/诊断信息)
" vim不支持该参数后面附加限定条件
if v:version > 740
set signcolumn=auto
endif

" 总是显示标签栏
set showtabline=2

" 总是显示状态栏
set laststatus=2

" 命令行高度
set cmdheight=2
" 命令行窗口高度, 默认值7
set cmdwinheight=15

" 文本列宽度, 超过之后自动换行
set textwidth=100
" 文本列宽参考线, 超过表示代码太长, 考虑换行
set colorcolumn=+1

" 在状态栏下面显示 Vim 工作模式
set showmode
" 右下角显示按键指令片段
set showcmd

" 光标行列位置标尺
set ruler
" 高亮显示光标所在行
set cursorline
" 高亮显示光标所在列
set cursorcolumn
" 高亮显示光标所在行选项
set cursorlineopt=both
" 光标移动保持所在列
set nostartofline

" 触发垂直滚动时的屏幕上下保留行数
set scrolloff=5
" 触发水平滚动时的屏幕左侧保留列数
set sidescrolloff=5
" 触发水平滚动时最小列数
set sidescroll=1

" 比较模式垂直显示, 默认'internal,filler,closeoff'
set diffopt+=vertical
" 默认显示最后编辑所在行, 需要历史记录支持
set display+=lastline

" 上下分割窗口时, 默认在下边显示新窗口
set splitbelow
" 左右分割窗口时, 默认在右边显示新窗口
set splitright
" 窗口等价方向, 默认both
set eadirection=hor

" 菜单自动补全而非自动选中, 默认'menu,preview'
set completeopt=menu,menuone,noselect,noinsert

" 按回车键之前提示信息选项, 默认'ltTo0CF'
set shortmess+=c
"set shortmess=
"set shortmess+=t	" truncate file messges at start
"set shortmess+=A	" ignore annoying swap file messages
"set shortmess+=o	" file-read message overwrites previous
"set shortmess+=0	" file-read message overwrites any previous
"set shortmess+=T	" truncate non-file messages in middle
"set shortmess+=f	" (file x of x) instead of just (x of x
"set shortmess+=F	" Dont give file info when editing a file
"set shortmess+=s	" Dont give search hit
"set shortmess+=c	" Dont give ins-completion-menu
"set shortmess+=W	" Dont show [w] or written when writing


"------------------------------------------------------------------------------
" 状态栏显示样式
"------------------------------------------------------------------------------
set statusline=															" 清空状态了
set statusline+=%<														" 向左对齐
set statusline+=\ [														" 左分割符
set statusline+=%{toupper(mode(1))}										" 工作模式
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

set fillchars+=vert:▕,     "alternatives │
set fillchars+=fold:\ ,
if has('nvim') || v:version > 820
set fillchars+=eob:\ ,     "suppress ~ at EndOfBuffer
endif
set fillchars+=diff:─,     "alternatives: ⣿ ░
if has('nvim')
set fillchars+=msgsep:‾,   "vim不支持该参数
endif
if has('nvim') || v:version > 820
set fillchars+=foldopen:▾,
set fillchars+=foldsep:│,
set fillchars+=foldclose:▸,
endif


"------------------------------------------------------------------------------
" 搜索匹配命令补全, 拼写检查
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
" 命令补全显示忽略大小写
set wildignorecase
" 命令补全搜索选项, 默认为 'pum,tagfile'
if has('nvim') || v:version > 820
set wildoptions+=pum
endif
set wildoptions+=tagfile

" 弹出窗口半透明, 透明度0-100
" vim不支持该选项
if has('nvim')
set pumblend=15
endif
" 补全最多显示15行
set pumheight=15

" 按英语检查拼写, 也可附加其他词典
if has('spell')
set spelllang+=en_us
set spelllang+=cjk
" 自动补全拼写词典
"set complete+=kspell
" 自动补全英语词典
"set dictionary=k~/english/dict/*
endif


"------------------------------------------------------------------------------
" 缩进格式, 语法高亮, 代码折叠, 错误格式
"------------------------------------------------------------------------------
" 自动缩进
set autoindent
" 启用智能缩紧
set smartindent
" 启用基于断行缩进
set breakindent
" 启用 c/c++ 语言缩进优化
set cindent

" 关闭自动换行显示, 默认开启
" 长行不能完全显示时显示当前屏幕能显示的部分
set nowrap

" 自动换行显示时, 断行基于词而非随机字符
set linebreak
" 自动换行显示时, 在缩进之前显示断行符
set breakindentopt=sbr
" 自动换行显示时的自动断行符, 其他备选符号: '…', '⋯', '→', '⇢', '↳ ', '↪ ', '⤷',
set showbreak=↳

" 语法着色限制列宽, 避免长行高亮显示错误; 默认上限 3000
set synmaxcol=1024

" 设置缩进宽度
set shiftwidth=4
" 对齐缩进列数
set shiftround

" 设置 Tab 宽度
set tabstop=4
" 编辑模式下退格键的回退缩进长度
set softtabstop=4
" 是否扩展 Tab 键字符: expandtab: 空格缩进; noexpandtab: 制表符缩进
set noexpandtab

" 显示匹配的括号
set showmatch
" 显示括号匹配的时间
set matchtime=3

" 设置显示制表符等各种隐藏分割符
set list
" 隐藏分割符显示列表 (支持 Unicode 字符或字符编码)
" 使用 ascii 字符显示隐藏字符
"set listchars=tab:\|\ ,space:\ ,trail:.,extends:>,precedes:<,nbsp:␣
"if has('nvim') || v:version > 820
"set listchars+=multispace:·,lead:⸱
"endif
" 使用 unicode 字符显示隐藏字符
" 其他备选符号: '∙', '•', '﹏', '…', '⋯', '»', '«'
set listchars=tab:│\ ,space:\ ,trail:․,extends:›,precedes:‹,nbsp:␣
if has('nvim') || v:version > 820
set listchars+=multispace:·,lead:⸱
endif


"------------------------------------------------------------------------------
" 文件类型, 语法高亮, 代码折叠
"------------------------------------------------------------------------------

" 允许 Vim 自带脚本根据文件类型自动设置缩进格式
if has('filetype')
	filetype plugin on
	filetype indent on
endif

" 语法高亮显示
if has('syntax')
	" 启用vim内嵌语法高亮支持: lua, perl, python, ruby
	let g:vimsyn_embed='lpPr'

	" 允许 Vim 自带脚本根据文件类型自动设置语法高亮
	syntax enable
	syntax on
endif

" 代码折叠设置
if has('folding')
	" 允许代码折叠
	set foldenable

	if &diff
		" 对比差异时使用默认手动折叠方式
		set foldmethod=manual
	else
		" 代码折叠方法使用缩进方式, 默认manual
		set foldmethod=indent
	endif

	" 代码折叠左侧边栏对齐间距, 默认0关闭选项功能
	" vim不支持`auto`仅支持数值, 上限值12
	set foldcolumn=0

	" 打开所有代码折叠
	set foldlevel=99
	" 折叠起始层级, 默认值-1
	set foldlevelstart=-1

	" foldopen 默认值 'block,hor,mark,percent,quickfix,search,tag,undo'
	" 搜索时不展开代码折叠
	"set foldopen-=search
	" 撤销时不展开代码折叠
	"set foldopen-=undo
endif


"------------------------------------------------------------------------------
" 编译调试, 过滤匹配, 错误格式, QuickFix
"------------------------------------------------------------------------------
"set makeprg=cmake

" 错误格式
"set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
"set errorformat=%.\ %#-->\ %f:%l:%c,%f(%l):%m,%f:%l:%c:%m,%f:%l:%m


