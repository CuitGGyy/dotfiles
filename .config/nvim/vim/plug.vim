"===============================================================================
"
" plug.vim - vim-plug 插件管理器及插件库装配
"
" 使用 tweak.vim 调整 vim 插件默认配置
"
" Maintainer: cuitggyy (at) google.com
" Last Modified: 2025/03/26 02:52:24
"
"===============================================================================


"------------------------------------------------------------------------------
" 插件分组字典: `0`禁用分组, `1`启用分组
"------------------------------------------------------------------------------
if !exists('s:plugged') || type(s:plugged) != v:t_dict
	let s:plugged = {
				\ 'plug': 1,
				\ 'deps': 0,
				\ }
endif


"------------------------------------------------------------------------------
" 设定配置文件及插件安装目录路径
"------------------------------------------------------------------------------
let s:nvim = expand('$XDG_CONFIG_HOME/nvim')
if s:nvim == '/nvim'
	let s:nvim = expand('~/.config/nvim')
endif
" vim 插件默认安装目录
let g:pack_plug = fnameescape(s:nvim . '/pack/plug/opt')
" nvim 插件默认安装目录
let g:pack_deps = fnameescape(s:nvim . '/pack/deps/opt')


"------------------------------------------------------------------------------
" 自动安装`vim-plug`插件管理器并安装缺失插件
"------------------------------------------------------------------------------
" 从 github 克隆 vim-plug 仓库
if !isdirectory(glob(g:pack_plug . '/vim-plug')) && executable('git')
	let s:plug_repo = 'https://github.com/junegunn/vim-plug.git'
	execute '!git clone --filter=blob:none ' . s:plug_repo . ' ' . g:pack_plug . '/vim-plug'
endif

" 从 github 下载 vim-plug 文件
"if empty(glob(g:pack_plug . '/vim-plug/plug.vim')) && executable('curl')
"    let s:plug_file = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"    execute '!curl -fLo ' . g:pack_plug . '/vim-plug/plug.vim --create-dirs ' . s:plug_file
"endif

" 加载插件管理器文件并初始化
if filereadable(g:pack_plug . '/vim-plug/plug.vim')
	execute 'source ' . g:pack_plug . '/vim-plug/plug.vim'
else
	echom 'Failed to source file: ' . g:pack_plug . '/vim-plug/plug.vim'
	finish
endif

" 若缺失插件则执行`PlugInstall`自动安装
autocmd VimEnter *
			\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\ | PlugInstall --sync | source $MYVIMRC |
			\ endif


"------------------------------------------------------------------------------
" 用于 vim 的`vim 脚本`插件
"------------------------------------------------------------------------------
if get(s:plugged, 'plug', 0) == 1

	" `plug#begin()`函数的唯一参数是`g:plug_home`只读变量
	" `g:plug_home`插件存储加载路径默认在`g:pack_plug`目录
	silent call plug#begin(g:pack_plug)

	" 添加 vim-plug 自己
	Plug 'junegunn/vim-plug'

	"---- 基础功能 ----

	" 复刻 monokai 色彩主题样式
	Plug 'tomasr/molokai'

	" 复刻 vscode 色彩主题样式
	Plug 'tomasiser/vim-code-dark'

	" 复刻 xcode 色彩主题样式
	Plug 'arzg/vim-colors-xcode'

	" 轻量级状态栏
	Plug 'itchyny/lightline.vim'

	" 更有用的起始欢迎界面, 显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 彩虹括号
	Plug 'luochen1990/rainbow'

	" 括号自动补全
	Plug 'jiangmiao/auto-pairs'

	" 基于`Text-Object`两端匹配符号对编辑
	Plug 'tpope/vim-surround'

	" 表格对齐, 使用命令`Tabularize`
	Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

	" 用于在侧边符号栏显示`marks`(ma-mz 记录的位置)
	Plug 'kshenoy/vim-signature'

	" 可视区域搜索匹配方式的光标快速跳转
	Plug 'easymotion/vim-easymotion'

	" 简易版可视区域搜索匹配方式的光标快速跳转
	""Plug 'justinmk/vim-sneak'

	" 多光标同时编辑
	Plug 'mg979/vim-visual-multi'

	" 代码注释插件, 自定义扩展性较好
	Plug 'preservim/nerdcommenter'

	" 支持 ANSI OSC52 控制序列码
	"Plug 'ojroques/vim-oscyank', { 'branch': 'main' }

	"---- 高级扩展 ----

	" 后台异步运行 shell 命令
	Plug 'skywind3000/asyncrun.vim'

	" 基于 asyncrun.vim 插件功能像 vscode 的 task system 一样
	Plug 'skywind3000/asynctasks.vim'

	" Vim8.1+ 内嵌终端助手;
	Plug 'skywind3000/vim-terminal-help'

	" 基于 Vim8.1+ `popup`特性的终端 UI
	Plug 'skywind3000/vim-quickui'

	" 基于字典的轻量级代码补全系统
	Plug 'skywind3000/vim-auto-popmenu', { 'on':'ApcEnable', }

	" 代码补全字典
	Plug 'skywind3000/vim-dict', { 'on':'ApcEnable', }

	" 结束插件安装, 并根据插件安装情况, 生成插件使用列表
	" 方便后续`plugin.vim`针对正在使用的插件调整参数更改配置
	silent call plug#end()

