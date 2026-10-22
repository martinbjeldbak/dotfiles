-- Catppuccin Frappé palette, from catppuccin/hyprland v2.0.0
local colors = require("themes.catppuccin-frappe")

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "DP-3", mode = "2560x1600@60", position = "auto", scale = 2 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto", scale = 2 })
-- vrr = 2 (fullscreen-only): CS2/gamescope gets VRR, desktop stays 144Hz (vrr=1 flickered the terminal).
-- Needs FreeSync Premium ON in monitor OSD.
hl.monitor({
  output   = "desc:Xiaomi Corporation Mi Monitor",
  mode     = "3440x1440@144",
  position = "0x0",
  scale    = 1,
  vrr      = 2,
})
hl.monitor({ output = "desc:AOC 28E850", mode = "1920x1080@60", position = "auto", scale = 2 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 }) -- fallback rule


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "vicinae toggle"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm app -- " .. terminal)
  hl.exec_cmd("uwsm app -- firefox")
  hl.exec_cmd("uwsm app -- 1password --silent", { workspace = "special silent" })
  hl.exec_cmd("uwsm app -- obsidian", { workspace = "3 silent" })
  hl.exec_cmd("uwsm app -- thunderbird", { workspace = "3 silent" })
  hl.exec_cmd("uwsm app -- vesktop", { workspace = "3 silent" })
  hl.exec_cmd("pactl set-default-sink alsa_output.pci-0000_09_00.1.hdmi-stereo.2")

  hl.exec_cmd("wl-paste --type text --watch cliphist store")   -- Stores only text data
  hl.exec_cmd("wl-paste --type image --watch cliphist store")  -- Stores only image data

  -- Get hyprctl working inside tmux
  -- See https://www.reddit.com/r/hyprland/comments/1bvbyz8/hyprland_instance_signature_not_updating_on/?share_id=f7sRUW4vDGBrtB5ITtYEO
  hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- unscale XWayland, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/
hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

-- NVIDIA: disabling hardware cursors avoids the stuck/ghost hardware cursor
-- that gets left mid-screen after a fullscreen (gamescope) app exits.
hl.config({
  cursor = {
    no_hardware_cursors = 1, -- 0 = use hw cursors if possible, 1 = don't use hw cursors, 2 = auto
  },
})

hl.config({
  general = {
    gaps_in  = 5,
    gaps_out = 20,

    border_size = 2,

    col = {
      active_border = {
        colors = {
          "rgba(" .. colors.mauveAlpha .. "ee)",
          "rgba(" .. colors.flamingoAlpha .. "ee)",
        },
        angle = 45,
      },
      inactive_border = "rgba(" .. colors.surface0Alpha .. "aa)",
    },

    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = true,

    layout = "dwindle",
  },

  decoration = {
    rounding = 10,

    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    blur = {
      enabled = true,
      size    = 3,
      passes  = 1,

      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/ for more
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

hl.config({
  misc = {
    force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout  = "us,dk",
    kb_variant = "",
    kb_model   = "",
    kb_options = "",
    kb_rules   = "",

    follow_mouse = 1,

    sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
    },
  },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager, { float = true }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen()) -- toggle fullscreen
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.exec_cmd("hyprctl switchxkblayout current next")) -- mainmod is now alt
hl.bind(mainMod .. " + code:51", hl.dsp.exec_cmd("1password")) -- win+\ for 1password
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))


-- gaming: to switch between windows in a floating workspace. src: https://www.reddit.com/r/hyprland/comments/1d57b9r/goodbye_hyprland/l6nlpb6/
hl.bind(mainMod .. " + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.bring_to_top()) -- bring it to the top
end)

-- Move focus with mainMod + arrow keys
-- NOTE: carried over as-is from the old config, but `k`/`j` both point `l` here (probably meant `u`/`d`).
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + j",     hl.dsp.focus({ direction = "l" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- The below binds move the window to / toggle the (unnamed) special workspace
hl.bind(mainMod .. " + G", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special(""))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
  name    = "wow-fullscreen",
  match   = { class = "^(wow\\.exe)$" },
  fullscreen = true,
  no_anim    = true,
})

-- CS2 (and other games) run inside gamescope; it shows up as class "gamescope".
-- No `immediate` (tearing) — tearing is mutually exclusive with VRR,
-- and we want FreeSync/VRR on the Xiaomi panel. Pick one; we chose VRR.
hl.window_rule({
  name    = "gamescope-game",
  match   = { class = "^(gamescope)$" },
  fullscreen = true,
  no_anim    = true,
})

-- Firefox PIP, Plex, mpv
-- Src https://github.com/hyprwm/Hyprland/issues/2942
hl.window_rule({
  name  = "pip-players-size-move",
  match = { title = "(Picture-in-Picture|(.*)mpv|(.*)VLC media player|Plex)" },
  size  = { 640, 360 },
  move  = { 1906, 14 },
})
hl.window_rule({
  name  = "pip-players-pin-float",
  match = { title = "^(Picture-in-Picture|(.*)mpv|(.*)VLC media player|Plex)" },
  pin   = true,
  float = true,
})

hl.window_rule({
  name  = "steam-bigpicture-fullscreen",
  match = { class = "^(steam)$", title = "^(Steam Big Picture Mode)$" },
  fullscreen = true,
})

-- https://github.com/hyprwm/Hyprland/discussions/10157
hl.window_rule({
  name  = "runelite-no-initial-focus",
  match = { class = "^(net-runelite-client-RuneLite)$", title = "^win(.*)$" },
  no_initial_focus = true,
})

-- 1Password sits hidden on the special workspace (see autostart above). When its
-- SSH agent needs to approve a request (e.g. Obsidian's git sync), it raises that
-- existing window via an xdg-activation request rather than mapping a new one, so
-- no_initial_focus doesn't apply -- this dedicated rule (Hyprland 0.56+) blocks the
-- forced focus/workspace switch, e.g. mid-game.
-- Src: https://github.com/hyprwm/Hyprland/discussions/12357
hl.window_rule({
  name  = "1password-no-activate-focus",
  match = { class = "^(1password)$" },
  focus_on_activate = false,
})


-- blur
hl.layer_rule({
  name  = "vicinae-blur",
  match = { namespace = "vicinae" },
  blur          = true,
  ignore_alpha  = 0,
  no_anim       = true,
})
