# 🧠 Personal ZSH Config - Developer Edition
# ================================================================================
# 📍 This file lives at: ~/.zshrc
# -- It's loaded whenever a new ZSH shell session starts (e.g., terminal tabs/windows).

# - Oh My Zsh: https://ohmyz.sh/
# - Nerd Font for prompt icons
# - Plugins: zsh-autosuggestions, zsh-syntax-highlighting
# - Customized prompt via Starship
# - Aliases and enhancements for bat, eza, zoxide, fd, and fzf
# - Homebrew-based tools and NVM managed Node.js versions
# - SSH keys autoloaded at shell start
# - Neovim is life. Vim is the fallback.

# ⚠️ Notes: restart terminal or `exec zsh` after edit

# ================================================================================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ---- Oh My Zsh Config ----
export ZSH="$HOME/.oh-my-zsh"
plugins=(git web-search)
source $ZSH/oh-my-zsh.sh
#
# ---- Syntax Highlighting ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- NVM Config ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lTg --icons"
alias lt1="eza -lTg --level=1 --icons"
alias lt2="eza -lTg --level=2 --icons"
alias lt3="eza -lTg --level=3 --icons"
alias lta="eza -lTag --icons"
alias lta1="eza -lTag --level=1 --icons"
alias lta2="eza -lTag --level=2 --icons"
alias lta3="eza -lTag --level=3 --icons"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- TheFuck -----
eval $(thefuck --alias)

# ---- FZF -----
eval "$(fzf --zsh)"
# Setup fzf theme
fg="#CBE1F0"
bg="#1a1b26"
bg_highlight="#143653"
purple="#B389FF"
blue="#07BCE4"
cyan="#3CF9ED"
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}
--preview-window=right:60%:wrap
--bind=ctrl-u:preview-page-up,ctrl-d:preview-page-down
--bind=ctrl-/:toggle-preview"
# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() { fd --follow --hidden --exclude .git . "$2"; }
# Use fd to generate the list for directory completion
_fzf_compgen_dir()  { fd --type=d --follow --hidden --exclude .git . "$2"; }
# Setup fzf-git
source ~/fzf-git.sh/fzf-git.sh
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -199; else bat -n --color=always --line-range :300 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -199'"
# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$2
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -199' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Personal Quick Aliases ------

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
