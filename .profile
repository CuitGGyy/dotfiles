#
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash, if ~/.bash_profile or ~/.bash_login exists.
# This file is not read by zsh, if ~/.zsh_profile or ~/.zsh_login exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
#

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# xdg user directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}
if [[ "$(uname -s)" = "Linux" ]]; then
	export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}
	# xdg system directories
	#export XDG_DATA_DIRS=${XDG_DATA_DIRS:-"/usr/local/share:/usr/share"}
	#export XDG_CONFIG_DIRS=${XDG_DATA_DIRS:-"/etc/xdg"}
fi

# if running bash
if [[ "$(basename $SHELL)" = "bash" ]] && [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	#[[ -f ~/.bashrc ]] && . ~/.bashrc
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# if running zsh
if [[ "$(basename $SHELL)" = "zsh" ]] && [ -n "$ZSH_VERSION" ]; then
	# zsh environment variables
	#export ZDOTDIR=${ZDOTDIR:-"$XDG_CONFIG_HOME/zsh"}

	# include .zshrc if it exists
	#[[ -f ~/.zshrc ]] && . ~/.zshrc
	if [ -f "$HOME/.zshrc" ]; then
		. "$HOME/.zshrc"
	fi
fi

# if running ssh tty
#if [ -n "${SSH_TTY}" ]; then
#	export SHELL=$(which bash)
#	export SHELL=$(which zsh)
#	exec $SHELL -l
#fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#	PATH="$HOME/bin:$PATH"
#fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# root need this
#mesg n 2> /dev/null || true

