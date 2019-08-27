#  **VimRC**

[汉语](https://github.com/CuitGGyy/VimRC/blob/master/README.zh_CN.md)
[English](https://github.com/CuitGGyy/VimRC/blob/master/README.md)


这只是我的 Vim 配置文件, 虽然代码基于 https://github.com/amix/vimrc 代码框架, 
但是已经支持 https://github.com/VundleVim/Vundle.vim 及 GitHub 上很多很酷的插件.

## 说明

Vundle 默认安装的 Vim 插件列表如下, 具体请参考配置文件:

#### Vim调整及功能扩展

* ctrlpvim/ctrlp.vim : ctrl-p 文件查找
* scrooloose/nerdtree : nerdtree 目录树
* vim-airline/vim-airline : airline 状态栏
* vim-airline/vim-airline-themes : airline 状态栏主题

#### 编程代码支持

* sheerun/vim-polyglot : 多语言语法高亮
* mileszs/ack.vim : 字符串过滤器, 需要silversearcher-ag支持
* majutsushi/tagbar : 标签列表栏, 需要 ctags 支持
* Yggdroot/indentLine : 代码缩进线
* scrooloose/nerdcommenter : 代码注释
* jiangmiao/auto-pairs : 输入补全
* w0rp/ale : 异步语法检查引擎 (Asynchronous Lint Engine)
* lilydjwg/colorizer : 颜色高亮预览
* godlygeek/tabular : 文本过滤对齐
* plasticboy/vim-markdown : MarkDown文件语法支持
* chr4/nginx.vim : Nginx配置文件语法支持

#### 色彩模式

* tomasr/molokai : Vim 终端模式默认主题
* tomasiser/vim-code-dark : Vim 图形界面默认主题

## 标准安装

1.在终端执行以下命令进行 VimRC 安装:

```
git clone https://github.com/cuitggyy/vimrc.git ~/.vim
bash ~/.vim/install_standard_vimrc.sh
```

2.上述安装完成后, 需要通过 Vundle 安装插件:

启动 Vim 并在其命令行模式执行以下命令:

```
:PluginInstall
```

## 最小安装

如果仅想对 Vim 做常规配置, 而不启用Vundle及其他插件, 也可进行最小化安装：

```
git clone https://github.com/cuitggyy/vimrc.git ~/.vim
bash ~/.vim/install_essentail_vimrc.sh
```

## LICENSE

GPL-3.0
