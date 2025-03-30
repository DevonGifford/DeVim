#!/bin/bash

set -u

# 🎨 Styling
BOLD='\033[1m'
RESET='\033[0m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
GREY='\033[90m'

# 📁 General paths
DOTFILES_DIR="$HOME/personal/DeVim/Win"
CONFIG_HOME="$HOME/.config"
BASE_BACKUP_DIR="$DOTFILES_DIR/"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BASE_BACKUP_DIR/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

UPDATED_COUNT=0
SKIPPED_COUNT=0
MISSING_COUNT=0

# 📄 Files and folders to sync
declare -A FILES_TO_SYNC=(
  [".zshrc"]="$HOME/.zshrc"
  [".bashrc"]="$HOME/.bashrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
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
echo -e "${BLUE}────────────────────────────────────────────${RESET}"

# 🔁 General dotfiles
for TARGET_NAME in "${!FILES_TO_SYNC[@]}"; do
  SOURCE_PATH="${FILES_TO_SYNC[$TARGET_NAME]}"
  DEST_PATH="$DOTFILES_DIR/$TARGET_NAME"

  if [ -e "$SOURCE_PATH" ]; then
    if [ ! -e "$DEST_PATH" ] || ! cmp -s "$SOURCE_PATH" "$DEST_PATH"; then
      cp -r "$SOURCE_PATH" "$DEST_PATH"
      cp -r "$SOURCE_PATH" "$BACKUP_DIR/$(basename "$TARGET_NAME")"
      echo -e "  ${GREEN}[UPDATED]${RESET}  $TARGET_NAME"
      ((UPDATED_COUNT++))
    else
      echo -e "  ${GREY}[SKIPPED]${RESET}  $TARGET_NAME"
      ((SKIPPED_COUNT++))
    fi
  else
    echo -e "  ${YELLOW}[MISSING]${RESET}  $SOURCE_PATH"
    ((MISSING_COUNT++))
  fi
done

# 🔁 WezTerm config (symlink or real)
WEZTERM_PATH="$CONFIG_HOME/.wezterm.lua"
WEZTERM_DEST_DIR="$DOTFILES_DIR/config/wezterm"
WEZTERM_DEST_FILE="$WEZTERM_DEST_DIR/wezterm.lua"
WEZTERM_BACKUP="$BACKUP_DIR/wezterm.lua"

if [ -L "$WEZTERM_PATH" ]; then
  RESOLVED_WEZTERM=$(realpath "$WEZTERM_PATH")
  if [ -f "$RESOLVED_WEZTERM" ]; then
    mkdir -p "$WEZTERM_DEST_DIR"
    if [ ! -e "$WEZTERM_DEST_FILE" ] || ! cmp -s "$RESOLVED_WEZTERM" "$WEZTERM_DEST_FILE"; then
      cp "$RESOLVED_WEZTERM" "$WEZTERM_DEST_FILE"
      cp "$RESOLVED_WEZTERM" "$WEZTERM_BACKUP"
      echo -e "  ${GREEN}[UPDATED]${RESET}  wezterm.lua (symlink)"
      ((UPDATED_COUNT++))
    else
      echo -e "  ${GREY}[SKIPPED]${RESET}  wezterm.lua (symlink)"
      ((SKIPPED_COUNT++))
    fi
  else
    echo -e "  ${YELLOW}[MISSING]${RESET}  symlink target: $RESOLVED_WEZTERM"
    ((MISSING_COUNT++))
  fi
elif [ -f "$WEZTERM_PATH" ]; then
  mkdir -p "$WEZTERM_DEST_DIR"
  if [ ! -e "$WEZTERM_DEST_FILE" ] || ! cmp -s "$WEZTERM_PATH" "$WEZTERM_DEST_FILE"; then
    cp "$WEZTERM_PATH" "$WEZTERM_DEST_FILE"
    cp "$WEZTERM_PATH" "$WEZTERM_BACKUP"
    echo -e "  ${GREEN}[UPDATED]${RESET}  wezterm.lua"
    ((UPDATED_COUNT++))
  else
    echo -e "  ${GREY}[SKIPPED]${RESET}  wezterm.lua"
    ((SKIPPED_COUNT++))
  fi
else
  echo -e "  ${YELLOW}[MISSING]${RESET}  $WEZTERM_PATH"
  ((MISSING_COUNT++))
fi

# 🔁 Neovim individual files
for FILE in "${NVIM_FILES_TO_COPY[@]}"; do
  SRC="$NVIM_SRC_DIR/$FILE"
  DEST="$NVIM_DEST_DIR/$FILE"
  if [ -e "$SRC" ]; then
    if [ ! -e "$DEST" ] || ! cmp -s "$SRC" "$DEST"; then
      cp "$SRC" "$DEST"
      cp "$SRC" "$BACKUP_DIR/$FILE"
      echo -e "  ${GREEN}[UPDATED]${RESET}  nvim/$FILE"
      ((UPDATED_COUNT++))
    else
      echo -e "  ${GREY}[SKIPPED]${RESET}  nvim/$FILE"
      ((SKIPPED_COUNT++))
    fi
  fi
done

# 🔁 Neovim lua/custom dir (just contents, not folder itself)
if [ -d "$NVIM_SRC_DIR/lua/custom" ]; then
  mkdir -p "$NVIM_DEST_DIR/lua/custom"
  mkdir -p "$BACKUP_DIR/custom"

  shopt -s nullglob
  custom_files=("$NVIM_SRC_DIR/lua/custom/"*)
  shopt -u nullglob

  if [ ${#custom_files[@]} -eq 0 ]; then
    echo -e "  ${GREY}[SKIPPED]${RESET}  nvim/lua/custom/ (no files)"
    ((SKIPPED_COUNT++))
  else
    for f in "${custom_files[@]}"; do
      fname=$(basename "$f")
      destf="$NVIM_DEST_DIR/lua/custom/$fname"
      if [ ! -e "$destf" ] || ! cmp -s "$f" "$destf"; then
        cp "$f" "$destf"
        cp "$f" "$BACKUP_DIR/custom/$fname"
        echo -e "  ${GREEN}[UPDATED]${RESET}  nvim/lua/custom/$fname"
        ((UPDATED_COUNT++))
      else
        echo -e "  ${GREY}[SKIPPED]${RESET}  nvim/lua/custom/$fname"
        ((SKIPPED_COUNT++))
      fi
    done
  fi
fi

# 🎉 Final summary
echo -e "\n${BOLD}✨ Dotfile sync finished!${RESET}"
echo -e "${BLUE}────────────────────────────────────────────${RESET}"
echo -e "  ✅ Updated:  $UPDATED_COUNT"
echo -e "  ⏩ Skipped:  $SKIPPED_COUNT"
echo -e "  ⚠️  Missing:  $MISSING_COUNT"
echo -e "  📦 Backup:   $BACKUP_DIR"
echo -e "${BLUE}────────────────────────────────────────────${RESET}"
echo -e "📤 Ready to commit & push to ${BOLD}DeVim${RESET}"
