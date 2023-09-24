# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
alias ls='ls -AvX --group-directories-first --file-type --color=auto'
alias ll='ls -gh'
alias pacman='sudo pacman'
alias grep='grep --color=auto'
alias xclip='xclip -selection clipboard'
alias feh='feh --geometry 900x600 --scale-down --no-menus -B "#0a0e14"'
alias vim='nvim'

#change directory without cd
shopt -s autocd
#correct some directories misspelling when cd
shopt -s cdspell
shopt -s dirspell

#PS1='[\u@\h \W]\$ '

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

pacman-art

export PS1="\n$(prefix_color "BACKGROUND")\[\e[38;5;236m\]   \[\033[00m\]$(prefix_color "FOREGROUND")\[\e[48;5;249m\]\[\e[38;5;236m\] \t \[\033[00m\]\[\e[48;5;249m\]\[\e[38;5;236m\] \w\$(parse_git_branch) \[\033[00m\] "
#export PS1="\n\[\e[48;5;4m\] \[\e[38;5;236m\]  \[\033[00m\]\[\e[38;5;4m\]\[\e[48;5;249m\]\[\e[38;5;236m\] \w\$(parse_git_branch) \[\033[00m\]\[\e[38;5;249m\]\[\033[00m\] "

