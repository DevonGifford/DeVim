
#!/bin/bash

set -e

# 📁 General paths
DOTFILES_DIR="$HOME/personal/DeVim/Win"
CONFIG_HOME="$HOME/.config"
BASE_BACKUP_DIR="$HOME/backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BASE_BACKUP_DIR/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

# 📄 Files and folders to sync back into system
declare -A FILES_TO_SYNC=(
  [".zshrc"]="$HOME/.zshrc"
  [".bashrc"]="$HOME/.bashrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
  ["config/starship.toml"]="$CONFIG_HOME/starship.toml"
)

# 🔧 Neovim setup
NVIM_SRC_DIR="$DOTFILES_DIR/config/nvim"
NVIM_DEST_DIR="$CONFIG_HOME/nvim"

NVIM_FILES_TO_COPY=(
  "init.lua"
  "lazy-lock.json"
  "lazyvim.json"
  "stylua.toml"
)

echo -e "\n📥 Restoring dotfiles from → $DOTFILES_DIR"
echo "📦 Backing up existing system configs to → $BACKUP_DIR"
echo "──────────────────────────────────────────────────────"

# 🔁 General dotfiles
for TARGET_NAME in "${!FILES_TO_SYNC[@]}"; do
  DEST_PATH="${FILES_TO_SYNC[$TARGET_NAME]}"
  SOURCE_PATH="$DOTFILES_DIR/$TARGET_NAME"

  if [ -e "$SOURCE_PATH" ]; then
    if [ -e "$DEST_PATH" ]; then
      cp -r "$DEST_PATH" "$BACKUP_DIR/$(basename "$DEST_PATH")"
    fi
    cp -r "$SOURCE_PATH" "$DEST_PATH"
    echo "✅ Restored $TARGET_NAME to system."
  else
    echo "⚠️  Skipped missing in dotfiles: $SOURCE_PATH"
  fi
done

# 🔁 wezterm.lua to ~/.config/.wezterm.lua
WEZTERM_SOURCE="$DOTFILES_DIR/config/wezterm/wezterm.lua"
WEZTERM_TARGET="$CONFIG_HOME/.wezterm.lua"
WEZTERM_BACKUP="$BACKUP_DIR/.wezterm.lua"

if [ -f "$WEZTERM_SOURCE" ]; then
  if [ -e "$WEZTERM_TARGET" ]; then
    cp "$WEZTERM_TARGET" "$WEZTERM_BACKUP"
  fi
  cp "$WEZTERM_SOURCE" "$WEZTERM_TARGET"
  echo "✅ Restored wezterm.lua to $WEZTERM_TARGET"
else
  echo "⚠️  wezterm.lua missing in dotfiles, skipping."
fi

# 🔁 Neovim individual files
mkdir -p "$NVIM_DEST_DIR"
for FILE in "${NVIM_FILES_TO_COPY[@]}"; do
  SRC_FILE="$NVIM_SRC_DIR/$FILE"
  DEST_FILE="$NVIM_DEST_DIR/$FILE"
  if [ -e "$SRC_FILE" ]; then
    if [ -e "$DEST_FILE" ]; then
      cp "$DEST_FILE" "$BACKUP_DIR/$FILE"
    fi
    cp "$SRC_FILE" "$DEST_FILE"
    echo "✅ Restored nvim/$FILE"
  fi
done

# 🔁 Neovim lua/custom
if [ -d "$NVIM_SRC_DIR/lua/custom" ]; then
  mkdir -p "$NVIM_DEST_DIR/lua/custom"
  cp -r "$NVIM_SRC_DIR/lua/custom/"* "$NVIM_DEST_DIR/lua/custom/"
  mkdir -p "$BACKUP_DIR/custom"
  cp -r "$NVIM_DEST_DIR/lua/custom/"* "$BACKUP_DIR/custom/"
  echo "✅ Restored nvim/lua/custom/"
fi

echo -e "\n🎉 System config restored from DeVim. Ready to vibe."
