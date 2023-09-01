# ~/.zshrc: executed by bash for non-login shells.

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# Setup user specific overrides for this in ~/.zhsrc. See zshbuiltins(1)
# and zshoptions(1) for more details.

# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
	setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# Save command history
#HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTFILE=${XDG_CACHE_HOME:-"$HOME/.cache"}/.zsh_history
# for setting history length see HISTSIZE and SAVESIZE in zsh(1)
HISTSIZE=2000
SAVEHIST=1000

# Beep on error
setopt BEEP

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR} ]] ; then
	source ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR}
else
	typeset -g -A key

	[[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
	[[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
	[[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
	[[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
	[[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
	[[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
	[[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
	[[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
	[[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
	[[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
	[[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
	[[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
	[[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
	[[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
	[[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
	[[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
	[[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
	[[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
	[[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
	[[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
	[[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
	[[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
	[[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
	[[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
	[[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
	[[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
	[[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
	[[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
	[[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
	[[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
	[[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	# bold green apple prompt
	#PS1='%B%F{green}%n%f%b@%B%F{green}%m%f%b %B%F{blue}%1~%f%b %# '
	# bold green debian prompt
	#PS1='%B%F{green}%n%f%b@%B%F{green}%m%f%b:%B%F{blue}%~%f%b%# '
	# bold yellow apple prompt
	#PS1='%B%F{yellow}%n%f%b@%B%F{yellow}%m%f%b %B%F{blue}%1~%f%b %# '
	# bold yellow debian prompt
	PS1='%B%F{yellow}%n%f%b@%B%F{yellow}%m%f%b:%B%F{blue}%~%f%b%# '
else
	# Default apple prompt
	#PS1="%n@%m %1~ %# "
	# Default debian prompt
	PS1="%n@%m:%1~%# "
fi
unset color_prompt force_color_prompt

# zsh support for Terminal from /etc/zshrc_Apple_Terminal
#
# Working Directory
#
# Tell the terminal about the current working directory at each prompt.

if [ -z "$INSIDE_EMACS" ]; then

	update_terminal_cwd() {
	# Identify the directory using a "file:" scheme URL, including
	# the host name to disambiguate local vs. remote paths.

	# Percent-encode the pathname.
	local url_path=''
	{
		# Use LC_CTYPE=C to process text byte-by-byte. Ensure that
		# LC_ALL isn't set, so it doesn't interfere.
		local i ch hexch LC_CTYPE=C LC_ALL=
		for ((i = 1; i <= ${#PWD}; ++i)); do
			ch="$PWD[i]"
			if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
		url_path+="$ch"
			else
		printf -v hexch "%02X" "'$ch"
		url_path+="%$hexch"
			fi
		done
	}

	printf '\e]7;%s\a' "file://$HOST$url_path"
	}

	# Register the function so it is called at each prompt.
	autoload add-zsh-hook
	add-zsh-hook precmd update_terminal_cwd
fi

# enable color support of ls and also add handy aliases
export CLICOLOR=1
#export LSCOLORS=exfxcxdxbxegedabagacad  # default background
#export LSCOLORS=ExFxCxDxBxegedabagacad  # light background
export LSCOLORS=GxFxCxDxBxegedabagaced  # dark background

# enable color support of grep highlight matches
export GREP_OPTIONS='--color=auto'

# GCC colorized warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

# Enable the famous zsh programmable tab-completion features,
# to activate its advanced autocompletion abilities.
autoload -Uz compinit
compinit

# Default completion style is quite plain and ugly.
# To improve its appearance, enter the following commands:
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# For autocompletion with an arrow-key driven interface,
# To activate the menu, press Tab twice.
zstyle ':completion:*' menu select

# For autocompletion of command line switches for aliases.
setopt COMPLETE_ALIASES

# For enabling autocompletion of privileged environments
# in privileged commands (e.g. if you complete a command starting with sudo,
# completion scripts will also try to determine your completions with sudo)
#
# Warning: This will let Zsh completion scripts run commands with
# sudo privileges. You should not enable this if you use untrusted
# autocompletion scripts.
#
#zstyle ':completion::complete:*' gain-privileges 1

# It is also a good idea to enable the auto-correction of the commands.
#setopt correctall

# Typically, compinit will not automatically find new executables in the $PATH.
# For example, after you install a new package, the files in /usr/bin/
# would not be immediately or automatically included in the completion.
# Thus, to have these new executables included, this can be set to happen automatically.
zstyle ':completion:*' rehash true

# 不区分大小写的指令补全
#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# 部分补全的建议策略
zstyle ':completion:*' list-suffixes
#zstyle ':completion:*' expand prefix suffix

# less history file
export LESSHISTFILE=${XDG_CACHE_HOME:-"$HOME/.cache"}/.lesshst

# try to use neovim as default editor
if type nvim > /dev/null 2>&1; then
	alias vim=nvim
	alias vi=nvim
	#export EDITOR=/usr/local/bin/nvim
fi
# set neovim as default editor
#NVIM_HOME="/opt/nvim-macos"
#if [ -f "${NVIM_HOME}/bin/nvim" ]; then
#    export PATH=$PATH:"${NVIM_HOME}/bin"
#    alias vim=nvim
#    alias vi=nvim
#    export EDITOR="${NVIM_HOME}/bin/nvim"
#fi

# homebrew bottle source at china ustc
export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
#export HOMEBREW_API_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles

# python command line tab completetion and history file
export PYTHONSTARTUP=${XDG_CONFIG_HOME:-"$HOME/.config"}/python/pythonstartup
export PYTHONDONTWRITEBYTECODE=1
#export PYTHONUNBUFFERED=1
#export PYTHONUTF8=1
#export PYTHONIOENCODING=utf-8
#alias python=/usr/bin/python3

# mono-mdk environment framework path
#export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current
#MONO_MDK=$HOME/Library/Frameworks/Mono.framework/Home
#export PATH=$PATH:"${MONO_MDK}/Commands"
# dotnet-sdk environment framework path
#DOTNET_SDK="$HOME/Applications/Unity/dotnet-sdk-6.0.413-osx-x64"
#export PATH=$PATH:$DOTNET_SDK

# gcc-linaro cross-compliation environment
#SYSROOT_GLIBC_AARCH64="/opt/sysroot-glibc-linaro-2.25-2019.12-aarch64-linux-gnu"
#CROSS_COMPILE_AARCH64="/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu"
#if [ -d "${CROSS_COMPILE_AARCH64}/bin" ]; then
#    export PATH=$PATH:"${CROSS_COMPILE_AARCH64}/bin"
#fi
#if [ -f "${CROSS_COMPILE_AARCH64}/bin/aarch64-linux-gnu-gcc" ]; then
#    export CROSS_COMPILE="${CROSS_COMPILE_AARCH64}/bin/aarch64-linux-gnu-"
#fi

# cmake open-source cross-platform build test package family
#CMAKE_HOME="/opt/cmake-3.26.5-linux-x86_64"
#if [ -d "${CMAKE_HOME}/bin" ]; then
#	export PATH=$PATH:"${CMAKE_HOME}/bin"
#fi

# qt compilers
#export LDFLAGS="-L/usr/local/opt/qt/lib"
#export CPPFLAGS="-I/usr/local/opt/qt/include"
# pyside6 environment
#PYSIDE6="$HOME/uitest/virtualenv/lib/python3.11/site-packages/PySide6"
#export QT_QPA_PLATFORM_PLUGIN_PATH="${PYSIDE6}/Qt/plugins/platforms"

# nodejs environment, alias for cnpm
#NODE_HOME=/opt/node-v10.15.3-linux-x64
#if [ -d $NODE_HOME ]; then
#    export PATH=$PATH:$NODE_HOME/bin
#    export NODE_PATH=$NODE_HOME/lib/node_modules
#    alias cnpm="npm --registry=https://registry.npm.taobao.org \
#--cache=${XDG_CACHE_HOME:-"$HOME/.cache"}/cnpm \
#--disturl=https://npm.taobao.org/dist \
#--userconfig=${XDG_CONFIG_HOME:-"$HOME/.config"}/cnpmrc
#fi

