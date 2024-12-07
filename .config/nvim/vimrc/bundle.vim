"==============================================================================
"
" bundle.vim - 插件管理器和插件分组字典
"
" 依赖 vim-plug 插件管理器; 使用 plugin.vim 调整插件默认配置
"
" Maintainer: cuitggyy (at) google.com
" Last Modified: 2024/12/07 18:34:17
"
"==============================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"------------------------------------------------------------------------------
" 插件分组字典, 可以在前面覆盖
" 键值
"------------------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = {
				\ 'basic': 1,
				\ 'enhanced': 1,
				\ }
endif


"------------------------------------------------------------------------------
" 计算当前文件的所在路径及 vim 配置文件工作根路径
"------------------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunction


"------------------------------------------------------------------------------
" 自动安装 vim-plug 插件管理器并安装缺失插件
"------------------------------------------------------------------------------
" github 官网不定时抽风，换用镜像地址下载
let s:github_url = 'https://raw.kgithub.com/junegunn/vim-plug/master/plug.vim'

" Run PlugInstall automatic install plugins
if empty(glob(s:home . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.s:home.'/autoload/plug.vim --create-dirs '.s:github_url
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter *
			\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\ | PlugInstall --sync | source $MYVIMRC |
			\ endif


"------------------------------------------------------------------------------
" 默认在当前文件 <sfile>/../bundle 下安装插件
" vim 一般是 ~/.vim/bundle
" neovim 则是 ~/.config/neovim/bundle
"------------------------------------------------------------------------------
silent call plug#begin(get(g:, 'bundle_home', expand(s:home.'/bundle')))


"------------------------------------------------------------------------------
" 基础功能扩展插件
"------------------------------------------------------------------------------
if get(g:bundle_group, 'basic', 0) == 1

	" 复刻 monokai 色彩主题样式
	Plug 'tomasr/molokai'

	" 复刻 xcode 色彩主题样式
	Plug 'arzg/vim-colors-xcode'

	" 复刻 vscode 色彩主题样式
	Plug 'tomasiser/vim-code-dark'

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 国人写的彩虹括号
	Plug 'luochen1990/rainbow'

	" 轻量级状态栏
	Plug 'itchyny/lightline.vim'

	" 可视区域搜索匹配方式的光标快速跳转
	Plug 'easymotion/vim-easymotion'

	" 表格对齐，使用命令 Tabularize
	Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

	" 多光标同时编辑插件
	Plug 'mg979/vim-visual-multi'

	" 基于 Text-Object 两端匹配符号对编辑插件
	Plug 'tpope/vim-surround'

	" 代码注释插件; 自定义扩展性较好
	Plug 'preservim/nerdcommenter'

	" 国人新近括号自动补全
	Plug 'jiangmiao/auto-pairs'

endif


"------------------------------------------------------------------------------
" 进阶功能增强插件
"------------------------------------------------------------------------------
if get(g:bundle_group, 'enhanced', 0) == 1

	" 后台异步运行 shell 命令插件
	Plug 'skywind3000/asyncrun.vim'

	" 基于 asyncrun.vim 插件功能像 vscode 的 task system 一样
	Plug 'skywind3000/asynctasks.vim'

	" 基于 Vim8.1 +popup 特性的终端 UI 插件
	Plug 'skywind3000/vim-quickui'

	" 基于字典的轻量级代码补全系统
	Plug 'skywind3000/vim-auto-popmenu', { 'on':'ApcEnable', }

	" 代码补全字典
	Plug 'skywind3000/vim-dict', { 'on':'ApcEnable', }

	" 语法高亮代码缩进全家桶
	"Plug 'sheerun/vim-polyglot'

	" 文本对象全家桶
	"Plug 'kana/vim-textobj-user'
	"Plug 'kana/vim-textobj-indent'
	"Plug 'kana/vim-textobj-syntax'
	"Plug 'sgur/vim-textobj-parameter'
	"Plug 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim',] }
	"Plug 'jceb/vim-textobj-uri'
	"Plug 'bps/vim-textobj-python', { 'for': 'python' }

endif


"------------------------------------------------------------------------------
" 进阶功能增强插件
"------------------------------------------------------------------------------
if get(g:bundle_group, 'alternative', 0) == 1

	" 结合 vim-easymotion 和 vim-sneak 各自优点; 仅支持 neovim 0.7+
	" BUG: 在 macos iterm2 环境下无法触发其核心功能快捷键 's'
	Plug 'ggandor/leap.nvim'

	" 重量级状态栏
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" 重量级目录树
	Plug 'preservim/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

	" 基于 Text-Object 代码注释插件; 简洁高效但功能偏弱
	Plug 'tpope/vim-commentary'

	" 老外上古括号自动补全
	Plug 'Raimondi/delimitMate'

	" Vim 8.1+ 内嵌终端助手;
	" BUG: 在 macos iterm2 环境下键码冲突
	Plug 'skywind3000/vim-terminal-help'

endif

"------------------------------------------------------------------------------
" 结束插件安装, 并根据插件安装情况, 生成插件使用列表
" 方便后续 plugin.vim 针对正在使用的插件调整参数更改配置
"------------------------------------------------------------------------------
silent call plug#end()

