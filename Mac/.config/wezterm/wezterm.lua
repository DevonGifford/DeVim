-- ~/.wezterm.lua (macOS)
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = wezterm.config_builder and wezterm.config_builder() or {}

-- === Appearance ===
config.color_scheme = "Tokyo Night"
config.font_size = 11
config.default_cursor_style = "BlinkingBar"
config.font = wezterm.font_with_fallback({
  "Hack Nerd Font",
  "JetBrains Mono",
  "Menlo",
})

-- Boost contrast a bit
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

-- macOS style: no title bar, keep resize border
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- Initial size (only used if window isn't maximized)
config.initial_rows = 60
config.initial_cols = 180

-- === Keybindings ===
-- Disabled defaults, we don't need 'em.
config.disable_default_key_bindings = true

config.keys = {
  -- Clipboard
  { key = "P", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  { key = "Y", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
}

-- === Mouse ===
-- Triple-click selects semantic zone (word/paths etc.)
-- Right-click: copy if selection exists, otherwise paste
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("SemanticZone"),
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local sel = window:get_selection_text_for_pane(pane)
      if sel and sel ~= "" then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.PasteFrom("Clipboard"), pane)
      end
    end),
  },
}

-- === Startup ===
wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
  window:toast_notification("wezterm", "🔥 Real config loaded!", nil, 4000)
end)

return config

