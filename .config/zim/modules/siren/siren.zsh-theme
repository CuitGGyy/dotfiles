# vim:et sts=4 sw=4 ft=zsh
#
# A simple theme that displays relevant, contextual information.
#
# A simplified fork of the original siren theme from
# https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_sorin_setup
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.
#
#  16 Terminal Colors
# --- ---------------
#   0 black
#   1 red
#   2 green
#   3 yellow
#   4 blue
#   5 magenta
#   6 cyan
#   7 white (default)
#   8 black (bold with brighter)
#   9 red (bold with brighter)
#  10 green (bold with brighter)
#  11 yellow (bold with brighter)
#  12 blue (bold with brighter)
#  13 magenta (bold with brighter)
#  14 cyan (bold with brighter)
#  15 white (bold with brighter)
#

# define symbol charset according to TERM type
case "$TERM" in
    xterm-color|*-256color) symbol_charset='utf-8' ;;
    linux|foot|*) symbol_charset='ascii' ;;
esac

# select color by uid
_prompt_uid_color_select() {
    case ${EUID} in
        0) print -n '%F{green}' ;;
        *) print -n '%F{yellow}' ;;
    esac
}
#_prompt_current_time() {
#    print -n '%D{%H:%M:%S.%.}'
#}
#_prompt_jobs_count() {
#    print -n '%(1j.%F{blue}*%f.)'
#}

# compatible with vi/vim/nvim
_prompt_keymap_vimode() {
    case ${KEYMAP} in
        vicmd) print -n '%S%#%s' ;;
        *) print -n '%B%#%b' ;;
    esac
}
# zle keymap
_prompt_zle_keymap_select() {
    zle reset-prompt
    zle -R
}
if autoload -Uz is-at-least && is-at-least 5.3; then
    autoload -Uz add-zle-hook-widget && add-zle-hook-widget -Uz keymap-select _prompt_zle_keymap_select
else
    zle -N zle-keymap-select _prompt_zle_keymap_select
fi

# compatible with virtual environment
typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

autoload -Uz add-zsh-hook
# Depends on duration-info module to show last command duration
if (( ${+functions[duration-info-preexec]} && ${+functions[duration-info-precmd]} )); then
    case ${symbol_charset} in
        utf-8) zstyle ':zim:duration-info' format ' %b%F{yellow}%d%f%b' ;;
        ascii|*) zstyle ':zim:duration-info' format '%b%F{green}%d%f%b ' ;;
    esac

    add-zsh-hook preexec duration-info-preexec
    add-zsh-hook precmd duration-info-precmd
fi
# Depends on git-info module to show git information
typeset -gA git_info
if (( ${+functions[git-info]} )); then
    # Set git-info parameters.
    zstyle ':zim:git-info' verbose yes

    case ${symbol_charset} in
        utf-8)
            zstyle ':zim:git-info:branch' format '%%B%F{magenta}%b'
            #zstyle ':zim:git-info:remote' format '%f%%b:%%B%F{white}%R'
            #zstyle ':zim:git-info:position' format ' %F{magenta}%p'
            zstyle ':zim:git-info:commit' format ' HEAD %F{yellow}%c'
            zstyle ':zim:git-info:action' format ' %F{default}:%F{red}%s'
            #zstyle ':zim:git-info:ahead' format ' %F{magenta}↑'
            #zstyle ':zim:git-info:behind' format ' %F{magenta}↓'
            zstyle ':zim:git-info:ahead' format ' %F{magenta}⬆'
            zstyle ':zim:git-info:behind' format ' %F{magenta}⬇'
            zstyle ':zim:git-info:indexed' format ' %F{green}✚'
            zstyle ':zim:git-info:unindexed' format ' %F{blue}✱'
            zstyle ':zim:git-info:stashed' format ' %F{cyan}✭'
            zstyle ':zim:git-info:untracked' format ' %F{white}◼'
            #zstyle ':zim:git-info:dirty' format ' %F{red}●'
            zstyle ':zim:git-info:keys' format \
                'status' '%s%S%I%i%A%B%u' \
                'prompt' ' %f%%b‹%b%c%f%%b›%f%%b'
                #'prompt' ' %f%%b‹%b%R%c%f%%b›%f%%b'
            ;;
        ascii|*)
            zstyle ':zim:git-info:branch' format '%%B%F{magenta}%b'
            #zstyle ':zim:git-info:remote' format '%f%%b:%%B%F{white}%R'
            #zstyle ':zim:git-info:position' format '%p'
            zstyle ':zim:git-info:commit' format 'HEAD %F{green}(%c)'
            zstyle ':zim:git-info:action' format ' %F{yellow}(${(U):-%s})'
            zstyle ':zim:git-info:ahead' format '>'
            zstyle ':zim:git-info:behind' format '<'
            zstyle ':zim:git-info:indexed' format '+'
            zstyle ':zim:git-info:unindexed' format '!'
            zstyle ':zim:git-info:stashed' format '\\\$'
            zstyle ':zim:git-info:untracked' format '-'
            #zstyle ':zim:git-info:dirty' format '*'
            zstyle ':zim:git-info:keys' format \
                'status' '%s%S%I%i%A%B%u' \
                'prompt' ' <%b%c${(e)git_info[status]:+"%%b%f %F{red}[${(e)git_info[status]}]"}%f%%b> '
                #'prompt' ' <%b%c%R${(e)git_info[status]:+"%%b%f %F{red}[${(e)git_info[status]}]"}%f%%b> '
            ;;
    esac

    # Add hook for calling git-info before each command.
    add-zsh-hook precmd git-info
