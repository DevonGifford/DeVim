-- 🧠 Personal WezTerm Config - Developer Edition
-- ================================================================================
-- 📍 Location (WSL/Linux/macOS):
-- This file lives at: ~/.wezterm.lua
-- It's loaded every time WezTerm launches and defines all appearance & behavior.

-- ✅ Prerequisites:
-- - wezterm >= 2023.x
-- - Nerd Font for icons in prompts (e.g., Starship, Zsh, etc.)
-- - WSL2 (if on Windows) for full Linux CLI dev stack

-- 🎯 Goals:
-- - Minimalist, fast terminal startup
-- - Clean font rendering with Nerd Fonts
-- - Easy pane and tab navigation using Vim-style keys
-- - Mouse behavior similar to Windows Terminal
-- - WSL-friendly config with platform detection
-- - Maximize terminal window on startup

-- 📦 Features:
-- - Tokyo Night theme for consistency with Neovim & Starship
-- - Custom keybindings for tabs, panes, and reloads
-- - Automatic detection of CMD/Ctrl modifier per OS
-- - Smart scrollback clearing
-- - Window decorations set to RESIZE-only (no title bar)
-- - Tab bar disabled for cleaner UI
-- - Mouse and triple-click support
-- - Tweakable scaffolding for keys, launch menu, and mouse_bindings

-- ⚙️ Pro Tip:
-- Edit this file and run `Ctrl+Shift+R` to reload WezTerm instantly (no restart needed).
-- ================================================================================


-- Base wezterm modules
-- 'mux' handles multiplexed terminal windows
-- 'act' is for triggering specific actions (keybinds, mouse, etc.)
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Config scaffolding
-- These are placeholders in case I need to expand bindings or menus later
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

local config = {}

-- For newer versions of wezterm, this enables validation + helpful error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- === Appearance & Style ===

-- Color theme: pick from wezterm's huge built-in list
-- Preview them at: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Tokyo Night'

-- Font settings
-- Using Nerd Font variant for icon glyphs (e.g. in prompts, zsh themes)
config.font = wezterm.font_with_fallback {
  "Hack Nerd Font",
  "JetBrains Mono",
}
config.font_size = 11

-- Cursor
config.default_cursor_style = 'BlinkingBar'

-- Improve contrast by boosting foreground brightness
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}



-- === Behavior & UX ===

-- Disable built-in key bindings (going fully custom)
config.disable_default_key_bindings = true

-- Detect platform and map CMD accordingly
local is_windows = wezterm.target_triple:find("windows")
local CMD = is_windows and "CTRL" or "CMD"

-- Define the leader key
config.leader = {
  key = 'Space',
  mods = 'CTRL',
  timeout_milliseconds = 1000
}

config.keys = {
  -- === Tab Management ===
  { key = 'L', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'H', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },
  { key = 'T', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'N', mods = 'CTRL|SHIFT', action = act.SpawnWindow },

  -- === Config Reload ===
  { key = 'R', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

  -- === Disabled/Unused bindings (for now) ===
  -- { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  -- { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  -- { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  -- { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  -- { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  -- { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  -- { key = 'v', mods = CMD, action = act.PasteFrom 'Clipboard' },
  -- { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  -- { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  -- { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  -- { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  -- { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  -- { key = 'f', mods = CMD, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- { key = 'd', mods = CMD, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- { key = 'h', mods = CMD, action = act.ActivatePaneDirection 'Left' },
  -- { key = 'l', mods = CMD, action = act.ActivatePaneDirection 'Right' },
  -- { key = 't', mods = CMD, action = act.SpawnTab 'CurrentPaneDomain' },
  -- { key = 'w', mods = CMD, action = act.CloseCurrentTab { confirm = false } },
  -- { key = 'x', mods = CMD, action = act.CloseCurrentPane { confirm = false } },
  -- { key = 'b', mods = 'LEADER|CTRL', action = act.SendString '\x02' },
  -- { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode },
  -- { key = 'p', mods = 'LEADER', action = act.PasteFrom 'PrimarySelection' },
 

  -- === Extra Keys ===
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    }
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false
    }
  }
}

-- Mouse behavior similar to Windows Terminal:
-- Right-click pastes, or copies if there's a selection
mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}
config.mouse_bindings = mouse_bindings

-- Launch menu stub (can define WSL targets, SSH, etc. later)
config.launch_menu = launch_menu


-- Window appearance
-- Note: use "RESIZE" for border-only window; no title bar
-- "TITLE | RESIZE" enables the native window chrome
config.window_decorations = "RESIZE"

-- Disable the tab bar entirely
-- (Alternatively, hide it only when one tab is open using:
-- config.hide_tab_bar_if_only_one_tab = true)
config.enable_tab_bar = false

-- Initial terminal size on launch (rows x columns)
config.initial_rows = 60
config.initial_cols = 180

-- Set WSL as the default domain when running on Windows
-- config.default_domain = 'WSL:Ubuntu-20.04'
if wezterm.target_triple == "x86_64-pc-windows-msvc" or wezterm.target_triple == "aarch64-pc-windows-msvc" then
  config.default_domain = 'WSL:Ubuntu-24.04'
end

-- Maximize the window on launch (cross-platform safe)
wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

-- Final export
return config