endif


"------------------------------------------------------------------------------
" 用于 nvim 的 lua 脚本插件
"------------------------------------------------------------------------------
if has('nvim') && get(s:plugged, 'deps', 0) == 1

	" `plug#begin()`函数的唯一参数是`g:plug_home`只读变量
	" `g:plug_home`插件存储加载路径默认在`g:pack_deps`目录
	silent call plug#begin(g:pack_deps)

	" mini.nvim 独立模块插件库
	Plug 'echasnovski/mini.nvim'

	" `东京之夜`色彩主题样式
	Plug 'folke/tokyonight.nvim'

	" `暗夜之狐`色彩主题样式
	"Plug 'EdenEast/nightfox.nvim'

	" 复刻 vscode 色彩主题样式
	Plug 'Mofiqul/vscode.nvim'

	" nerdfont 字体图标库
	Plug 'nvim-tree/nvim-web-devicons'

	" lua 版轻量级状态栏
	Plug 'nvim-lualine/lualine.nvim'

	" akinsho/bufferline.nvim
	"Plug 'akinsho/bufferline.nvim'

	" 更有用的起始欢迎界面, 显示最近编辑过的文件
	Plug 'nvimdev/dashboard-nvim'

	" 代码注释, 支持 treesitter
	Plug 'numToStr/Comment.nvim'

	" 用于标记位置, 在侧边符号栏显示标记, 方便光标回跳
	Plug 'chentoast/marks.nvim'

	" 结合 vim-easymotion 和 vim-sneak 各自优点; 要求 nvim 0.7+
	Plug 'ggandor/leap.nvim'

	" 终端会话管理器
	Plug 'akinsho/toggleterm.nvim', { 'tag': '*' }

	" fzf, fuzzyfind 模糊搜索
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

	" 功能强大的 quickfix 列表窗口
	Plug 'kevinhwang91/nvim-bqf'

	" 简洁实用的 quickfix 窗口
	"Plug 'stevearc/quicker.nvim'

	" 代码语法高亮解析器
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

	" LSP, DAP, linter, formatter 代码语言服务管理器
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

	"""" vim 不支持 notify 消息通知机制, 下列插件仅 nvim 可用

	" 有历史记录且简洁的消息通知管理器
	" Extensible UI for Neovim notifications and LSP progress messages
	"Plug 'j-hui/fidget.nvim'

	" 有历史记录且被广泛支持的消息通知管理器
	" A fancy, configurable, notification manager for NeoVim
	"Plug('rcarriga/nvim-notify')

	" 用户接口组件库
	" UI Component Library for Neovim.
	"Plug 'MunifTanjim/nui.nvim'

	" 深度魔改 neovim 操作界面
	" replaces the UI for messages, cmdline and the popupmenu
	"Plug 'folke/noice.nvim'

	" 结束插件安装, 并根据插件安装情况, 生成插件使用列表
	" 方便后续`plugin.lua`针对正在使用的插件调整参数更改配置
	silent call plug#end()

endif


