#Last edited 16/11/2012
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

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
