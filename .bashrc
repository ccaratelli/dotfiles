#!/bin/bash

#if [ "$PS1" ]; then
#    echo "Loading ~/.bashrc"
#    export PS1='\[\033[1;32m\]\u@\h\[\033[00m\] \[\033[1;31m\]($VSC_INSTITUTE_CLUSTER)\[\033[00m\] \[\033[1;34m\]\w>\[\033[00m\] '
#fi


if [ -f /etc/bashrc ]
then
     . /etc/bashrc
fi
#Define where to find modules
#export MODULEPATH=/user/data/gent/gvo000/gvo00003/shared/modules/all:$MODULEPATH
#export MODULEPATH=/user/data/gent/gvo000/gvo00003/apps_cmm/${VSC_INSTITUTE_CLUSTER}/modules/all:$MODULEPATH
#module use --append /user/data/gent/gvo000/gvo00003/shared/modules

# Shared CMM modules
#module use ${VSC_DATA_VO}/apps_cmm/${VSC_INSTITUTE_CLUSTER}/modules/all
#module use ${VSC_DATA_VO}/shared/modules
# My own modules
#echo "module use apps_private"

#Increase stack size
#ulimit -s unlimited

#Fix some MPI bugs
export I_MPI_CPUINFO=proc

#Expand aliases even interactively
shopt -s expand_aliases

#Define alias to tell you the maximum amount of cores you can get on a partial node
alias maxcores='pbsnode | grep -oe "has [0-9]" | grep -o "[0-9]" | sort -urn | head -1'

#Disable OpenMP multithreading so that your MPI processes don't get confused (done for wien2k)
export OMP_NUM_THREADS=1						

#Add paths where binaries/executables are stored (recursive is currently disabled)

#function addtopath
#{
#    for d in $1/*; do if [-d $d ]; then PATH+=":$d";addtopath $d;fi;done
#}

#function addtopythonpath
#{
#    for d in $1/*; do PYTHONPATH+=":$d";addtopythonpath $d;done
#}

export PATH=$PATH:/mnt/d/amsterdam/scripts:~/bin:~/bin/VASP:~/bin/vtstscripts:${HOME}/.local/bin
export PYTHONPATH=$PYTHONPATH:~/bin:~/bin/vtstscripts:~/lib/python

#GITPS1="\$(__git_ps1 \":%s\")"
PBSPS1="(PC)"
SILVER='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
GREEN='\[\033[1;32m\]'
BLUE='\[\033[1;34m\]'
CYAN='\[\033[1;36m\]'
YELLOW='\[\033[1;33m\]'
RED='\[\033[1;31m\]'
PURPLE='\[\033[1;35m\]'
RS='\[\033[00m\]'

#export PS1="${GREEN}\\u@\\h${RS}${RED}${PBSPS1}${RS}${BLUE}\\w${RS}${BLUE}>${RS} " 
export PS1="${PURPLE}\\u@\\h${RS}${BLUE}\\w${RS}${BLUE}>${RS} " 

export LD_LIBRARY_PATH=:${HOME}/lib:${LD_LIBRARY_PATH}

#set editor mode to vi (sorry)
export EDITOR='vi'

#Safety aliases (warn for overwrite and show what you remove)
alias mv='mv -i '
alias rm='rm -v '

#May move the below things to seperate scripts sometime

# Chiara's stuff
PROMPT_DIRTRIM=3
alias ..='cd ..'
alias la='ls -lA'
alias l='ls'
alias ll='ls -l'
alias c='clear'
alias lr='ls -ltr'
alias breniac='ssh breniac;cd $VSC_SCRATCH'
alias motd='cat /etc/motd'
alias scratch='cd /gpfs/scratch/projects/project_gpilot/vsc41771'

DU () {
   # strange, but I want this to work even if there is a folder named total
   a=$(du -hcs * | sort -hr)
   b=$(echo "$a" | head -1)  # total should be here
   c=$(echo "$a" | grep -v "$b") # all except total
   for i in $(ls -d */);
   do
      d=$(echo "$c" | sed "s@[\s\S\t]${i%/}\$@\\\e[34m\t${i}\\\e[39m@")
      c=$d
   done
   echo -e "$c\n--------------\n$b"
}
Find () {
   if [[ -z $2 ]];then
    find ./ -iname $1
   else
    find ./ -iname $1 -exec $2 {} +
   fi
}
Genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=20
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
 
Extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

export DISPLAY=localhost:0.0


#==============bash_profile pasted here

if [[ $- == *i* ]]
then
        #Replace the bash prompt
#       export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w# \[\033[00m\]'

        # check the window size after each command and, if necessary,
        # update the values of LINES and COLUMNS.
        shopt -s checkwinsize

        #Configure history
        #append to the history file
        shopt -s histappend
        #History size in memory (# of lines)
        export HISTSIZE=10000
        #Size of history file
        export HISTFILESIZE=10000

        set editing-mode vi

    #Autocomplete for bash
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
#set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
                    xterm-color) color_prompt=yes;;
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

        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
                eval "`dircolors -b`"
                alias ls='ls --color=auto'
                alias dir='dir --color=auto'
                alias vdir='vdir --color=auto'
            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
                alias egrep='egrep --color=auto'
        alias updatescripts="rsync -pru /user/data/gent/gvo000/gvo00003/shared/thesisbootstrap/bin/* ~/bin"
        fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/root/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/root/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/root/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/root/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
