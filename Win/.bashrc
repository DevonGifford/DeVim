# 🧠 Personal Bash Config - Developer Edition
# ================================================================================
# 📍 Location:
# This file is typically found at: ~/.bashrc
# It's sourced automatically for non-login, interactive shells (e.g., new terminal tabs).

# ✅ Prerequisites / Assumptions:
# - Bash is your default shell (or used via scripts/compat mode)
# - Some tools like `notify-send`, `dircolors`, and `lesspipe` are installed
# - You’re okay with auto-switching to Zsh if it’s available (see bottom)

# 💻 What This Config Does:
# - Improves history handling and terminal resizing
# - Adds sane defaults for colorized output and aliases
# - Sets up a colored, context-aware prompt
# - Boots Homebrew and Starship (if present)
# - Loads autocompletion support
# - Switches to Zsh if available — because we live in the future

# ================================================================================


## --- Bail Early if Not Interactive ---
case $- in *i*) ;; *) return ;; esac


# === History Behavior ===
HISTCONTROL=ignoreboth        # Skip dupes & lines starting w/ space
shopt -s histappend           # Don't overwrite history, append it
HISTSIZE=1000                 # Max lines in history per session
HISTFILESIZE=2000             # Max lines in history file

# Resize terminal if window size changed
shopt -s checkwinsize



# === Less: handle non-text input nicely ===
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"



# === Detect chroot (if any) for prompt context ===
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi



# === Prompt Setup ===
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac

# Enable colors if terminal supports it
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 &>/dev/null; then
		color_prompt=yes
	fi
fi

# Set the prompt style
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Show user@host:path in xterm title
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
esac



# === Colors for ls, grep, etc ===
if [ -x /usr/bin/dircolors ]; then
	eval "$(test -r ~/.dircolors && dircolors -b ~/.dircolors || dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi


# === ls Shortcuts ===
alias ll='ls -alF'    # long + classify
alias la='ls -A'      # all except . and ..
alias l='ls -CF'      # column output + classify



# === Alert after long-running commands ===
# Example: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -E '\''s/^\s*[0-9]+\s*//;s/[;&|]\s*alert$//'\'' )"'



# === Extra Aliases ===
# You can drop your custom ones in ~/.bash_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases



# === Autocompletion Goodness ===
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi


# === Homebrew & Starship ===
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"   # Setup brew
eval "$(starship init bash)"                             # Prompt on steroids



# === Switch to Zsh if present and interactive ===
[ -t 1 ] && exec zsh
