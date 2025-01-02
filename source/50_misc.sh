# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias grep='grep --color=auto'

alias m='less'
# TBD: Is this useful for anything?
export PAGER=`which less`
# Note: The -R option to less helps it show 'git diff' output
# colorized correctly, instead of showing a bunch of escape sequences.
export LESS='-iX -R -P--Less--?f %f .?x%t (next is %x) .?e(END\: hit q to quit):?pB(%pB\%)..'

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts.
#if [[ -e ~/.ssh/known_hosts ]]; then
#  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
#fi

# I'm used to tcsh 'where' to learn the info that bash 'type -a' prints
alias where='type -a'

alias ldd='otool -L'

# fwf - find writable files
alias fwf='find . \! -type d -a -perm -200 -ls'

# fnd - find non-directory and non-symbolic-link files
alias fnd='find . \! -type d -a \! -type l'
# fnd0 - find non-directory and non-symbol-link files with null char
# as separator, to properly handle file names with white space in
# them.
alias fnd0='find . \! -type d -a \! -type l -print0'
# fnd0nogit - Same as fnd0, except skip over any directories named
# .git and any files within them.  For git clones with large .git
# contents, this can significantly speed up commands like this:
#     `fnd0nogit | xargs -0 grep <pattern>`
alias fnd0nogit='find . -name .git -prune -o \! -type d -a \! -type l -print0'

#       make mv, cp ask before over writing, and rm ask before removing
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

alias ds='dirs -v'
#alias x=exit
alias du='du -k'
alias duss='du -s * .??* | sort -n'
alias hd='hexdump -C'
if [ -x /usr/ucb/ps ]
then
    alias ps=/usr/ucb/ps
fi

# Will recursively search every file in the directory tree starting with node
# <directory> for a match with <string>.
# Each occurrence of a match will be listed on one line. The file pathname and
# line number within the file where the match occurred will be listed.
# The search is CASE INSENSITIVE.
# Only ordinary files will be searched.

# TBD: This still has some tcsh-isms in it.  Consider converting to
# bash function.
alias search='find \!:1 -type f -exec grep -i -n \!:2 '{}' /dev/null \;'

# disable ctrl-d as logout method, unless you press it 10 times in row
IGNOREEOF=10
