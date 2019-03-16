#!/bin/sh
set -e

CONFIG=$HOME/.vim/vimrcs/.vimrc
VIMRC=$HOME/.vimrc
ERROR="Failed to install standard vim configuration!"
cat $CONFIG > $VIMRC || { echo $ERROR; exit 1; }
echo "Installed standard vim configuration successfully! Enjoy :-)"

