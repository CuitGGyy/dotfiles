--------------------------------------------------------------------------------
--
-- setopt.lua - 全局基础选项配置设定
--
-- Maintainer: cuitggyy (at) gmail.com
-- Last Modified: 2025/03/26 00:04:30
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 变量重命名与函数预定义
--------------------------------------------------------------------------------
local api, fn, cmd, opt = vim.api, vim.fn, vim.cmd, vim.opt
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup


--------------------------------------------------------------------------------
-- 交换文件, 备份撤销
--------------------------------------------------------------------------------

-- 禁用交换文件
opt.swapfile = false
-- 交换文件刷写延时, 默认4000毫秒
opt.updatetime = 1000

-- 写时备份
opt.writebackup = true

-- 禁用备份
opt.backup = false
-- 备份文件扩展名
opt.backupext = '~'
-- nvim 备份目录默认.,$XDG_STATE_HOME/nvim/backup/
-- 与 vim 的备份文件格式不兼容, 可能出现警告;
-- 无论 vim/nvim 若启用备份, 则统一在 $XDG_STATE_HOME/nvim/backup/
--[[
opt.backupdir = fn.stdpath('state') .. '/backup'
if not fn.isdirectory(vim.opt.backupdir) then
	fn.mkdir(vim.opt.backupdir, 'p', 0755)
end
--]]

-- 启用undo文件
opt.undofile = true
-- nvim undo目录默认.,$XDG_STATE_HOME/nvim/undo/
-- 与 vim 的 undo 文件格式不兼容, 可能出现警告;
-- 无论 vim/nvim 若启用 undo, 则统一在 $XDG_STATE_HOME/nvim/undo/
--[[
opt.undodir = fn.stdpath('state') .. '/undo'
if not fn.isdirectory(vim.opt.undodir) then
	fn.mkdir(vim.opt.undodir, 'p', 0755)
end
--]]

-- 操作历史记录数量
opt.history = 1000

-- 共享系统剪贴板(兼容 X 图形界面系统)
opt.clipboard:append({'unnamed', 'unnamedplus'})

-- 自动切换目录
opt.autochdir = true
-- 自动读取文件变动
opt.autoread = true

-- 使用 Tab 标签页切换缓冲区(二者联动)
opt.switchbuf = 'useopen,usetab,newtab,uselast'


--------------------------------------------------------------------------------
-- 文件编码格式
--------------------------------------------------------------------------------
-- 内部工作编码
opt.encoding = 'utf-8'
-- 文件默认编码
opt.fileencoding = 'utf-8'
-- 打开文件时按编码序列自动尝试
opt.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,default,latin1'

-- 文件换行符, 默认使用 unix 换行
opt.fileformats = 'unix,dos,mac'

-- 文件格式选项用于显示, 默认值 'tcqj'
-- 如遇Unicode值大于255的文本, 不必等到空格再折行
opt.formatoptions:append('m')
-- 合并两行中文时, 不在中间加空格
opt.formatoptions:append('B')
--[[
opt.formatoptions = table.concat({
	'1',
	'q', -- continue comments with gq"
	'c', -- Auto-wrap comments using textwidth
	'r', -- Continue comments when pressing Enter
	'n', -- Recognize numbered lists
	'2', -- Use indent from 2nd line of a paragraph
	't', -- autowrap lines using text width value
	'j', -- remove a comment leader when joining lines.
	-- Only break if the line was not longer than 'textwidth' when the insert
	-- started and only at a white character that has been entered during the
	-- current insert command.
	'lv',
})
--]]

-- unicode双字符宽度
--opt.ambiwidth = 'double'

--------------------------------------------------------------------------------
-- 终端, 鼠标, 光标
--------------------------------------------------------------------------------

if not fn.has('gui_running') then
	opt.t_Co = '256'
	opt.termguicolors = true
end

-- 增强平滑刷新, 帮助复制粘贴
opt.ttyfast = true
-- 打开功能键超时检测(终端下功能键为一串 ^Esc 开头的字符串)
opt.ttimeout = true
-- 功能键超时检测 50 毫秒
opt.ttimeoutlen = 50
-- 延迟绘制(提升性能)
opt.lazyredraw = true

-- 禁用视图模式响铃
opt.visualbell = false
-- 禁用出现错误响铃
opt.errorbells = false

-- Windows 禁用 Alt 操作菜单(使得 Alt 可以用到 Vim 里)
opt.winaltkeys = 'no'
-- 点击鼠标动作
opt.mouse = 'a'

-- 启用按键序列等待时限
opt.timeout = true
-- 按键序列等待时限, 默认1000毫秒
opt.timeoutlen = 500

-- 设置 Backspace 键模式
opt.backspace = 'eol,start,indent'
-- 光标自动跳转
opt.whichwrap = 'b,s,h,l,<,>,[,]'


--------------------------------------------------------------------------------
-- 交互界面显示
--------------------------------------------------------------------------------
-- 背景明暗风格
opt.background = 'dark'

