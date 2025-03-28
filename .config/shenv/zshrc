#
# ~/.zshrc: executed by bash for non-login shells.
# created by master for zsh version 5.9
#

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#if [[ $- != *i* ]] ; then
#    # Shell is non-interactive.  Be done now!
#    return
#fi
# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

#
# Darwin system-wide profile for interactive zsh(1) shells.
#
#[ -r "$XDG_CONFIG_HOME/zsh/zshrc_Apple" ] && . "$XDG_CONFIG_HOME/zsh/zshrc_Apple"
#[ -r "$XDG_CONFIG_HOME/zsh/zshrc_Apple_Terminal" ] && . "$XDG_CONFIG_HOME/zsh/zshrc_Apple_Terminal"
#
# Setup user specific overrides for this in ~/.zhsrc. See zshbuiltins(1)
# and zshoptions(1) for more details.
#
# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == 'UTF-8' ]]; then
	setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# Beep on error in ZLE
setopt BEEP

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation,
# etc. (An initial unquoted ‘~’ always produces named directory expansion.)
#setopt EXTENDED_GLOB
# If numeric filenames are matched by a filename generation pattern,
# sort the filenames numerically rather than lexicographically.
#setopt NUMERIC_GLOB_SORT

# keep command history lines within the shell and save it to:
#HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTFILE=${XDG_CACHE_HOME:-"$HOME/.cache"}/.zsh_history
# The maximum number of events stored internally and saved in the history file.
# for setting history length see HISTSIZE and SAVESIZE in zsh(1).
HISTSIZE=20000
SAVEHIST=10000

# refs: https://safreya.github.io/zshdoc_cn/
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# The former is greater than the latter in case user wants HIST_EXPIRE_DUPS_FIRST.
setopt HIST_EXPIRE_DUPS_FIRST

# don't put duplicate lines in the history. See zsh(1) for more options.
# the options below is NOT set by zim default, need to `setopt` manually.
#setopt HIST_SAVE_NO_DUPS
#setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

#
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------
#
# History
#

# Remove older command from the history if a duplicate is to be added.
#setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# By default, zimfw will check if it has a new version available every 30 days.
# This can be disabled with:
zstyle ':zim' disable-version-check yes

# zim completion dump file cache path
zstyle ':zim:completion' dumpfile ${XDG_CACHE_HOME:-"$HOME/.cache"}/.zcompdump
# zim completion cache directory path
#zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME:-"$HOME/.cache"}/zcompcache

# configure case sensitivity for completions and globbing
zstyle ':zim:completion' case-sensitivity sensitive
zstyle ':zim:glob' case-sensitivity sensitive

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------------------
# Setup third-party modules
# ------------------------------

# Enable zsh fuzzy search: from 'ab c' to '*ab*c*'
#HISTORY_SUBSTRING_SEARCH_FUZZY='1'

# Powerlevel10k configuration wizard has been aborted. It will run again next time unless
# you define at least one Powerlevel10k configuration option. To define an option that
# does nothing except for disabling Powerlevel10k configuration wizard.
#POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Avoid zsh-autosuggestions use precmd-hook rebind keys after each command
ZSH_AUTOSUGGEST_MANUAL_REBIND='1'

# fzf set tab key means accept
#export FZF_DEFAULT_OPTS='--ansi --height=60% --reserve --cycle --bind=tab:accept'

#
# jeffreytse/zsh-vi-mode
# https://github.com/jeffreytse/zsh-vi-mode
#

# Do the initialization when the script is sourced (i.e. Initialize instantly)
#ZVM_INIT_MODE=sourcing

