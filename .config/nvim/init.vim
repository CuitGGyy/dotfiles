"======================================================================
"
" init.vim - 初始化配置
"
" 兼容 neovim 启动方式
"
" Maintainer: cuitggyy (at) gmail.com
" Last Modified: 2023/01/06 10:47:02
"
"======================================================================

" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个命令用来加载文件
command! -nargs=1 LoadScript execute 'source '. fnameescape(s:home. '/'. '<args>')

" 将 init 目录加入 runtimepath
execute 'set rtp+='. fnameescape(s:home)

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
"execute 'set rtp+=~/.vim'
"execute 'set rtp+=~/.config/nvim'
if $XDG_CONFIG_HOME != ''
	execute 'set rtp+=' . expand($XDG_CONFIG_HOME . '/nvim')
else
	execute 'set rtp+=' . expand('~/.config/nvim')
endif


"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 加载插件分组
LoadScript vimrc/bundle.vim

" 加载基础配置
LoadScript vimrc/basic.vim

" 加载插件配置
LoadScript vimrc/plugin.vim

" 加载扩展配置
LoadScript vimrc/enhanced.vim

" 自定义按键
LoadScript vimrc/keymaps.vim


"----------------------------------------------------------------------
" 本地配置
"----------------------------------------------------------------------
if has('nvim') == 0
	let name = expand('~/.vim/local.vim')
else
	if $XDG_CONFIG_HOME != ''
		let name = $XDG_CONFIG_HOME . '/nvim/local.vim'
	else
		let name = expand('~/.config/nvim/local.vim')
	endif
endif

if filereadable(name)
	exec 'source ' . fnameescape(name)
endif


