---------------------------------------------------------------------------------
--
-- vim-plug.lua - 插件管理器及插件装配
--
-- 使用 plugin.lua 调整 lua 插件默认配置
-- 使用 plugin.vim 调整 vim 插件默认配置
--
-- Maintainer: cuitggyy (at) google.com
-- Last Modified: 2025/03/26 02:50:54
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 变量重命名与函数预定义
--------------------------------------------------------------------------------
local vim, G = vim, vim.g
local api, call = vim.api, vim.call
local cmd, fn = vim.cmd, vim.fn
local opt, fs = vim.opt, vim.fs
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


--------------------------------------------------------------------------------
-- 插件分组字典: 0 禁用分组, 1 启用分组
--------------------------------------------------------------------------------
if type(_G.plugged) ~= 'table' then
	_G.plugged = {
		['deps'] = true,
		['plug'] = false,
	}
end


--------------------------------------------------------------------------------
-- 设定配置文件及插件安装目录路径
--------------------------------------------------------------------------------
-- lua 插件默认安装目录
local pack_deps = fs.joinpath(fn.stdpath('config'), 'pack', 'deps', 'opt')
-- vim 插件默认安装目录
local pack_plug = fs.joinpath(fn.stdpath('config'), 'pack', 'plug', 'opt')

-- 添加`pack_deps`运行路径
opt.runtimepath:prepend(pack_deps)
-- 添加`pack_plug`运行路径
opt.runtimepath:prepend(pack_plug)


--------------------------------------------------------------------------------
-- 自动安装`vim-plug`插件管理器并安装缺失插件
--------------------------------------------------------------------------------

-- 从 github 克隆 vim-plug 仓库
local plug_path = fs.joinpath(pack_plug, 'vim-plug')
if not (vim.uv or vim.loop).fs_stat(plug_path) and fn.executable('git') then
	local plug_repo = 'https://github.com/junegunn/vim-plug.git'
	local git_clone = {
		'git', 'clone', '--filter=blob:none',
		-- Uncomment next line to use 'stable' branch
		-- '--branch', 'stable',
		plug_repo, plug_path
	}
	local out = fn.system(git_clone)
	if vim.v.shell_error ~= 0 then
		api.nvim_echo({
			{ 'Failed to clone vim-plug:\n', 'ErrorMsg' },
			{ plug_vim, 'WarningMsg' },
			{ "\nPress any key to exit..." },
		}, true, {})
		fn.getchar()
		os.exit(1)
	end
end

-- 从 github 下载 vim-plug 文件
local plug_file = fs.joinpath(pack_plug, 'vim-plug', 'plug.vim')
if not (vim.uv or vim.loop).fs_stat(plug_file) and fn.executable('curl') then
	local plug_vim = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	local curl_fetch = { 'curl', '-fLo', plug_file, '--create_dirs', plug_vim }
	local out = fn.system(curl_fetch)
	if vim.v.shell_error ~= 0 then
		api.nvim_echo({
			{ 'Failed to fetch plug.vim:\n', 'ErrorMsg' },
			{ plug_file, 'WarningMsg' },
			{ "\nPress any key to exit..." },
		}, true, {})
		fn.getchar()
		os.exit(1)
	end
end

-- 加载插件管理器文件并初始化
if fn.filereadable(plug_file) then
	fn.execute('source ' .. plug_file)
else
	api.nvim_echo({
		{ 'Failed to source file:\n', 'ErrorMsg' },
		{ plug_file, 'WarningMsg' },
		{ "\nPress any key to exit..." },
	}, true, {})
	fn.getchar()
	os.exit(1)
end


-- 若缺失插件则执行`PlugInstall`自动安装
autocmd('VimEnter', {
	pattern = '*',
	callback = function()
		print(vim.inspect(G.plugs))
		if G.plugs == nil then return end

		local missing = {}
		for _, plug in ipairs(G.plugs) do
			if not fn.isdirectory(plug.dir) then
				table.insert(missing, plug)
			end
		end

		print(vim.inspect(G.plugs))
		print(vim.inspect(missing))

		--if #missing > 0 then
		--    cmd('PlugInstall --sync | source $MYVIMRC')
		--end
	end,
})


