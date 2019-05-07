#!/bin/sh
set -e

CONFIG=$(dirname $0)/vimrcs/.vimrc
VIMRC=$HOME/.vimrc
ERROR="Failed to install standard VimRC! :-("
cat $CONFIG > $VIMRC || { echo $ERROR; exit 1; }
echo "Installed standard VimRC successfully! Enjoy :-)"

