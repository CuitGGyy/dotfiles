# ~/.zprofile: executed by zsh for login shells.

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

umask 022

if [ -z $XDG_CONFIG_HOME ]; then
	export XDG_CONFIG_HOME=$HOME/.config
fi

if [ -z $XDG_DATA_HOME ]; then
	export XDG_DATA_HOME=$HOME/.local/share
fi

if [ -z $XDG_CACHE_HOME ]; then
	export XDG_CACHE_HOME=$HOME/.cache
fi

if [ -f ~/.zshrc ]; then
	source $HOME/.zshrc
fi

