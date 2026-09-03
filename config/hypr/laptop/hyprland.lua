---@module 'hl'
hl.env("XCURSOR_SIZE", 24)
local mainMod = "ALT"
local ctrlMod = "CONTROL"

hl.monitor({
  output = "eDP-1",
  mode = "2256x1504@60",
  position = "0x0",
  scale = 1,
})

-- Autostart
hl.on("hyprland.start", function()
  hl.exec_cmd("~/.config/hypr/waybar-detect.sh")
  hl.exec_cmd("~/.config/hypr/udiskie.sh")
  hl.exec_cmd("/usr/bin/dunst")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("/usr/bin/killall qpwgraph || /usr/bin/sleep 5 && /usr/bin/qpwgraph -a -m")
  hl.exec_cmd("/usr/bin/firefox")
  hl.exec_cmd("/usr/bin/kitty --title Kitty")
  hl.exec_cmd("/usr/bin/hyprpaper")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
  hl.exec_cmd("/usr/bin/hypridle| /usr/bin/systemd-cat -t hypridle")
  hl.exec_cmd("xmodmap ~/.Xmodmap")
end)

hl.config({
  animations = {
    enabled = true,
    -- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
  },
  debug = {
    disable_logs = false,
  },
  decoration = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more
    rounding = 10,
    blur = {
      enabled = true,
      size = 8,
      passes = 1,
      xray = true,
    },
    shadow = {
      enabled = true,
      range = 5,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },
  general = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more
    gaps_in = 4,
    gaps_out = { 8, 8, 2, 8 },
    border_size = 2,
    layout = "master",
    col = {
      active_border = { colors = { "rgba(3d59a1ee)", "rgba(7aa2f7ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
  },
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    touchpad = {
      tap_to_click = false,
      natural_scroll = false,
      clickfinger_behavior = true,
    },
    sensitivity = 0,
    -- -1.0 - 1.0, 0 means no modification.
  },
  master = {
    -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    orientation = "left",
    slave_count_for_center_master = 0,
    new_status = "master",
    mfact = 0.5,
  },
  misc = {
    disable_splash_rendering = true,
    disable_hyprland_logo = true,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = false,
    -- disabled for testing
  },
})

hl.workspace_rule({
  workspace = 1,
  persistent = true,
  monitor = "eDP-1",
})

hl.workspace_rule({
  workspace = 2,
  persistent = true,
  monitor = "eDP-1",
})

hl.workspace_rule({
  workspace = 3,
  persistent = true,
  monitor = "eDP-1",
})

hl.workspace_rule({
  workspace = 4,
  persistent = true,
  monitor = "eDP-1",
})

hl.workspace_rule({
  workspace = 5,
  persistent = true,
  monitor = "eDP-1",
})

hl.window_rule({
  name      = "workspace_1",
  match     = {
    class = "firefox",
  },
  workspace = 1,
})

-- Firefox PIP

hl.window_rule({
  name             = "Firefox_PIP_Window_Config",
  no_initial_focus = true,
  idle_inhibit     = "always",
  opacity          = "1.0 override 1.0 override",
  tile             = true,
  match            = {
    title = "^(Picture\\-in\\-Picture)$",
  },
})

hl.window_rule({
  name      = "kitty_window_config",
  match     = {
    class = "kitty",
  },
  workspace = 2,
})

-- Make sure FFPlay does not allow the computer to sleep
hl.window_rule({
  name         = "ffplay_window_config",
  no_blur      = false,
  idle_inhibit = "always",
  opacity      = "1.0 override 0.5 override",
  tile         = true,
  workspace    = 1,
  match        = {
    class = "ffplay",
  },
})

-- Do not dim twitch
hl.window_rule({
  name         = "Twitch_window_config",
  no_blur      = true,
  idle_inhibit = "focus",
  opacity      = "1.0 override 1.0 override",
  tile         = true,
  match        = {
    title = ".*Twitch.*",
  },
})


-- Do not dim youtube
hl.window_rule({
  name         = "Youtube_window_config",
  no_blur      = true,
  idle_inhibit = "focus",
  opacity      = "1.0 override 1.0 override",
  tile         = true,
  match        = {
    title = ".*YouTube.*",
  },
})

-- Do not dim Hearthstone
hl.window_rule({
  name         = "Hearthstone_window_config",
  no_blur      = true,
  idle_inhibit = "focus",
  opacity      = "1.0 override 1.0 override",
  tile         = true,
  match        = {
    title = "^(.*Hearthstone.*)$",
  },
})

-- Battle.net
hl.window_rule({
  name    = "battle_net_window_config",
  no_blur = true,
  opacity = "1.0 override 1.0 override",
  tile    = true,
  content = "game",
  match   = {
    class = "^(.*battle\\.net.*)$",
  },
})


-- Window Rules for obsidian

hl.window_rule({
  name      = "Obsidian_window_config",
  no_blur   = true,
  opacity   = "1.0 override 0.8 override",
  tile      = true,
  workspace = 3,
  match     = {
    title = "^(.*Obsidian.*)$",
  },
})



hl.bind(mainMod .. " + " .. "RETURN", hl.dsp.exec_cmd("kitty --title Kitty"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "C", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. ctrlMod .. " + " .. "Q", hl.dsp.exit())
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "V", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "P", hl.dsp.exec_cmd("wofi --style ~/.config/wofi/style.css --show drun"))


hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "F", hl.dsp.layout("swapwithmaster"))

-- Bind a printscreen button to take screenshots
hl.bind(mainMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Float Firefox Window and Set size
hl.bind(mainMod .. " + " .. "o", hl.dsp.window.float("active"))

-- Move workspace left and right
hl.bind(ctrlMod .. " + " .. "left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(ctrlMod .. " + " .. "right", hl.dsp.focus({ workspace = "e+1" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))

-- Alt Tab
hl.bind("ALT" .. " + " .. "tab", hl.dsp.window.cycle_next())

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Bindings that allow for zooming

-- bind = $ctrlMod, mouse_down, exec, \

--   hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | \

--   awk '/^float/ { print $2 * 1.5 }')

--

-- bind = $ctrlMod, mouse_up, exec, \

--   hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | \

--   awk '/^float/ { new = $2 * 0.5; if (new < 1) new = 1; print new;}')
