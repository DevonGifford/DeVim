# 🧠 Personal ZSH Config - Developer Edition
# ================================================================================
# ✅ Prerequisites
# Core: Oh My Zsh, zsh-autosuggestions, zsh-syntax-highlighting, Nerd Font
# Tools (via Homebrew/Linuxbrew): starship, bat, eza, fd, fzf, zoxide, nvm
# Optional: corporate CA (Zscaler), SSH keys for GitHub/GitLab
#
# ⚠️ Notes: restart terminal or `exec zsh` after edit
# ================================================================================

# ---- Oh My Zsh Config ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---- Syntax Highlighting ----
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Home Brew Config ----
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ---- NVM Config ----
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
alias ls='eza --icons=always --color=always -1'
alias la='eza --icons=always --color=always -1 -a'
alias lt='eza --color=always --git --icons=always --group-directories-first -lT --level=2'

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
source ~/.fzf-git.sh/fzf-git.sh
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- WORK: SSH Agent / Keys Setup ------

# ---- WORK: Custom ZSCALAR CERT ----

# --- WORK: Proxy presets ---

# ----- Personal Quick Aliases ------
alias syncdevim="bash ~/personal/DeVim/Win/sync-to-devim.sh"

# Attach to a tmux session by name
attach() {
  if [[ -z "$1" ]]; then
    echo "Available tmux sessions:"
    tmux ls 2>/dev/null || echo "(none)"
  else
    tmux attach -t "$1"
  fi
}

# Enable autocompletion for attach
_attach_complete() {
  local -a sessions
  sessions=("${(@f)$(tmux ls 2>/dev/null | cut -d: -f1)}")
  _describe 'sessions' sessions
}
compdef _attach_complete attach


# ---- starship prompts (must be at end of file!) ----
eval "$(starship init zsh)"