-- 总是显示行号
opt.number = true
-- 使用相对行号
opt.relativenumber = true

-- 总是显示左侧边栏图标指示列(用于显示 mark/gitdiff/诊断信息), 默认auto
-- vim不支持该参数后面附加限定条件
opt.signcolumn = 'auto'

-- 总是显示标签栏
opt.showtabline = 2

-- 总是显示状态栏
opt.laststatus = 2

-- 命令行高度
opt.cmdheight = 2
-- 命令行窗口高度, 默认值7
opt.cmdwinheight = 15

-- 文本列宽, 超过之后自动换行
opt.textwidth = 100
-- 文本列宽右侧参考线, 超过表示代码太长, 考虑换行
opt.colorcolumn = '+1'

-- 在状态栏下面显示工作模式
opt.showmode = true
-- 右下角显示按键指令片段
opt.showcmd = true

-- 光标行列位置标尺
opt.ruler = true
-- 高亮显示光标所在行
opt.cursorline = true
-- 高亮显示光标所在列
opt.cursorcolumn = true
-- 高亮显示光标所在行选项
opt.cursorlineopt = 'both'
-- 光标移动保持所在列
opt.startofline = false

-- 触发垂直滚动时的屏幕上下保留行数
opt.scrolloff = 5
-- 触发水平滚动时的屏幕左侧保留列数
opt.sidescrolloff = 5
-- 触发水平滚动时最小列数
opt.sidescroll = 1

-- 比较模式垂直显示, 默认'internal,filler,closeoff'
opt.diffopt:append('vertical')
-- 默认显示最后编辑所在行, 需要历史记录支持
opt.display:append('lastline')

-- 上下分割窗口时, 默认在下边显示新窗口
opt.splitbelow = true
-- 左右分割窗口时, 默认在右边显示新窗口
opt.splitright = true
-- 窗口等价方向, 默认both
opt.eadirection = 'hor'

-- 菜单自动补全而非自动选中, 默认'menu,preview'
opt.completeopt = 'menu,menuone,noselect,noinsert'

