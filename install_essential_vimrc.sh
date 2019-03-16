#!/bin/sh
set -e

BASIC=$HOME/.vim/vimrcs/basic.vim
TYPES=$HOME/.vim/vimrcs/filetypes.vim
VIMRC=$HOME/.vimrc
ERROR="Failed to install essential vim configuation!"
cat $BASIC | sed '/^"/d' | sed '/^[[:blank:]]*"/d' | sed '/^[[:blank:]]*$/d' > $VIMRC || { echo $ERROR; exit 1; }
cat $TYPES | sed '/^"/d' | sed '/^[[:blank:]]*"/d' | sed '/^[[:blank:]]*$/d' >> $VIMRC || { echo $ERROR; exit 1; }
echo "Installed essential vim configuration successfully! Enjoy :-)"

