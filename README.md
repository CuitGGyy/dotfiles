# **VimRC**

[汉语](https://github.com/CuitGGyy/VimRC/blob/master/README.zh_CN.md)
[English](https://github.com/CuitGGyy/VimRC/blob/master/README.md)


This is just my vim configuration based on https://github.com/amix/vimrc framework,
but was modified to support https://github.com/VundleVim/Vundle.vim with cool plugins.

## Introduction

See vim configuration files for more details,
here is vundle default vim plugins install list:

#### Vim tweak and extends

* ctrlpvim/ctrlp.vim : ctrl-p files finder
* scrooloose/nerdtree : directory files tree
* vim-airline/vim-airline : colored status bar
* vim-airline/vim-airline-themes : colored status bar

#### Coding support

* sheerun/vim-polyglot : languanges syntax highlight
* mileszs/ack.vim : substite grep, require: silversearcher-ag
* majutsushi/tagbar : substite taglist, require: ctags
* Yggdroot/indentLine : indent line
* scrooloose/nerdcommenter : auto comment
* jiangmiao/auto-pairs : auto pairs
* w0rp/ale : Asynchronous Lint Engine
* lilydjwg/colorizer : highlight preview colors
* godlygeek/tabular : text filtering alignment
* plasticboy/vim-markdown : markdown mode
* chr4/nginx.vim : nginx syntax

#### Color schemes

* tomasr/molokai : term theme
* tomasiser/vim-code-dark : gui theme

## Standard Installtion

1.Set up VimRC with install script:

```
git clone --depth=1 https://github.com/cuitggyy/vimrc.git ~/.vim
bash ~/.vim/install_standard_vimrc.sh
```

2.Install Plugin:

Launch vim and run follow command in vim command line:

```
:PluginInstall
```
3.Restart Vim

## Minimal Installion

If you just want configure Vim basically and DO NOT use Vundle or other plugins, you can install minimal with follow:

```
git clone https://github.com/cuitggyy/vimrc.git ~/.vim
bash ~/.vim/install_essentail_vimrc.sh
```

## LICENSE

GPL-3.0
