--------------------------------------------------------------------------------
--
-- autofn.lua - 自定义配置或自动化功能扩展
--
-- Maintainer: cuitggyy (at) gmail.com
-- Last Modified: 2025/03/25 02:18:01
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 变量重命名与函数预定义
--------------------------------------------------------------------------------
local api, fn, cmd, opt = vim.api, vim.fn, vim.cmd, vim.opt
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup


--------------------------------------------------------------------------------
-- 键盘功能按键输入键码修正
--------------------------------------------------------------------------------
-- 若按键键码存在问题, 可分别在终端模拟器, inputrc环境变量, 还有这里予以修复
-- 详情参见`../vim/autofn.vim`


--------------------------------------------------------------------------------
-- tags 符号索引标签文件, 默认./tags;,tags
-- 详细说明参考: https://www.zhihu.com/question/47691414/answer/373700711
--
-- 前半部分“./tags;”代表在文件的所在目录下 (不是“:pwd”返回的Vim当前目录),
-- 查找名字为“.tags”的符号文件, 后面一个分号代表查找不到的话向上递归到父目录,
-- 直到找到tags文件或者递归到了根目录还没找到. 这样对于复杂工程很友好,
-- 源代码都是分布在不同子目录中, 而只需要在项目顶层目录放一个tags文件即可;
-- 逗号分隔的后半部分“tags”是指同时在Vim的当前目录(“:pwd”命令返回的目录,
-- 可以用“:cd ..”命令改变) 下面查找tags文件。
--------------------------------------------------------------------------------
opt.tags = vim.opt.tags:append({'./tagfile', ',tagfile'})


--------------------------------------------------------------------------------
-- 打开文件后自动恢复上一次退出前光标所在位置
--------------------------------------------------------------------------------
autocmd({'BufReadPost', 'FileReadPost'}, {
	pattern = '*',
	callback = function()
		-- 获取上次退出时的光标位置
		--local last_pos = fn.line("'\"")
		local last_pos = api.nvim_buf_get_mark(0, '"')[1]
		-- 获取文件的总行数
		--local total_lines = fn.line('$')
		local total_lines = api.nvim_buf_line_count(0)
		if last_pos > 1 and last_pos <= total_lines then
			-- 跳转到上次退出时的光标位置
			cmd("normal! g'\"")
			-- 调整窗口，使光标行居中
			cmd('normal! z.')
		end
	end,
})


--------------------------------------------------------------------------------
-- 如果最后一个窗口不可编辑就自动退出
--------------------------------------------------------------------------------
autocmd('BufEnter', {
	pattern = '*',
	callback = function()
		local windows = api.nvim_list_wins()
		local empty_buffers = vim.tbl_filter(function(win)
			-- 获取窗口对应的缓冲区编号
			local bufnr = api.nvim_win_get_buf(win)
			-- 获取缓冲区的 buftype
			local buf_type = api.nvim_buf_get_option(bufnr, 'buftype')
			return buf_type == ''
		end, windows)
		-- 如果没有普通缓冲区，则退出
		if #empty_buffers == 0 then
			cmd('quitall!')
		end
	end,
})


--------------------------------------------------------------------------------
-- 自动显示相对行号或绝对行号
-- 尽在当前窗口的非插入模式下自动显示相对行号, 其他情况均显示绝对行号
--------------------------------------------------------------------------------
local LineNumberAuto = augroup('LineNumberAuto', { clear = true })
autocmd({'TabEnter', 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
	group = LinuxNumberAuto,
	pattern = '*',
	callback = function()
		if api.nvim_get_option_value('number', {}) and api.nvim_get_mode().mode ~= 'i' then
			opt.relativenumber = true
		end
	end,
})
autocmd({ 'TabLeave', 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
	group = LineNumberAuto,
	pattern = '*',
	callback = function()
		if vim.api.nvim_get_option_value('number', {}) then
			opt.relativenumber = false
		end
	end,
})