function zvm_config() {
	# Change to Zsh's default readkey engine
	#ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE

	# Set the escape key timeout (default is 0.03 seconds)
	ZVM_ESCAPE_KEYTIMEOUT=0.05

	# Set keybindings mode (default is true)
	# The lazy keybindings will post the keybindings of vicmd and visual
	# keymaps to the first time entering the normal mode
	#ZVM_LAZY_KEYBINDINGS=false

	# Retrieve default cursor styles
	#local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
	#local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
	# Append your custom color for your cursor
	#ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;red\a'
	#ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#008800\a'

	#ZVM_VI_HIGHLIGHT_FOREGROUND=green             # Color name
	#ZVM_VI_HIGHLIGHT_FOREGROUND=#008800           # Hex value
	#ZVM_VI_HIGHLIGHT_BACKGROUND=red               # Color name
	#ZVM_VI_HIGHLIGHT_BACKGROUND=#ff0000           # Hex value
	ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline    # bold and underline

	# Always starting with insert mode for each command line
	ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

	# locate temporary directory to home cache
	ZVM_TMPDIR=${XDG_CACHE_HOME:-"$HOME/.cache/temp"}

	# Enable the cursor style feature (default is true)
	#ZVM_CURSOR_STYLE_ENABLED=false
}

# The plugin will auto execute this zvm_after_init function
#function zvm_after_init() {
#}

# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {
	# fix Home/End error keybindings in zsh-vi-mode module
	# zimfw define ${key_info[Home]} zmodule input file
	for key ('^[[H' ${terminfo[khome]}) bindkey -M vicmd ${key} beginning-of-line
	for key ('^[[H' ${terminfo[khome]}) bindkey -M viins ${key} beginning-of-line
	for key ('^[[H' ${terminfo[khome]}) bindkey -M visual ${key} beginning-of-line
	for key ('^[[F' ${terminfo[kend]}) bindkey -M vicmd ${key} end-of-line
	for key ('^[[F' ${terminfo[kend]}) bindkey -M viins ${key} end-of-line
	for key ('^[[F' ${terminfo[kend]}) bindkey -M visual ${key} end-of-line

	# bind @ key to edit command line in vi mode use EDITOR
	for key ('@') bindkey -M vicmd ${key} edit-command-line
}

# ------------------
# Initialize modules
# ------------------

# Set where the directory used by zim will be localed:
#ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
ZIM_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}/zim
# Customize zimrc location:
#ZIM_CONFIG_FILE=${ZDOTDIR:-${HOME}}/.zimrc
ZIM_CONFIG_FILE=${ZIM_HOME}/zimrc

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	if (( ${+commands[curl]} )); then
		curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
			https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
	else
		mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
			https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
	fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
	source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#
zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

#
# }}} End configuration added by Zim install
#

#
# ------------------------------
# Zsh completion default configuration
# ------------------------------
#
# Use modern completion system
#autoload -Uz compinit
#compinit
#
#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
#
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#

# ------------------------------
# Tuning completion after zim init
# ------------------------------
# For autocompletion of command line switches for aliases.
#setopt COMPLETE_ALIASES

# Default completion style is quite plain and ugly.
# To improve its appearance, enter the following commands:
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# For autocompletion with an arrow-key driven interface,
# To activate the menu, press Tab twice.
#zstyle ':completion:*' menu select

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
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# 部分补全的建议策略
#zstyle ':completion:*' list-suffixes
#zstyle ':completion:*' expand prefix suffix

# -------------------------------
# Input runtime configuration
# -------------------------------

# fix Delete/Home/End keybindings in vi mode for bsd/macos console
for key ('^[[H' ${terminfo[khome]}) bindkey -M vicmd ${key} vi-beginning-of-line
for key ('^[[H' ${terminfo[khome]}) bindkey -M viins ${key} vi-beginning-of-line
for key ('^[[H' ${terminfo[khome]}) bindkey -M visual ${key} vi-beginning-of-line
for key ('^[[F' ${terminfo[kend]}) bindkey -M vicmd ${key} vi-end-of-line
for key ('^[[F' ${terminfo[kend]}) bindkey -M viins ${key} vi-end-of-line
for key ('^[[F' ${terminfo[kend]}) bindkey -M visual ${key} vi-end-of-line

# -------------------------------
# Develop environment variables
# -------------------------------

if [ -f $HOME/.config/shenv/environment ]; then
	source $HOME/.config/shenv/environment
fi

