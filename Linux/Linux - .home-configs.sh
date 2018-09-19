#!/bin/bash


#####   Linux - .profile (calls .bashrc upon bash login)
#
# vi ~/.profile


#####   Linux - .bashrc (configures bash environment)
#
# vi ~/.bashrc


#####   Linux - .vimrc (configures vi, aka vim, editor settings)
#
# vi ~/.vimrc
#
# vi's defaults are read in from the user's root directory, inside the file ".vimrc" ---> aka inside the file with filepath "~/.vimrc"
#  |--> to access these defaults (for the current user)
# see the backup of .vimrc for example-use  https://vimconfig.com/


# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#          AWS DEFAULT FILE: ~/.bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# ### We have color support; assume it's compliant with Ecma-48
	# ### (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# ### a case would tend to support setf rather than setaf.)
	# export PS1='\e[0;36m\u\e[m@\e[0;34m\h \w >\e[m '
# else
	# export PS1='\u@\h \w > '
# fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
  # if [ -f /usr/share/bash-completion/bash_completion ]; then
    # . /usr/share/bash-completion/bash_completion
  # elif [ -f /etc/bash_completion ]; then
    # . /etc/bash_completion
  # fi
# fi

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac
    local NONE="\[\033[0m\]"    # unsets color to term's fg color
    
    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white
    
    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"    # black
    local EMR="\[\033[1;31m\]"    # red
    local EMG="\[\033[1;32m\]"    # green
    local EMY="\[\033[1;33m\]"    # yellow
    local EMB="\[\033[1;34m\]"    # blue
    local EMM="\[\033[1;35m\]"    # magenta
    local EMC="\[\033[1;36m\]"    # cyan
    local EMW="\[\033[1;37m\]"    # white
    
    # background colors
    local BGK="\[\033[40m\]"    # black
    local BGR="\[\033[41m\]"    # red
    local BGG="\[\033[42m\]"    # green
    local BGY="\[\033[43m\]"    # yellow
    local BGB="\[\033[44m\]"    # blue
    local BGM="\[\033[45m\]"    # magenta
    local BGC="\[\033[46m\]"    # cyan
    local BGW="\[\033[47m\]"    # white
    
    local UC=$B                 # user's color
    [ $UID -eq "0" ] && UC=$R   # root's color
		
    PS1="${UC}\u${EMW}@${C}\h ${EMW}[${EMB}\${NEW_PWD}${EMW}]${UC}\\$ ${NONE}"
		
		# PS1='\e[0;36m\u\e[m@\e[0;34m\h \w >\e[m '
		
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}
# init it by setting PROMPT_COMMAND
PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#          AWS DEFAULT FILE: ~/.profile

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"


# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#          MCAVALLO PREFERENCES: ~/.vimrc

set number
set showcmd
set encoding=utf-8
set fileencoding=utf-8
set tabstop=2
set softtabstop=2
syntax enable


# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

