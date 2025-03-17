-- Base wezterm modules
-- 'mux' handles multiplexed terminal windows
-- 'act' is for triggering specific actions (keybinds, mouse, etc.)
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Config scaffolding
-- These are placeholders in case I need to expand bindings or menus later
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- For newer versions of wezterm, this enables validation + helpful error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- === Appearance & Style ===

-- Color theme: pick from wezterm's huge built-in list
-- Preview them at: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Oceanic Next (Gogh)'

-- Font settings
-- Using Nerd Font variant for icon glyphs (e.g. in prompts, zsh themes)

config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font_with_fallback {
--   "Hack Nerd Font",
--   "JetBrains Mono",
--   "Menlo", -- Safe macOS system fallback
-- }
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

-- Custom keybindings: basic example with Ctrl+V for clipboard paste
config.keys = {
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
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
  config.default_domain = 'WSL:Ubuntu-20.04'
end

-- Maximize the window on launch (cross-platform safe)
wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

-- Final export
return config
