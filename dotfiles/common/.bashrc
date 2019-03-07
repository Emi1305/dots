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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    RED="\001$(tput setaf 9)\002"
    GREEN="\001$(tput setaf 2)\002"
    VIOLET="\001$(tput setaf 13)\002"
    PS1="${RED}${debian_chroot:+($debian_chroot)}\u${VIOLET}@${RED}\h${GREEN}:\w\a\$ "
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Custom functions

function markdown_stylesheet (){
    echo "/*
Copyright (c) 2017 Chris Patuzzo
https://twitter.com/chrispatuzzo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

body {
  font-family: Helvetica, arial, sans-serif;
  font-size: 14px;
  line-height: 1.6;
  padding-top: 10px;
  padding-bottom: 10px;
  background-color: white;
  padding: 30px;
  color: #333;
}

body > *:first-child {
  margin-top: 0 !important;
}

body > *:last-child {
  margin-bottom: 0 !important;
}

a {
  color: #4183C4;
  text-decoration: none;
}

a.absent {
  color: #cc0000;
}

a.anchor {
  display: block;
  padding-left: 30px;
  margin-left: -30px;
  cursor: pointer;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
}

h1, h2, h3, h4, h5, h6 {
  margin: 20px 0 10px;
  padding: 0;
  font-weight: bold;
  -webkit-font-smoothing: antialiased;
  cursor: text;
  position: relative;
}

h2:first-child, h1:first-child, h1:first-child + h2, h3:first-child, h4:first-child, h5:first-child, h6:first-child {
  margin-top: 0;
  padding-top: 0;
}

h1:hover a.anchor, h2:hover a.anchor, h3:hover a.anchor, h4:hover a.anchor, h5:hover a.anchor, h6:hover a.anchor {
  text-decoration: none;
}

h1 tt, h1 code {
  font-size: inherit;
}

h2 tt, h2 code {
  font-size: inherit;
}

h3 tt, h3 code {
  font-size: inherit;
}

h4 tt, h4 code {
  font-size: inherit;
}

h5 tt, h5 code {
  font-size: inherit;
}

h6 tt, h6 code {
  font-size: inherit;
}

h1 {
  font-size: 28px;
  color: black;
}

h2 {
  font-size: 24px;
  border-bottom: 1px solid #cccccc;
  color: black;
}

h3 {
  font-size: 18px;
}

h4 {
  font-size: 16px;
}

h5 {
  font-size: 14px;
}

h6 {
  color: #777777;
  font-size: 14px;
}

p, blockquote, ul, ol, dl, li, table, pre {
  margin: 15px 0;
}

hr {
  border: 0 none;
  color: #cccccc;
  height: 4px;
  padding: 0;
}

body > h2:first-child {
  margin-top: 0;
  padding-top: 0;
}

body > h1:first-child {
  margin-top: 0;
  padding-top: 0;
}

body > h1:first-child + h2 {
  margin-top: 0;
  padding-top: 0;
}

body > h3:first-child, body > h4:first-child, body > h5:first-child, body > h6:first-child {
  margin-top: 0;
  padding-top: 0;
}

a:first-child h1, a:first-child h2, a:first-child h3, a:first-child h4, a:first-child h5, a:first-child h6 {
  margin-top: 0;
  padding-top: 0;
}

h1 p, h2 p, h3 p, h4 p, h5 p, h6 p {
  margin-top: 0;
}

li p.first {
  display: inline-block;
}

ul, ol {
  padding-left: 30px;
}

ul :first-child, ol :first-child {
  margin-top: 0;
}

ul :last-child, ol :last-child {
  margin-bottom: 0;
}

dl {
  padding: 0;
}

dl dt {
  font-size: 14px;
  font-weight: bold;
  font-style: italic;
  padding: 0;
  margin: 15px 0 5px;
}

dl dt:first-child {
  padding: 0;
}

dl dt > :first-child {
  margin-top: 0;
}

dl dt > :last-child {
  margin-bottom: 0;
}

dl dd {
  margin: 0 0 15px;
  padding: 0 15px;
}

dl dd > :first-child {
  margin-top: 0;
}

dl dd > :last-child {
  margin-bottom: 0;
}

blockquote {
  border-left: 4px solid #dddddd;
  padding: 0 15px;
  color: #777777;
}

blockquote > :first-child {
  margin-top: 0;
}

blockquote > :last-child {
  margin-bottom: 0;
}

table {
  padding: 0;
}
table tr {
  border-top: 1px solid #cccccc;
  background-color: white;
  margin: 0;
  padding: 0;
}

table tr:nth-child(2n) {
  background-color: #f8f8f8;
}

table tr th {
  font-weight: bold;
  border: 1px solid #cccccc;
  text-align: left;
  margin: 0;
  padding: 6px 13px;
}

table tr td {
  border: 1px solid #cccccc;
  text-align: left;
  margin: 0;
  padding: 6px 13px;
}

table tr th :first-child, table tr td :first-child {
  margin-top: 0;
}

table tr th :last-child, table tr td :last-child {
  margin-bottom: 0;
}

img {
  max-width: 100%;
}

span.frame {
  display: block;
  overflow: hidden;
}

span.frame > span {
  border: 1px solid #dddddd;
  display: block;
  float: left;
  overflow: hidden;
  margin: 13px 0 0;
  padding: 7px;
  width: auto;
}

span.frame span img {
  display: block;
  float: left;
}

span.frame span span {
  clear: both;
  color: #333333;
  display: block;
  padding: 5px 0 0;
}

span.align-center {
  display: block;
  overflow: hidden;
  clear: both;
}

span.align-center > span {
  display: block;
  overflow: hidden;
  margin: 13px auto 0;
  text-align: center;
}

span.align-center span img {
  margin: 0 auto;
  text-align: center;
}

span.align-right {
  display: block;
  overflow: hidden;
  clear: both;
}

span.align-right > span {
  display: block;
  overflow: hidden;
  margin: 13px 0 0;
  text-align: right;
}

span.align-right span img {
  margin: 0;
  text-align: right;
}

span.float-left {
  display: block;
  margin-right: 13px;
  overflow: hidden;
  float: left;
}

span.float-left span {
  margin: 13px 0 0;
}

span.float-right {
  display: block;
  margin-left: 13px;
  overflow: hidden;
  float: right;
}

span.float-right > span {
  display: block;
  overflow: hidden;
  margin: 13px auto 0;
  text-align: right;
}

code, tt {
  margin: 0 2px;
  padding: 0 5px;
  white-space: nowrap;
  border: 1px solid #eaeaea;
  background-color: #f8f8f8;
  border-radius: 3px;
}

pre code {
  margin: 0;
  padding: 0;
  white-space: pre;
  border: none;
  background: transparent;
}

.highlight pre {
  background-color: #f8f8f8;
  border: 1px solid #cccccc;
  font-size: 13px;
  line-height: 19px;
  overflow: auto;
  padding: 6px 10px;
  border-radius: 3px;
}

pre {
  background-color: #f8f8f8;
  border: 1px solid #cccccc;
  font-size: 13px;
  line-height: 19px;
  overflow: auto;
  padding: 6px 10px;
  border-radius: 3px;
}

pre code, pre tt {
  background-color: transparent;
  border: none;
}"
}

function render_markdown () {
    cat <(echo "<!DOCTYPE html><html><head><style>") <(markdown_stylesheet) <(echo "</style></head><body>") <(markdown $1) <(echo "</body></html>") | firefox "data:text/html;base64,$(base64 -w 0 <&0)";
}

function change_screenshot_location () {
    gsettings set org.gnome.gnome-screenshot auto-save-directory "file://$1";
}

function set_bright {
    echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness;
}

function change_name {
    trap 'echo -ne "\e]0;'$1'\007"' DEBUG
}