--------------------------------------------------------------------------------
-- 保存文件之前自动去除行尾多余空白
--------------------------------------------------------------------------------
local function strip_trailing_spaces()
	-- 保存当前光标位置
	local row, col = unpack(api.nvim_win_get_cursor(0))
	-- 保存最后搜索寄存器状态
	local last_search = fn.getreg('/')

	-- 使用正则表达式去除行尾空白
	cmd([[%s/\s\+$//e]])

	-- 恢复光标位置
	api.nvim_win_set_cursor(0, {row, col})
	-- 恢复搜索寄存器状态
	fn.setreg('/', last_search)
end

-- 创建手动执行命令
api.nvim_create_user_command('StripTrailSpaces', strip_trailing_spaces, {})

-- 在指定类型的文件保存之前设置自动执行命令
autocmd({'BufWritePre', 'FileWritePre'}, {
	pattern = '*',
	callback = strip_trailing_spaces,
})


--------------------------------------------------------------------------------
-- 自动修改文件的最后修改时间
--------------------------------------------------------------------------------
local function last_modified_datetime(headline)
	local total_lines = fn.line('$')
	local limit_line = math.min(headline, total_lines)

	local function update_datetime(pattern, replacement, limit_line)
		if fn.search(pattern, 'nw') ~= 0 then
			-- 保存当前光标位置
			local row, col = unpack(api.nvim_win_get_cursor(0))
			-- 保存最后搜索寄存器状态
			local last_search = fn.getreg('/')

			-- 执行替换操作
			cmd(string.format([[1,%dg/%s/s/%s.*/%s/]], limit_line, pattern, pattern, replacement))

			-- 恢复光标位置
			api.nvim_win_set_cursor(0, {row, col})
			-- 恢复搜索寄存器状态
			fn.setreg('/', last_search)
		end
	end

	-- 获取当前时间, 并用 `\V` 方式让 `:s` 识别特殊字符
	local datetime = fn.escape(os.date('%Y/%m/%d %H:%M:%S'), '\\/')

	-- 更新两种格式的 Last Modified 时间
	update_datetime('[Ll]ast [Mm]odified:', 'Last Modified: ' .. datetime, limit_line)
	update_datetime('[Ll]ast-[Mm]odified:', 'Last-Modified: ' .. datetime, limit_line)

end

-- Create a command for manual execution
api.nvim_create_user_command('LastModifiedDatetime', function(opts)
	last_modified_datetime(tonumber(opts.args))
end, { nargs = 1 })

-- Set up auto commands to run before saving specified file types
api.nvim_create_autocmd({'BufWritePre', 'FileWritePre'}, {
	pattern = '*',
	callback = function()
		last_modified_datetime(15)
	end,
})


--------------------------------------------------------------------------------
-- 定义`DiffOrig`命令用于对比查看文件改动
--------------------------------------------------------------------------------
if fn.exists(':DiffOrig') == 0 then
	api.nvim_create_user_command('DiffOrig', function()
		-- 创建一个新的垂直选项窗口
		cmd('vert new')
		-- 设置为无文件缓冲区
		vim.bo.buftype = 'nofile'
		-- 读取原始文件版本
		cmd('read ++edit #')
		-- 删除第一行（因为 `read ++edit #` 可能会在顶部插入空行）
		cmd('0d_')
		-- 进入 diff 模式
		cmd('diffthis')
		-- 切换回原始窗口
		cmd('wincmd p')
		-- 让当前文件也进入 diff 模式
		cmd('diffthis')
	end, {})
end


--------------------------------------------------------------------------------
-- 定义 tabline 标签栏文字显示风格
--------------------------------------------------------------------------------
-- 标签栏风格
-- 0: 不显示标签编号, 仅显示标签名称
-- 1: 显示标签编号和标签名称
local tablabel_number_style = true

-- 当显示标签编号时, 标签编号左右两侧修饰符
local tablabel_padding_left = ''
local tablabel_padding_right = ''

-- 缓冲区类型表
--[[
local buffer_type = {}
buffer_type.map = {
	[''] = '[Empty]',
	['acwrite'] = '[ACWrite]',
	['help'] = '[Help]',
	['nofile'] = '[NoFile]',
	['nowrite'] = '[NoWrite]',
	['quickfix'] = '[QuickFix]',
	['terminal'] = '[Terminal]',
	['prompt'] = '[Prompt]',
}
--]]

-- 获取缓冲区名称
local function neat_buffer(bufnr, fnametype)
	local bufname = api.nvim_buf_get_name(bufnr)
	local buftype = vim.bo[bufnr].buftype

	local ok, err = pcall(api.nvim_buf_get_var, bufnr, '__asc_bufname')
	if ok then
		return api.nvim_buf_get_var(bufnr, '__asc_bufname')
	end

	if bufname ~= '' then
		if fnametype == 0 then
			return fn.fnamemodify(bufname, ':t')
		elseif fnametype == 1 then
			return fn.fnamemodify(bufname, ':p')
		elseif fnametype == 2 then
			return fn.fnamemodify(bufname, ':h:t')
		else
			return fn.fnamemodify(bufname, ':t')
		end
	else
		return '[No Name]'
	end
end

-- 计算 Tab Label 标签名称
local function neat_tab_label(num)
	local buflist = fn.tabpagebuflist(num)
	local winnr = fn.tabpagewinnr(num)
	local bufnr = buflist[winnr]
	local fname = neat_buffer(bufnr, 0)
	local symbol, label = '', ''

	if vim.bo[bufnr].modified and vim.bo[bufnr].readonly then
		symbol = '+-'
	elseif vim.bo[bufnr].modified then
		symbol = '+'
	elseif vim.bo[bufnr].readonly then
		symbol = '-'
	elseif not vim.bo[bufnr].modifiable then
		symbol = '='
	else
		symbol = ''
	end

	if symbol ~= '' and tablabel_number_style then
		label = table.concat({
			tablabel_padding_left, num, tablabel_padding_right,
			' ', fname, ' ', symbol,
		}, '')
	elseif symbol == '' and tablabel_number_style then
		label = table.concat({
			tablabel_padding_left, num, tablabel_padding_right,
			' ', fname,
		}, '')
	else
		label = table.concat({
			symbol, ' ', fname,
		}, '')
	end

	return label
end

-- 计算 GUI Tab Label 标签名称
local function neat_gui_tab_label()
	local num = vim.v.lnum
	local buflist = fn.tabpagebuflist(num)
	local winnr = fn.tabpagewinnr(num)
	local bufnr = buflist[winnr]
	local fname = neat_buffer(bufnr, 0)
	local symbol, label = '', ''

	if vim.bo[bufnr].modified and vim.bo[bufnr].readonly then
		symbol = '+-'
	elseif vim.bo[bufnr].modified then
		symbol = '+'
	elseif vim.bo[bufnr].readonly then
		symbol = '-'
	elseif not vim.bo[bufnr].modifiable then
		symbol = '='
	else
		symbol = ''
	end

	if symbol ~= '' and tablabel_number_style then
		label = table.concat({
			tablabel_padding_left, num, tablabel_padding_right,
			' ', fname, ' ', symbol,
		}, '')
	elseif symbol == '' and tablabel_number_style then
		label = table.concat({
			tablabel_padding_left, num, tablabel_padding_right,
			' ', fname,
		}, '')
	else
		label = table.concat({
			symbol, ' ', fname,
		}, '')
	end

	return label
end

-- 计算 GUI Tab 提示符号
local function neat_gui_tab_tip()
	local tip = ''
	local bufnrlist = fn.tabpagebuflist(vim.v.lnum)

	for _, bufnr in ipairs(bufnrlist) do
		-- separate buffer entries
		if tip ~= '' then
			tip = tip .. ' \n'
		end

		-- Add name of buffer
		local name = neat_buffer(bufnr, 1)
		tip = tip .. name

		-- add modified/modifiable flags
		if vim.bo[bufnr].modified then
			tip = tip .. ' [+]'
		end
		if not vim.bo[bufnr].modifiable then
			tip = tip .. ' [-]'
		end
	end
	return tip
end

-- 显示 tabline 标签栏
local function neat_tab_line()
	local s = ''
	for i = 1, fn.tabpagenr('$') do
		-- 选中标签高亮
		if i == fn.tabpagenr() then
			s = s .. '%#TabLineSel#'
		else
			s = s .. '%#TabLine#'
		end
		-- 设置 Tab 编号
		s = s .. '%' .. i .. 'T'
		-- 计算 Tab 标签名
		s = s .. ' %{v:lua.neat_tab_label(' .. i .. ')} '
	end
	-- 末尾填充
	s = s .. '%#TabLineFill#%T'
	-- 右对齐关闭按钮
	if fn.tabpagenr('$') > 1 then
		--s = s .. '%=%#TabLine#%999XXclose'
		s = s .. '%=%#TabLine#%999XX '
	end
	return s
end

if opt.tabline == nil or vim.o.tabline == '' then
	-- 将函数暴露给 v:lua
	_G.neat_buffer = neat_buffer
	_G.neat_tab_label = neat_tab_label
	_G.neat_gui_tab_label = neat_gui_tab_label
	_G.neat_gui_tab_tip = neat_gui_tab_tip
	_G.neat_tab_line = neat_tab_line

	-- 标签栏默认`%N\ %f`, 也可以是`%M%t`
	-- 标签栏最终实现逻辑, 每次调用动态调用生成
	opt.tabline = '%!v:lua.neat_tab_line()'
	fn.guitablabel = '%!v:lua.neat_gui_tab_label()'
	fn.guitabtooltip = '%!v:lua.neat_gui_tab_tip()'
end


--------------------------------------------------------------------------------
-- 色彩主题样式配置
--------------------------------------------------------------------------------

-- 若未使用 mini.hipatterns 插件, 则使用自定义高亮匹配及色彩样式
if package.loaded['mini.hipatterns'] == nil then

	-- 自定义`Todo`,`Debug`高亮组匹配关键词
	-- lua 的`\`反斜线必须转义`\\`
	-- `\W`匹配一个非单词字符; `\zs`设置匹配的起始位置;
	-- `\W\zs`从前面一个字符是非单词字符开始匹配;
	-- `\v`开启魔法模式: `|`,`(`,`)`等正则特殊字符不需要转义, 可以直接使用;
	autocmd('Syntax', {
		pattern = '*',
		callback = function()
			fn.matchadd('NeatFixme', '\\W\\zs\\v(FIXME|BUG):')
			fn.matchadd('NeatHack', '\\W\\zs\\v(HACK|WARN):')
			fn.matchadd('NeatTodo', '\\W\\zs\\v(TODO|XXX):')
			fn.matchadd('NeatNote', '\\W\\zs\\v(NOTE|NOTICE):')
		end,
	})

	-- 自定义高亮组反色显示
	--api.nvim_set_hl(0, 'NeatFixme', { bold = true, reverse = true, cterm = { bold = true, reverse = true }, })
	--api.nvim_set_hl(0, 'NeatHack', { bold = true, reverse = true, cterm = { bold = true, reverse = true }, })
	--api.nvim_set_hl(0, 'NeatTodo', { bold = true, reverse = true, cterm = { bold = true, reverse = true }, })
	--api.nvim_set_hl(0, 'NeatNote', { bold = true, reverse = true, cterm = { bold = true, reverse = true }, })

	-- 链接自定义高亮组配色至现有高亮组
	api.nvim_set_hl(0, 'NeatFixme', { link = 'vimError' })
	api.nvim_set_hl(0, 'NeatHack', { link = 'vimWarn' })
	api.nvim_set_hl(0, 'NeatTodo', { link = 'vimTodo' })
	api.nvim_set_hl(0, 'NeatNote', { link = 'vimBang' })

end


--------------------------------------------------------------------------------
-- TERMINAL 终端模式设置, 隐藏行号和侧边栏
--------------------------------------------------------------------------------
local TerminalAuto = augroup('TerminalAuto', { clear = true })
-- 终端打开时不显示行号和标志列
autocmd('TermOpen', {
	group = TerminalAuto,
	pattern = '*',
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = 'no'
		-- 自动进入插入模式
		cmd('startinsert')
		-- 设置本地列表格式
		--cmd('setlocal list')
	end,
})
--[[
-- 终端关闭时自动删除缓冲区
autocmd('TermClose', {
	group = TerminalAuto,
	pattern = '*',
	callback = function()
		-- 关闭终端时自动删除缓冲区
		cmd('bdelete! %')
	end,
})
--]]


--------------------------------------------------------------------------------
-- QuickFix 快速修复列表窗口设置
--------------------------------------------------------------------------------
local QuickFixAuto = augroup('QuickFixAuto', { clear = true})
-- 清空 quickfix 列表
autocmd('FileType', {
	group = QuickFixAuto,
	pattern = 'qf',
	callback = function()
		vim.keymap.set('n', 'dq', function()
			fn.setqflist({}, 'r')
			cmd('cclose')
		end, { remap = false, silent = true, buffer = true})
	end,
})

-- NORMAL 模式 dd 删除 quickfix 指定行
local function remove_quickfix_entry(index)
	-- 获取当前 quickfix 列表
	local qflist = fn.getqflist()
	if index < 1 or index > #qflist then
		--print('Invalid index: ' .. index)
		return
	end

	-- 保存当前光标位置
	local row, col = unpack(api.nvim_win_get_cursor(0))
	-- 保存最后搜索寄存器状态
	local last_search = fn.getreg('/')

	-- 从列表中删除指定行
	table.remove(qflist, index)
	-- 重新设置 quickfix 列表
	fn.setqflist(qflist, 'r')

	-- 恢复光标位置
	api.nvim_win_set_cursor(0, {row, col})
	-- 恢复搜索寄存器状态
	fn.setreg('/', last_search)
end
autocmd('FileType', {
	group = QuickFixAuto,
	pattern = 'qf',
	callback = function()
		vim.keymap.set('n', 'dd', function()
			-- 获取 quickfix 窗口的光标所在行号
			local line = api.nvim_win_get_cursor(0)[1]
			-- 删除 quickfix 光标所在行
			remove_quickfix_entry(line)
		end, { remap = false, silent = true, buffer = true })
	end,
})

-- VISUAL 模式 d 删除 quickfix 选择的行
local function remove_quickfix_block(qftable, from, to)
	local rest = {}
	for i = 1, #qftable, 1 do
		if i < from or i > to then
			rest[#rest + 1] = qftable[i]
		-- else
		--	i = to + 1
		end
	end
	return rest
end
autocmd('FileType', {
	group = QuickFixAuto,
	pattern = 'qf',
	callback = function()
		vim.keymap.set('v', 'd', function()
			local esc = api.nvim_replace_termcodes('<esc>', true, false, true)
			api.nvim_feedkeys(esc, 'x', false)
			-- 获取 Quickfix 列表
			local qflist = vim.fn.getqflist()
			-- 获取可视模式选区的起始行
			local from = vim.api.nvim_buf_get_mark(0, '<')[1]
			-- 获取可视模式选区的结束行
			local to = vim.api.nvim_buf_get_mark(0, '>')[1]
			if from > to then
				from, to = to, from
			end
			qflist = remove_quickfix_block(qflist, from, to)
			fn.setqflist(qflist, 'r')
			cmd(tostring(from))
		end, { remap = false, silent = true, buffer = true })
	end,
})


--------------------------------------------------------------------------------
-- netrw 参数设置
--------------------------------------------------------------------------------

-- 历史记录存储路径
local xdg_cache_home = os.getenv('XDG_CACHE_HOME')
if xdg_cache_home ~= nil and xdg_cache_home ~= '' then
	vim.g.netrw_home = fn.expand(xdg_cache_home)
else
	vim.g.netrw_home = fn.expand('~/.cache/')
end
-- 历史记录最大数量
vim.g.netrw_dirhistmax = 10

-- 不显示横幅
vim.g.netrw_banner = 0

-- additional splitting control:
--	netrw_preview	netrw_alto		result
--		0				0			|:aboveleft|
--		0				1			|:belowright|
--		1				0			|:topleft|
--		1				1			|:botright|
-- 窗口分割方式，与 netrw_alto 共同作用
vim.g.netrw_preview = 0
-- 窗口显示位置，与 g:netrw_preview 共同作用
vim.g.netrw_alto = 0

-- 设置目录列表样式为树形
vim.g.netrw_liststyle = 3
-- 设置文件浏览器宽度百分比
vim.g.netrw_winsize = 30

-- 排序依据
vim.g.netrw_sort_by = 'time'
-- 排序选项: 忽略大小写敏感
--G.netrw_sort_options = 'i'
-- 排序方向
vim.g.netrw_sort_direction = 'reverse'

-- 默认的删除工具使用 trash
vim.g.netrw_localrmdir = 'trash'

-- 打开文件使用窗口方式
-- 1 = 用水平拆分窗口打开文件
-- 2 = 用垂直拆分窗口打开文件
-- 3 = 新建标签页打开文件
-- 4 = 用前一个窗口打开文件
vim.g.netrw_browse_split = 4


--------------------------------------------------------------------------------
-- (nvim)开启/关闭宏录制模式时会发送消息通知
--------------------------------------------------------------------------------
local MacroRecording = augroup('MacroRecording', { clear = true })
local _MACRO_RECORDING_STATUS
-- 开始录制宏模式
autocmd('RecordingEnter', {
	callback = function()
		local msg = string.format('Recording "%s', fn.reg_recording())
		_MACRO_RECORDING_STATUS = true
		vim.notify(msg, vim.log.levels.INFO, {
			title = 'Macro Recording Start',
			keep = function() return _MACRO_RECORDING_STATUS end,
		})
	end,
	group = augroup('MacroNotfication', { clear = true })
})
-- 结束录制宏模式
autocmd('RecordingLeave', {
	callback = function()
		local msg = string.format('Recorded @%s', fn.reg_recording())
		_MACRO_RECORDING_STATUS = false
		vim.notify(msg, vim.log.levels.INFO, {
			title = 'Macro Recording Finish',
			timeout = 3000,
		})
	end,
	group = augroup('MacroNotficationDismiss', { clear = true })
})


--------------------------------------------------------------------------------
-- 依据时间段自动启用不同的色彩主题样式
--------------------------------------------------------------------------------
-- 应尽早加载 colorscheme 使其他插件能正确配色
-- local function update_colorscheme()
-- 	if package.loaded['tokyonight'] and package.loaded['vscode'] then
-- 		local hour = tonumber(os.date('%H'))
-- 		-- 白天 9:00-18:00 高对比
-- 		if hour > 8 and hour < 18 then
-- 			cmd('colorscheme vscode')
-- 			--cmd('colorscheme carbonfox')
-- 		-- 晚上 18:00-9:00 低亮度
-- 		else
-- 			cmd('colorscheme tokyonight')
-- 			--cmd('colorscheme duskfox')
-- 		end
-- 	else
-- 		cmd('colorscheme habamax')
-- 	end
-- end
-- autocmd('VimEnter', {
-- 	pattern = '*',
-- 	callback = update_colorscheme,
-- })


--------------------------------------------------------------------------------
-- 操作系统的回车换行符存在差异, 导致剪贴板内容不一致
--------------------------------------------------------------------------------
--[[
-- 解决ArchLinux WSL环境下无法和windows互通剪贴板的问题
if fn.executable('win32yank.exe') == 1 then
	vim.opt.clipboard:append({ 'unnamedplus' })
	G.clipboard = {
		name = 'win32yank',
		copy = {
			['+'] = 'win32yank.exe -i --crlf',
			['*'] = 'win32yank.exe -i --crlf',
		},
		paste = {
			['+'] = 'win32yank.exe -o --lf',
			['*'] = 'win32yank.exe -o --lf',
		},
		cache_enabled = 0,
	}
end
--]]