--------------------------------------------------------------------------------
-- 用于 nvim 的`lua 脚本`插件
--------------------------------------------------------------------------------
if _G.plugged.pack_deps then

	local Plug = fn['plug#']

	-- `plug#begin()`函数的唯一参数是`g:plug_home`只读变量
	-- `g:plug_home`插件存储加载路径默认在`g:pack_plug`目录
	call('plug#begin', pack_deps)

	-- 实用的独立模块插件库
	Plug('echasnovski/mini.nvim')

	-- 复刻 vscode 的 tokyonight.nvim 色彩主题样式
	Plug('folke/tokyonight.nvim')

	-- `暗夜之狐`色彩主题样式
	--Plug('EdenEast/nightfox.nvim')

	-- 复刻 vscode 色彩主题样式
	Plug('Mofiqul/vscode.nvim')

	-- nerdfont 字体图标库
	Plug('nvim-tree/nvim-web-devicons')

	-- lua 版轻量级状态栏
	Plug('nvim-lualine/lualine.nvim')

	-- akinsho/bufferline.nvim
	--Plug('akinsho/bufferline.nvim')

	-- 更有用的起始欢迎界面, 显示最近编辑过的文件
	Plug('nvimdev/dashboard-nvim')

	-- 代码注释, 支持 treesitter
	Plug('numToStr/Comment.nvim')

	-- 用于在侧边符号栏显示`marks`(ma-mz 记录的位置)
	Plug('chentoast/marks.nvim')

	-- 结合 vim-easymotion 和 vim-sneak 各自优点; 要求 nvim 0.7+
	Plug('ggandor/leap.nvim')

	-- 终端会话管理器
	Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' } )

	-- fzf, fuzzyfind 模糊搜索
	Plug('nvim-lua/plenary.nvim')
	Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })

	-- 功能强大的 quickfix 列表窗口
	Plug('kevinhwang91/nvim-bqf')

	-- 简洁实用的 quickfix 窗口
	--Plug('stevearc/quicker.nvim')

	-- 代码语法高亮解析器
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function() vim.cmd('TSUpdate') end })

	-- LSP, DAP, linter, formatter 代码语言服务管理器
	Plug('williamboman/mason.nvim')
	Plug('williamboman/mason-lspconfig.nvim')
	Plug('neovim/nvim-lspconfig')

	-- 有历史记录且简洁的消息通知管理器
	-- Extensible UI for Neovim notifications and LSP progress messages
	Plug('j-hui/fidget.nvim')

	-- 有历史记录且被广泛支持的消息通知管理器
	-- A fancy, configurable, notification manager for NeoVim
	--Plug('rcarriga/nvim-notify')

	-- 用户接口组件库
	-- UI Component Library for Neovim.
	--Plug('MunifTanjim/nui.nvim')

	-- 深度魔改 neovim 操作界面
	-- replaces the UI for messages, cmdline and the popupmenu
	--Plug('folke/noice.nvim')

	-- 结束插件安装, 并根据插件安装情况, 生成插件使用列表
	-- 方便后续 plugin.lua 针对正在使用的插件调整参数更改配置
	call('plug#end')

	-- 依据时间段自动启用不同的色彩主题样式
	if package.loaded['tokyonight'] and package.loaded['vscode'] then
		local hour = tonumber(os.date('%H'))
		-- 白天 9:00-18:00 高对比
		if hour > 8 and hour < 18 then
			cmd('colorscheme vscode')
			--cmd('colorscheme carbonfox')
		-- 晚上 18:00-9:00 低亮度
		else
			cmd('colorscheme tokyonight')
			--cmd('colorscheme duskfox')
		end
	else
		cmd('colorscheme habamax')
	end

end


--------------------------------------------------------------------------------
-- vim使用的vim脚本插件
--------------------------------------------------------------------------------
if _G.plugged.pack_plug then

	local Plug = fn['plug#']

	-- `plug#begin()`函数的唯一参数是`g:plug_home`只读变量
	-- `g:plug_home`插件存储加载路径默认在`g:pack_plug`目录
	call('plug#begin', pack_plug)

	---- 基础功能 ----

	-- 复刻 monokai 色彩主题样式
	Plug('tomasr/molokai')

	-- 复刻 xcode 色彩主题样式
	--Plug('arzg/vim-colors-xcode')

	-- 复刻 vscode 色彩主题样式
	Plug('tomasiser/vim-code-dark')

	-- 轻量级状态栏
	Plug('itchyny/lightline.vim')

	-- 展示开始画面, 显示最近编辑过的文件
	Plug('mhinz/vim-startify')

	-- 彩虹括号
	Plug('luochen1990/rainbow')

	-- 括号自动补全
	Plug('jiangmiao/auto-pairs')

	-- 基于`Text-Object`两端匹配符号对编辑
	Plug('tpope/vim-surround')

	-- 表格对齐, 使用命令`Tabularize`
	Plug('godlygeek/tabular', { ['on'] = 'Tabularize' })

	-- 用于在侧边符号栏显示`marks`(ma-mz 记录的位置)
	Plug('kshenoy/vim-signature')

	-- 可视区域搜索匹配方式的光标快速跳转
	--Plug('easymotion/vim-easymotion')

	-- 简易版可视区域搜索匹配方式的光标快速跳转
	Plug('justinmk/vim-sneak')

	-- 多光标同时编辑
	Plug('mg979/vim-visual-multi')

	-- 代码注释插件, 自定义扩展性较好
	Plug('preservim/nerdcommenter')

	-- 支持 ANSI OSC52 控制序列码
	--Plug('ojroques/vim-oscyank', { ['branch'] = 'main' })

	---- 高级扩展 ----

	-- 后台异步运行 shell 命令
	Plug('skywind3000/asyncrun.vim')

	-- 基于 asyncrun.vim 插件功能像 vscode 的 task system 一样
	Plug('skywind3000/asynctasks.vim')

	-- Vim8.1+ 内嵌终端助手;
	Plug('skywind3000/vim-terminal-help')

	-- 基于 Vim8.1+ `popup`特性的终端 UI
	Plug('skywind3000/vim-quickui')

	-- 基于字典的轻量级代码补全系统
	Plug('skywind3000/vim-auto-popmenu', { ['on'] = 'ApcEnable' })

	-- 代码补全字典
	Plug('skywind3000/vim-dict', { ['on'] = 'ApcEnable' })

end