fi

# prompt-pwd styles
#zstyle ':zim:prompt-pwd' git-root yes
#zstyle ':zim:prompt-pwd:tail' length 64
#zstyle ':zim:prompt-pwd:fish-style' dir-length 1
#zstyle ':zim:prompt-pwd:separator' format '>'

# enable substitution for prompt
#setopt prompt_subst
#PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '

# Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
#PROMPT="%(!.%{$fg[red]%}[%n@%m %1~]%{$reset_color%}# .%{$fg[green]%}[%n@%m %1~]%{$reset_color%}$ "
# Maia prompt
#PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
# Print a greeting message when shell is started
#echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)
## Prompt on right side:
#  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
#  - is invisible, if neither is the case

# define prompt line
case ${symbol_charset} in
    utf-8)
        PS1='╭─%(2L.%b%F{white}(%L)%f%b.)%B%(!.%F{red]}.$(_prompt_uid_color_select))%n%f%b@%B$(_prompt_uid_color_select)%m${VIRTUAL_ENV:+"%f%b‹%B%F{white}${VIRTUAL_ENV:t}%f%b›"}${VIM:+" %F{cyan}V"}%f%b:%B%F{blue}%~${(e)git_info[prompt]}%f%b
╰─$(_prompt_keymap_vimode) '
        RPS1='${(e)git_info[status]}%b${duration_info}%(?. %F{green}↵%f. %F{red}%? ✘%f)%(1j. %F{blue}●%f.)'
#        PS1='%(2L.%b%F{white}(%L)%f%b.)%B%(!.%F{red]}.$(_prompt_uid_color_select))%n%f%b@%B$(_prompt_uid_color_select)%m${VIRTUAL_ENV:+"%f%b‹%B%F{white}${VIRTUAL_ENV:t}%f%b›"}${VIM:+" %F{cyan}V"}%f%b:%B%F{blue}%~${(e)git_info[prompt]}%f%b
#$(_prompt_keymap_vimode) '
#        RPS1='${(e)git_info[status]}%b${duration_info}%(?. %F{green}↵%f. %F{red}%? ✘%f)%(1j. %F{blue}●%f.)'
        ;;
    ascii)
        PS1='%(2L.%b%F{white}(%L)%f%b.)%B$(_prompt_uid_color_select)%n%f%b@%B$(_prompt_uid_color_select)%m${VIRTUAL_ENV:+"%f%b(%B%F{white}${VIRTUAL_ENV:t}%f%b)"}${VIM:+" %F{cyan}V"}%f%b:%B%F{cyan}%~%f%b${(e)git_info[prompt]}
%b%(1j.%F{blue}*%f .)%(?.%F{green}.%F{red}%?%f )${duration_info}%F{white}$(_prompt_keymap_vimode)%f%b '
        unset RPS1
#        zstyle ':zim:prompt-pwd:fish-style' dir-length 8
#        PS1='%b%(1j.%F{blue}*%f .)%(?.%F{green}.%F{red}%?%f )${duration_info}
#%(2L.%B%F{white}(%L)%f%b.)%B$(_prompt_uid_color_select)%n%f%b@%B$(_prompt_uid_color_select)%m${VIRTUAL_ENV:+"%f%b(%B%F{white}${VIRTUAL_ENV:t}%f%b)"}${VIM:+" %F{cyan}V"}%f%b:%B%F{cyan}$(prompt-pwd)%f%b${(e)git_info[prompt]}%F{white}$(_prompt_keymap_vimode)%f%b '
#        unset RPS1
        ;;
    *)
        PS1='%B$(_prompt_uid_color_select)%n%f%b@%B$(_prompt_uid_color_select)%m%f%b:%B%F{blue}%1~%f%b %# '
        unset RPS1
        ;;
esac

# Remove local variables
[[ -n ${symbol_charset} ]] && unset symbol_charset

