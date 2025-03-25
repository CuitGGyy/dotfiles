--------------------------------------------------------------------------------
--
-- keymap.lua - 按键功能绑定映射
--
-- 详细说明参考: https://yianwillis.github.io/vimcdoc/doc/map.html
-- 依赖终端或系统的键码识别, 可结合键盘键位布局及键码识别情况予以修改
--
-- Maintainer: cuitggyy (at) gmail.com
-- Last Modified: 2025/03/26 05:32:55
--
--------------------------------------------------------------------------------


--[[
--------------------------------------------------------------------------------

	有七种映射存在
	- 用于普通模式: 输入命令时。
	- 用于可视模式: 可视区域高亮并输入命令时。
	- 用于选择模式: 类似于可视模式，但键入的字符对选择区进行替换。
	- 用于操作符等待模式: 操作符等待中 ("d"，"y"，"c" 等等之后)。
	- 用于插入模式: 也用于替换模式。
	- 用于命令行模式: 输入 ":" 或 "/" 命令时。
	- 用于终端模式: 在  :terminal  缓冲区里输入时。

	特殊情况: 当在普通模式里为一个命令输入一个计数时，对 0 的映射会被禁用。这样在
	输入一个带有 0 的计数时不会受到对 0 键映射的干扰。


	关于每个映射命令对应的工作模式的概况。详情见下。
		命 令                       模 式
	:map   :noremap  :unmap     普通、可视、选择、操作符等待
	:nmap  :nnoremap :nunmap    普通
	:vmap  :vnoremap :vunmap    可视与选择
	:smap  :snoremap :sunmap    选择
	:xmap  :xnoremap :xunmap    可视
	:omap  :onoremap :ounmap    操作符等待
	:map!  :noremap! :unmap!    插入与命令行
	:imap  :inoremap :iunmap    插入
	:lmap  :lnoremap :lunmap    插入、命令行、Lang-Args
	:cmap  :cnoremap :cunmap    命令行
	:tmap  :tnoremap :tunmap    终端作业


	同样的信息用表格总结一下:
															map-table
			模式   | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
	命令           +------+-----+-----+-----+-----+-----+------+------+
	[nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
	n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
	[nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
	i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
	c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
	v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
	x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
	s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
	o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
	t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
	l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |

--------------------------------------------------------------------------------
--]]


--------------------------------------------------------------------------------
-- 变量重命名与函数预定义
--------------------------------------------------------------------------------
local api, fn, cmd = vim.api, vim.fn, vim.cmd
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local map = vim.keymap.set
local opt = { remap = false, silent = true }


--------------------------------------------------------------------------------
-- 设定 Vim 的 <leader> 键位
--------------------------------------------------------------------------------
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"


--------------------------------------------------------------------------------
-- Vim 常用功能键位
--------------------------------------------------------------------------------

-- 快速保存
map('', '<leader>w', ':write<cr>', opt)
-- sudo 权限快速保存
--map('', '<leader>W', ':write !sudo tee % > /dev/null', opt)

-- 快速退出
map('', '<leader>q', ':quit<cr>', opt)
-- 全部保存并退出
map('', '<leader>Q', ':quit!<cr>', opt)
--map('', '<leader>Q', ':confirm quitall<cr>', opt)

-- 选择全部
map('', '<leader>V', 'ggvG', opt)

-- 关闭高亮显示
map('', '<leader><space>', ':nohl<cr>', opt)

-- 去除文件编码格式匹配错误时行尾多余的`^M`
map('', '<leader>M', "mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm")

-- PASTE 粘贴模式开关键位
map('', '<leader>p', ':set invpaste<cr>', opt)
-- 离开 INSERT 模式自动关闭 PASTE 粘贴模式
autocmd('InsertLeave', {
	pattern = '*',
	callback = function()
		vim.opt.paste = false
	end,
})

-- <Shift>+<Insert>粘贴系统剪贴板内容
map({'', '!'}, '<s-insert>', '"+gp', opt)

-- 复制到X11主选择区(primary selection)
--map('', '<leader>y', '"*y', opt)
-- 复制到系统剪贴板(clipboard)
--map('', '<leader>y', '"+y', opt)

-- `瘟到死`系统祖传默认键位
--map({'', '!'}, '<c-c>', '"+y', opt)
--map({'', '!'}, '<c-v>', '"+gp', opt)


--------------------------------------------------------------------------------
-- NORMAL, VISTUAL, SELECT, OPERATOR-OPENDING, INSERT, COMMAND
-- 在上述模式下, 使用 EMACS 风格移动光标键位
--------------------------------------------------------------------------------
map({'', '!', 't'}, '<c-k>', '<up>', opt)
map({'', '!', 't'}, '<c-j>', '<down>', opt)
map({'', '!', 't'}, '<c-h>', '<left>', opt)
map({'', '!', 't'}, '<c-l>', '<right>', opt)
map({'', '!', 't'}, '<c-a>', '<home>', opt)
map({'', '!', 't'}, '<c-e>', '<end>', opt)
map({'', '!', 't'}, '<c-d>', '<del>', opt)


--------------------------------------------------------------------------------
-- VISUAL 模式下搜索选定内容
--------------------------------------------------------------------------------

--[[
-- COMMAND 模式执行命令字符串
local function CmdLine(str)
	fn.feedkeys(':' .. str)
end
-- VISUAL 模式获取选定内容
local function VisualSelection()
	local s_start = fn.getpos("'<")
	local s_end = fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, '\n')
end
--]]

-- VISUAL 模式按下 < 或 > 键缩进后保持选定可连续缩进
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- NORMAL 模式按下一次 < 或 > 键即可单行左右缩进一次
map('n', '<', '<<', opt)
map('n', '>', '>>', opt)


--------------------------------------------------------------------------------
-- <leader>+数字键 切换[Tab]标签页
--------------------------------------------------------------------------------
map('', '<leader>1', '1gt<cr>', opt)
map('', '<leader>2', '2gt<cr>', opt)
map('', '<leader>3', '3gt<cr>', opt)
map('', '<leader>4', '4gt<cr>', opt)
map('', '<leader>5', '5gt<cr>', opt)
map('', '<leader>6', '6gt<cr>', opt)
map('', '<leader>7', '7gt<cr>', opt)
map('', '<leader>8', '8gt<cr>', opt)
map('', '<leader>9', '9gt<cr>', opt)
map('', '<leader>0', '10gt<cr>', opt)


--------------------------------------------------------------------------------
-- <Tab>+数字键 切换[Tab]标签页
-- 所有[Tab]标签页功能触发前导键位全部设定为<Tab>键
--------------------------------------------------------------------------------
map('', '<tab>1', '1gt<cr>', opt)
map('', '<tab>2', '2gt<cr>', opt)
map('', '<tab>3', '3gt<cr>', opt)
map('', '<tab>4', '4gt<cr>', opt)
map('', '<tab>5', '5gt<cr>', opt)
map('', '<tab>6', '6gt<cr>', opt)
map('', '<tab>7', '7gt<cr>', opt)
map('', '<tab>8', '8gt<cr>', opt)
map('', '<tab>9', '9gt<cr>', opt)
map('', '<tab>0', '10gt<cr>', opt)


--------------------------------------------------------------------------------
-- [Tab]标签页: 创建, 关闭, 上一个, 下一个, 左移, 右移
-- 其实还可以用原生的<Ctrl>+<PgUp>, <Ctrl>+<PgDn>来切换标签
--------------------------------------------------------------------------------
map('', '<tab>n', ':tabnew<cr>', opt)
map('', '<tab>c', ':tabclose<cr>', opt)
map('', '<tab><insert>', ':tabnew<cr>', opt)
map('', '<tab><delete>', ':tabclose<cr>', opt)

-- 在一个新[Tab]标签页打开内嵌终端
map('', '<tab>t', ':tab terminal<cr>', opt)

-- 仅保留当前[Tab]标签页，关闭其他所有[Tab]标签页
map('', '<tab>o', ':tabonly<cr>', opt)

-- 用[Tab]标签页显示所有缓冲区
map('', '<tab>s', ':tab sball<cr>', opt)

-- 在当前路径下以新[Tab]标签页打开文件
map('', '<tab>e', ':tabedit <c-r>=expand("%:p:h")<cr>/')
-- 返回家目录以新[Tab]标签页打开文件
map('', '<tab>E', ':tabedit <c-r>=expand("~")<cr>/')

-- 所有[Tab]标签页循环显示
map('', '<tab>]', ':tabnext<cr>', opt)
map('', '<tab>[', ':tabprevious<cr>', opt)

-- 左移[Tab]标签页
map('', '<tab><tab>[', ':-tabmove<cr>', opt)
-- 右移[Tab]标签页
map('', '<tab><tab>]', ':+tabmove<cr>', opt)

-- 当前[Tab]标签页与上一个[Tab]标签页之间两者循环切换
if vim.g.last_tab == nil then
	vim.g.last_tab = api.nvim_tabpage_get_number(0)
end
local last_tab = augroup('last_tab', { clear = true })
autocmd('TabLeave', {
	group = last_tab,
	pattern = '*',
	callback = function()
		vim.g.last_tab = api.nvim_tabpage_get_number(0)
	end,
})
map('', '<s-tab>', function()
	cmd('tabnext ' .. vim.g.last_tab)
end, opt)


--------------------------------------------------------------------------------
-- 寄存器, 缓冲区及分割窗口: 创建, 删除, 下一个, 上一个, 左移, 右移
--------------------------------------------------------------------------------
-- 查看寄存器列表
map('', '<leader>lr', ':register<cr>', opt)

-- 查看缓冲区列表
map('', '<leader>ls', ':buffers<cr>', opt)
-- 打开 buffer 缓冲区
map('', '<leader><leader>b', ':buffers<cr>:buffer ')

-- 在当前路径下以当前缓冲区打开文件
map('', '<leader>e', ':edit <c-r>=expand("%:p:h")<cr>/')
-- 在当前缓冲区返回家目录打开文件
map('', '<leader>E', ':edit <c-r>=expand("~")<cr>/')

-- 横向等距分割当前窗口
map('', '<leader>sp', ':split<cr>:blast<cr>', opt)
-- 纵向等距分割当前窗口
map('', '<leader>vs', ':vsplit<cr>:blast<cr>', opt)

-- 横向等距分割窗口显示所有缓冲区
map('', '<leader>ba', ':ball<cr>', opt)
-- 纵向等距分割窗口显示所有缓冲区
map('', '<leader>bv', ':vertical ball<cr>', opt)

-- 跳转到下一个已被修改的缓冲区
map('', '<leader>bm', ':bmodified<cr>', opt)

-- 当前窗口删除当前缓冲区
map('', '<leader>bd', ':bdelete!<cr>', opt)

-- 当前窗口切换缓冲区
map('', '<leader>b]', ':bnext<cr>', opt)
map('', '<leader>b[', ':bprevious<cr>', opt)

-- 在当前窗口与上一个缓冲区之间循环切换
if vim.g.last_buf == nil then
	vim.g.last_buf = api.nvim_buf_get_number(0)
end
local last_buf = augroup('last_buf', { clear = true })
autocmd('BufLeave', {
	group = last_buf,
	pattern = '*',
	callback = function()
		vim.g.last_buf = api.nvim_buf_get_number(0)
	end,
})
map('', '<leader>bb', function()
	cmd('buffer ' .. vim.g.last_buf)
end, opt)


--------------------------------------------------------------------------------
-- 内置终端窗口
--------------------------------------------------------------------------------
-- 在左上分割窗口打开终端
--map('', '<m-`>', ':leftabove terminal<cr>', opt)
-- 在右下分割窗口打开终端
map('', '<m-\\>', ':rightbelow terminal<cr>', opt)


--------------------------------------------------------------------------------
-- 快速修复列表
--------------------------------------------------------------------------------
-- 遍历所有窗口检查 quickfix 列表缓冲区存在状态
local function is_quickfix_open()
	for _, win in ipairs(api.nvim_list_wins()) do
		local buf = api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == 'quickfix' then
			return true
		end
	end
	return false
end

-- 映射 quickfix 列表开关
map('', '<tab>q', function()
	if is_quickfix_open() then return cmd('cclose') end
	return cmd('copen 15')
end, opt)
-- 映射 quickfix 窗口开关
map('', '<f4>', function()
	if is_quickfix_open() then return cmd('cclose') end
	return cmd('cwindow 15')
end, opt)


--------------------------------------------------------------------------------
-- 窗口切换: <Ctrl>+hjkl
-- 分割窗口缓冲区的光标移动键位
--------------------------------------------------------------------------------
map('', '<c-k>', '<c-w>k', opt)
map('', '<c-j>', '<c-w>j', opt)
map('', '<c-h>', '<c-w>h', opt)
map('', '<c-l>', '<c-w>l', opt)
map('', '<c-,>', '<c-w>p', opt)
map('!', '<c-k>', '<esc><c-w>k', opt)
map('!', '<c-j>', '<esc><c-w>j', opt)
map('!', '<c-h>', '<esc><c-w>h', opt)
map('!', '<c-l>', '<esc><c-w>l', opt)
map('!', '<c-,>', '<esc><c-w>p', opt)

--------------------------------------------------------------------------------
-- 窗口切换: <Tab>+hjkl, <Tab>+上下左右
-- 分割窗口缓冲区的光标移动键位
--------------------------------------------------------------------------------
-- <Tab>+hjkl
map('', '<tab>k', '<c-w>k', opt)
map('', '<tab>j', '<c-w>j', opt)
map('', '<tab>h', '<c-w>h', opt)
map('', '<tab>l', '<c-w>l', opt)
map('', '<tab>,', '<c-w>p', opt)

-- <Tab>+上下左右
map('', '<tab><up>', '<c-w>k', opt)
map('', '<tab><down>', '<c-w>j', opt)
map('', '<tab><left>', '<c-w>h', opt)
map('', '<tab><right>', '<c-w>l', opt)
map('', '<tab><backspace>', '<c-w>p', opt)


--------------------------------------------------------------------------------
-- TERMINAL 内嵌终端
--------------------------------------------------------------------------------
-- 终端窗口切换
map('t', '<tab><up>', '<c-\\><c-n><c-w>k', opt)
map('t', '<tab><down>', '<c-\\><c-n><c-w>j', opt)
map('t', '<tab><left>', '<c-\\><c-n><c-w>h', opt)
map('t', '<tab><right>', '<c-\\><c-n><c-w>l', opt)
map('t', '<tab><backspace>', '<c-\\><c-n><c-w>p', opt)

-- 脱离终端插入编辑(INSERT)进入终端选择视图(VISUAL)
map('t', '<tab><leader>', '<c-\\><c-n>', opt)


--------------------------------------------------------------------------------
-- 文件对比 Diff
--------------------------------------------------------------------------------
map('', '<leader>do', ':DiffOrig<cr>', opt)
map('', '<leader>dq', ':diffoff!<cr>', opt)
map('', '<leader>dt', ':diffthis<cr>', opt)
map('', '<leader>du', ':diffupdate<cr>', opt)
map('', '<leader>ds', ':vertical diffsplit <c-r>=expand("%:p:h")<cr>/')
map('', '<leader>dp', ':vertical diffpatch <c-r>=expand("%:p:h")<cr>/')


--------------------------------------------------------------------------------
-- netrw 文件管理器
--------------------------------------------------------------------------------
if package.loaded['mini.files'] then
	-- Toggle MminiFiles
	map({'', '!'}, '<m-e>', function()
		if not MiniFiles.close() then MiniFiles.open() end
	end, opt)
else
	-- toggle netrw
	map({'', '!'}, '<m-e>', ':Lexplore<cr>', opt)
end


--------------------------------------------------------------------------------
-- 拼写检查 Spell
--------------------------------------------------------------------------------
--map('', '<leader>zs', ':setlocal spell spelllang=en_us<cr>', opt)