-- 按回车键之前提示信息选项, 默认'ltTo0CF'
opt.shortmess:append('c')
--[[
opt.shortmess = table.concat({
	't', -- truncate file messages at start
	'A', -- ignore annoying swap file messages
	'o', -- file-read message overwrites previous
	'O', -- file-read message overwrites previous
	'T', -- truncate non-file messages in middle
	'f', -- (file x of x) instead of just (x of x
	'F', -- Dont give file info when editing a file
	's', -- Dont give search hit
	'c', -- Dont give ins-completion-menu
	'W', -- Dont show [w] or written when writing
})
--]]


--------------------------------------------------------------------------------
-- 状态栏显示样式
--------------------------------------------------------------------------------

opt.statusline = opt.statusline or table.concat({
	'%<',												-- 向左对齐
	' [',												-- 左分割符
	'%{toupper(mode(1))}',								-- 工作模式
	'%{&paste?"|P":""}%{&spell?"|S":""}',				-- 粘贴模式拼写检查
	':%n',												-- 缓冲区编号
	']',												-- 右分割符
	' %(%R | %)',										-- 文件只读状态
	'%f',												-- 相对路径文件名
	'%=',												-- 向右对齐
	' %(%M %)',											-- 可编辑状态
	'%y',												-- 文件类型
	' %{(&fenc==""?&enc:&fenc).(&bomb?",BOM":"")}',		-- 文件编码
	' (%{&fileformat})',								-- 文件格式
	' | %c:%l/%L %p%%',									-- 光标位置行列信息
}, '')

opt.fillchars = opt.fillchars or table.concat({
	'vert:▕',		-- alternatives │
	'fold: ',
	'eob: ',		-- suppress ~ at EndOfBuffer
	'diff:─',		-- alternatives: ⣿ ░
	'msgsep:‾',		-- vim不支持该选项参数
	'foldopen:▾',
	'foldsep:│',
	'foldclose:▸',
}, ',')


--------------------------------------------------------------------------------
-- 搜索匹配命令补全, 拼写检查
--------------------------------------------------------------------------------

-- 扩展正则表达式
opt.magic = true

-- 搜索时忽略大小写
opt.ignorecase = true
-- 智能搜索大小写判断, 默认忽略大小写, 除非搜索内容包含大写字母
opt.smartcase = true

-- 高亮搜索内容
opt.hlsearch = true
-- 查找输入时动态增量显示查找结果
opt.incsearch = true

-- 启用增强补全
opt.wildmenu = true
-- 命令补全显示形式, 最长完全匹配
opt.wildmode = 'longest:full'
-- 命令补全忽略大小写
opt.wildignorecase = true
-- 命令补全搜索选项, 默认'pum,tagfile'
opt.wildoptions = 'pum,tagfile'

-- 弹出窗口半透明, 透明度0-100
-- vim不支持该选项
opt.pumblend = 15
-- 补全最多显示15行
opt.pumheight = 15

-- 按英语检查拼写, 也可附加其他词典
if fn.has('spell') then
	opt.spelllang:append('en_us')
	opt.spelllang:append('cjk')
	-- 自动补全拼写词典
	--opt.complete:append('kspell')
	-- 自动补全英语词典
	--opt.dictionary:append('k~/english/dict/*')
end


--------------------------------------------------------------------------------
-- 缩进格式, 语法高亮, 代码折叠, 错误格式
--------------------------------------------------------------------------------

-- 自动缩进
opt.autoindent = true
-- 启用智能缩进
opt.smartindent = true
-- 基于断行缩进
opt.breakindent = true
-- 启用 c/c++ 语言缩进优化
opt.cindent = true

-- 关闭自动换行显示, 默认开启
-- 长行不能完全显示时显示当前屏幕能显示的部分
opt.wrap = false

-- 自动换行显示时, 断行基于词而非随机字符
opt.linebreak = true
-- 自动换行显示时, 在缩进之前显示断行符
opt.breakindentopt = 'sbr'
-- 自动换行显示时的自动断行符, 其他备选符号: '…', '⋯', '→', '⇢', '↳ ', '↪ ', '⤷',
opt.showbreak = '↳ '

-- 语法着色限制列宽, 避免长行高亮显示错误; 默认上限 3000
opt.synmaxcol = 1024

-- 设置缩进宽度
opt.shiftwidth = 4
-- 对齐缩进列数
opt.shiftround = true

-- 设置 Tab 缩进字符宽度
opt.tabstop = 4
-- 编辑模式下退格键的回退缩进长度
opt.softtabstop = 4
-- 是否扩展 Tab 键字符, true: 用空格缩进, false 用制表符缩进
opt.expandtab = false

-- 显示匹配的括号
opt.showmatch = true
-- 显示括号匹配的时间, 默认5
opt.matchtime = 3

-- 设置显示制表符等各种隐藏分割符
opt.list = true

-- 隐藏分割符显示列表 (支持 Unicode 字符或字符编码)
-- 使用 ascii 字符显示隐藏字符
--[[
opt.listchars = table.concat({
	'eol: ',
	'tab:| ',
	'space: ',
	'trail:.',
	'extends:>',
	'precedes:<',
	'nbsp:␣',
	'multispace:·',
	'lead:⸱,',
}, ',')
--]]
-- 使用 unicode 字符显示隐藏字符
-- 其他备选符号: '∙', '•', '﹏', '…', '⋯', '»', '«'
opt.listchars = table.concat({
	'eol: ',
	'tab:│ ',
	'space: ',
	'trail:․', -- U+2024, One Dot Leader
	'extends:›', -- Alternatives: … »
	'precedes:‹', -- Alternatives: … «
	'nbsp:␣',
	'multispace:·', -- U+00B7, Middle Dot
	'lead:⸱', -- U+2E31, Word Separator Middle Dot
}, ',')


--------------------------------------------------------------------------------
-- 文件类型, 语法高亮, 代码折叠
--------------------------------------------------------------------------------
-- 允许 Vim 自带脚本根据文件类型自动设置缩进格式
if fn.has('filetype') then
	cmd.filetype('plugin on')
	cmd.filetype('indent on')
end

-- 语法高亮显示
if fn.has('syntax') then
	-- 启用vim内嵌语法高亮支持: lua, perl, python, ruby
	vim.g.vimsyn_embed = 'lpPr'

	-- 允许 Vim 自带脚本根据文件类型自动设置语法高亮
	cmd.syntax('enable')
	cmd.syntax('on')
end

-- 代码折叠设置
if fn.has('folding') then
	-- 启用代码折叠
	opt.foldenable = true

	-- 代码折叠默认使用缩进, 默认值'manual'
	--opt.foldmethod = 'indent'
	opt.foldmethod = 'syntax'

	-- 代码折叠左侧边栏对齐间距, 默认0关闭选项功能
	-- vim不支持`auto`仅支持数值, 上限值12
	opt.foldcolumn = '0'

	-- 打开所有代码折叠
	opt.foldlevel = 99
	-- 折叠起始层级
	opt.foldlevelstart = 15

	-- foldopen 默认值 'block,hor,mark,percent,quickfix,search,tag,undo'
	-- 搜索时不展开代码折叠
	--opt.foldopen:remove('search')
	-- 撤销时不展开代码折叠
	--opt.foldopen:remove('undo')
end


--------------------------------------------------------------------------------
-- 编译调试, 过滤匹配, 错误格式, QuickFix
--------------------------------------------------------------------------------
--vim.opt.makeprg=cmake

-- 错误格式
--opt.errorformat = '[%f:%l] -> %m,[%f:%l]:%m'
--opt.errorformat = '%. %#--> %f:%l:%c,%f(%l):%m,%f:%l:%c:%m,%f:%l:%m'


