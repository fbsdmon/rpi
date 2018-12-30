################################################################################
#
#   fBSDmon's bash resource script v1.21
#
# Place the scritp in /etc/bashrc.sh and load (source) it by copy/pasting the
# following in terminal as the desired user:
#   echo "[ -f /etc/bashrc.sh ] && source /etc/bashrc.sh" >> ~/.bashrc
#   echo "[ -f /etc/bashrc.sh ] && source /etc/bashrc.sh" >> ~/.bash_profile
# NOTE: Tested on CentOS, Fedora, Ubuntu & Mac OS X
#
#
#                                                   fbsdmon@gmail.com
#
################################################################################

# Text color & formating
W=$'\[\033[0;30m\]'  # black
S=$'\[\033[1;30m\]'  # dark gray
r=$'\[\033[0;31m\]'  # red
R=$'\[\033[1;31m\]'  # dark red
g=$'\[\033[0;32m\]'  # green
G=$'\[\033[1;32m\]'  # dark green
y=$'\[\033[0;33m\]'  # yellow
Y=$'\[\033[1;33m\]'  # dark yellow
b=$'\[\033[0;34m\]'  # blue
B=$'\[\033[1;34m\]'  # dark blue
m=$'\[\033[0;35m\]'  # magenta
M=$'\[\033[1;35m\]'  # dark magenta
c=$'\[\033[0;36m\]'  # cyan
C=$'\[\033[1;36m\]'  # dark cyan
s=$'\[\033[0;37m\]'  # light gray
w=$'\[\033[1;37m\]'  # white
X=$'\[\033[0m\]'     # no color

# default permissions
umask {{ umask }}

# terminal
export TERM=xterm-256color

# prompt
if [ $(whoami) == 'root' ]; then
    PS1="${S}[${R}\u${s}@${m}\h${S}]${s}\W${r}\\$ ${X}"
else
    PS1="${S}[${g}\u${s}@${m}\h${S}]${s}\W${r}\\$ ${X}"
fi;
#PS1="[\u@\h]\w\$ "
#PS1="[\u@\h]\W\$ "

# path (Ensure user-installed binaries take precedence)
export PATH=$HOME/bin:/usr/local/bin:$PATH

# editor
export EDITOR=vi

#export LC_TIME=en_DK.utf8

# enable color support of ls & add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
# fi

# prevent root from doing accidental damage
if [ $(whoami) == 'root' ]; then  
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
fi;

# aliases
alias ll='ls -laFh'
alias lf='ls -aF'
alias psg='ps axu | grep -i '
[ -f "$(which vim 2>/dev/null)" ] && alias vi='vim'
#alias make-list-targets="make -qp | awk -F':' '/^[a-zA-Z0-9][^\$#\/\t=]*:([^=]|\$)/ {split(\$1,A,/ /);for(i in A)print A[i]}' | sort"
alias tdump='tcpdump -nnttttvvv '
alias please='sudo'
alias modules='find /lib/modules/$(uname -r) -type f -name \*.ko'
alias digit='dig +nocmd +noall +answer +multiline any '

# run only on CentOS & RedHat
if [ -f /etc/centos-release -o /etc/redhat-release ]; then
    alias rq='rpm -qa | grep -i '
fi;

# Host autocomplete for MacOS
if [ "$(uname)" == "Darwin" ]; then
    _complete_ssh_hosts () {
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                            cut -f 1 -d ' ' | \
                            sed -e s/,.*//g | \
                            grep -v ^# | \
                            uniq | \
                            grep -v "\[" ;
                        cat ~/.ssh/config | \
                            grep "^Host " | \
                            awk '{print $2}'
                        `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
    }
    complete -F _complete_ssh_hosts ssh
fi

# Learn something
[ -f /usr/games/cowsay ] && /usr/games/cowsay $(whatis $(ls -1A /sbin /usr/sbin /bin /usr/bin | grep -v "/usr/sbin:" | grep -v "/sbin:" | grep -v "/usr/sbin:" | grep -v "/bin:" | grep -v "/usr/bin:" | grep -v "^$") 2>/dev/null | shuf -n 1)

################################################################################
# perssonal (not to be shared with the bashrc.sh resource script)
################################################################################

