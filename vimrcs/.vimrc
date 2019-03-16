"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Jonet Lai <joney.lai@gmail.com>
"
" Sections:
"    -> vundle#begin
"    -> plugins
"       -> github forked repos
"       -> local plugins
"    -> vundle#end
"    -> perfered settings
"       -> basics
"       -> plugins
"       -> filetypes
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle begin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GitHub forked repos
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim tweak and extends
Plugin 'ctrlpvim/ctrlp.vim'             " ctrl-p files finder
Plugin 'scrooloose/nerdtree'            " directory files tree
Plugin 'vim-airline/vim-airline'        " colored status bar
"Plugin 'vim-airline/vim-airline-themes' " colored status bar

" coding support
Plugin 'sheerun/vim-polyglot'           " languanges syntax highlight
Plugin 'mileszs/ack.vim'                " substite grep, require: silversearcher-ag
Plugin 'majutsushi/tagbar'              " substite taglist, require: ctags
Plugin 'Yggdroot/indentLine'            " indent line
Plugin 'scrooloose/nerdcommenter'       " auto comment
Plugin 'jiangmiao/auto-pairs'           " auto pairs
"Plugin 'Valloric/YouCompleteMe'         " auto complete
"Plugin 'Shougo/deoplete.nvim'           " asynchronous completion framework
"Plugin 'Chiel92/vim-autoformat'         " auto format
Plugin 'w0rp/ale'                       " Asynchronous Lint Engine

"Plugin 'alvan/vim-closetag'             " close xml/html tags
"Plugin 'mattn/emmet-vim'                " generate xml/html elements
Plugin 'lilydjwg/colorizer'             " highlight preview colors
Plugin 'godlygeek/tabular'              " text filtering alignment
Plugin 'plasticboy/vim-markdown'        " markdown mode
Plugin 'chr4/nginx.vim'                 " nginx syntax

" color schemes
Plugin 'tomasr/molokai'                 " term theme
Plugin 'tomasiser/vim-code-dark'        " gui theme
"Plugin 'altercation/vim-colors-solarized'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Local plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'file://~/.vim/local/some_plugin_name'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => perfered settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/filetypes.vim
catch
endtry

