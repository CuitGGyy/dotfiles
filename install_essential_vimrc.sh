#!/bin/bash
set -o errexit -o nounset -o pipefail

BASIC=$(dirname $0)/vimrcs/basic.vim
TYPES=$(dirname $0)/vimrcs/filetypes.vim
VIMRC=$HOME/.vimrc
if [ -r $BASIC ] && [ -r $TYPES ]; then
    cat $BASIC | sed '/^"/d' | sed '/^[[:blank:]]*"/d' | sed '/^[[:blank:]]*$/d' > $VIMRC
    cat $TYPES | sed '/^"/d' | sed '/^[[:blank:]]*"/d' | sed '/^[[:blank:]]*$/d' >> $VIMRC
else
    echo "Failed to install essential VimRC! :-("
    exit 1
fi
echo "Installed essential VimRC successfully! Enjoy :-)"

