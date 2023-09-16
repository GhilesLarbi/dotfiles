# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
alias ls='ls -AvX --group-directories-first --file-type --color=auto'
alias ll='ls -gh'
alias pacman='sudo pacman'
alias grep='grep --color=auto'
alias xclip='xclip -selection clipboard'
alias feh='feh --geometry 900x600 --scale-down --no-menus'
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
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ ( \1$(parse_git_dirty))/"
}
#export PS1="\n\[\e[38;5;249m\]\[\e[0m\]\[\e[48;5;249m\] \[\e[38;5;236m\]\t \w\$(parse_git_branch) \[\033[00m\] "
#export PS1="\n\[\e[38;5;249m\]\[\e[0m\]\[\e[48;5;249m\] \[\e[38;5;236m\]\t \w\$(parse_git_branch) \[\033[00m\] "
export PS1="\n\[\e[0m\]\[\e[48;5;249m\] \[\e[38;5;236m\]\t \w\$(parse_git_branch) \[\033[00m\] "
