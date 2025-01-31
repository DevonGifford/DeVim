#!/bin/bash

set -e

# 📁 General paths
DOTFILES_DIR="$HOME/personal/DeVim/Win"
CONFIG_HOME="$HOME/.config"
BASE_BACKUP_DIR="$DOTFILES_DIR/"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BASE_BACKUP_DIR/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

# 📄 Files and folders to sync
declare -A FILES_TO_SYNC=(
  [".zshrc"]="$HOME/.zshrc"
  [".bashrc"]="$HOME/.bashrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
  # ["config/tmux"]="$CONFIG_HOME/tmux"
  ["config/starship.toml"]="$CONFIG_HOME/starship.toml"
)

# 🔧 Neovim setup to sync
NVIM_SRC_DIR="$CONFIG_HOME/nvim"
NVIM_DEST_DIR="$DOTFILES_DIR/config/nvim"
mkdir -p "$NVIM_DEST_DIR/lua"

NVIM_FILES_TO_COPY=(
  "init.lua"
  "lazy-lock.json"
  "lazyvim.json"
  "stylua.toml"
)

echo -e "\n🌀 Syncing dotfiles to → $DOTFILES_DIR"
echo "📦 Backing up originals in → $BACKUP_DIR"
echo "───────────────────────────────────────────────"

# 🔁 General dotfiles
for TARGET_NAME in "${!FILES_TO_SYNC[@]}"; do
  SOURCE_PATH="${FILES_TO_SYNC[$TARGET_NAME]}"
  DEST_PATH="$DOTFILES_DIR/$TARGET_NAME"
  if [ -e "$SOURCE_PATH" ]; then
    cp -r "$SOURCE_PATH" "$DEST_PATH"
    cp -r "$SOURCE_PATH" "$BACKUP_DIR/$(basename "$TARGET_NAME")"
    echo "✅ $TARGET_NAME synced."
  else
    echo "⚠️  Skipped missing: $SOURCE_PATH"
  fi
done


# 🔁 Special case: handle symlinked or real wezterm.lua
WEZTERM_PATH="$CONFIG_HOME/.wezterm.lua"
WEZTERM_DEST_DIR="$DOTFILES_DIR/config/wezterm"
WEZTERM_DEST_FILE="$WEZTERM_DEST_DIR/wezterm.lua"
WEZTERM_BACKUP="$BACKUP_DIR/wezterm.lua"
if [ -L "$WEZTERM_PATH" ]; then
  RESOLVED_WEZTERM=$(realpath "$WEZTERM_PATH")
  if [ -f "$RESOLVED_WEZTERM" ]; then
    mkdir -p "$WEZTERM_DEST_DIR"
    cp "$RESOLVED_WEZTERM" "$WEZTERM_DEST_FILE"
    cp "$RESOLVED_WEZTERM" "$WEZTERM_BACKUP"
    echo "✅ wezterm.lua (resolved symlink) synced."
  else
    echo "⚠️  Symlink exists, but target is missing: $RESOLVED_WEZTERM"
  fi
elif [ -f "$WEZTERM_PATH" ]; then
  mkdir -p "$WEZTERM_DEST_DIR"
  cp "$WEZTERM_PATH" "$WEZTERM_DEST_FILE"
  cp "$WEZTERM_PATH" "$WEZTERM_BACKUP"
  echo "✅ wezterm.lua (regular file) synced."
else
  echo "⚠️  Skipped missing: $WEZTERM_PATH"
fi


# 🔁 Neovim individual files
for FILE in "${NVIM_FILES_TO_COPY[@]}"; do
  if [ -e "$NVIM_SRC_DIR/$FILE" ]; then
    cp "$NVIM_SRC_DIR/$FILE" "$NVIM_DEST_DIR/$FILE"
    cp "$NVIM_SRC_DIR/$FILE" "$BACKUP_DIR/$FILE"
    echo "✅ nvim/$FILE synced."
  fi
done

# 🔁 Neovim lua/custom dir (just contents, not folder itself)
if [ -d "$NVIM_SRC_DIR/lua/custom" ]; then
  mkdir -p "$NVIM_DEST_DIR/lua/custom"
  cp -r "$NVIM_SRC_DIR/lua/custom/"* "$NVIM_DEST_DIR/lua/custom/"
  mkdir -p "$BACKUP_DIR/custom"
  cp -r "$NVIM_SRC_DIR/lua/custom/"* "$BACKUP_DIR/custom/"
  echo "✅ nvim/lua/custom/ plugins synced."
fi

echo -e "\n🚀 Done. Ready to commit & push to DeVim."
