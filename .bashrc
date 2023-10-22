# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# change background color if root
#if [[ $(whoami) == "root" ]]; then
#	printf "%b" "\033]11;#EA6C73\007"
#else 
#	printf "%b"
#fi

#aliases
alias ls='ls -AvX --group-directories-first --file-type --color=auto'
alias ll='ls -gh'
alias grep='grep --color=auto'
alias vim='nvim'
alias vimtutor='nvim -c Tutor'
alias pacman='sudo pacman'
alias xclip='xclip -selection clipboard'
alias feh='feh --geometry 900x600 --scale-down --no-menus -B "#0a0e14"'


# Change working dir in shell to last dir in lf on exit (adapted from ranger).
#
# You need to either copy the content of this file to your shell rc file
# (e.g. ~/.bashrc) or source this file directly:
#
#     LFCD="/path/to/lfcd.sh"
#     if [ -f "$LFCD" ]; then
#         source "$LFCD"
#     fi
#
# You may also like to assign a key (Ctrl-O) to this command:
#
#     bind '"\C-o":"lfcd\C-m"'  # bash
#     bindkey -s '^o' 'lfcd\n'  # zsh
#

lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

alias lf='lfcd'

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.config/LESS_TERMCAP ]] && . ~/.config/LESS_TERMCAP


#change directory without cd
shopt -s autocd
#correct some directories misspelling when cd
shopt -s cdspell
shopt -s dirspell


function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/  \1$(parse_git_dirty)/"
}

#return red if root, blue otherwise
function prefix_color {
	SIDE=48 #background
	if [[ $1 == "FOREGROUND" ]]; then
		SIDE=38
	fi

	if [[ $(whoami) == "root" ]]; then
		echo "\[\e[$SIDE;5;1m\]"
	else
		echo "\[\e[$SIDE;5;4m\]"
	fi
}

#pacman-art
# █                   

export PS1="\n$(prefix_color "FOREGROUND")$(prefix_color "BACKGROUND")\[\e[38;5;236m\]  \[\033[00m\]$(prefix_color "FOREGROUND")\[\e[48;5;249m\]\[\e[38;5;236m\] \t \[\033[00m\]\[\e[48;5;249m\]\[\e[38;5;236m\] \w\$(parse_git_branch) \[\033[00m\] "
#                                        |                                                                                                                                                                                                               |
