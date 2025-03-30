
# 🧠 Personal ZSH Config - Developer Edition
# ================================================================================
# ✅ Prerequisites:
# - Oh My Zsh: https://ohmyz.sh/
# - Plugins: zsh-autosuggestions, zsh-syntax-highlighting
# - Nerd Font for prompt icons
# - Optional: Starship prompt, bat, eza, fzf, zoxide, etc.

# 💻 How I Use This:
# - Customized prompt via Starship
# - Aliases and enhancements for bat, eza, zoxide, fd, and fzf
# - Homebrew-based tools and NVM managed Node.js versions
# - SSH keys autoloaded at shell start
# - Neovim is life. Vim is the fallback.

# ⚠️ Note:
# Make sure to restart your terminal or run `exec zsh` after edits to apply changes.
# ================================================================================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# --- Set name of the theme to load ---
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh


# ---- Syntax Highlighting ----
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Home Bew Config ----
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ---- NVM Config ----
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

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

# ---- Custom ZSCALAR CERT ----
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# ----- SSH Keys Setup ------
eval "$(ssh-agent -s)" > /dev/null
ssh-add -q ~/.ssh/ssh-gitlab-tuv ~/.ssh/ssh-github-personal 2>/dev/null

# ----- Quick Aliases ------
alias syncdevim="bash ~/personal/DeVim/Win/sync-to-devim.sh"

# ---- starship prompts (must be at end of file!) ----
eval "$(starship init zsh)"



