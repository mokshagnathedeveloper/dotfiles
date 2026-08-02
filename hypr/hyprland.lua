-- #######################################################################################
-- HYPRLAND CONFIG - NATIVE LUA
-- Official Reference: https://wiki.hypr.land/Configuring/Start/
-- #######################################################################################

---------------------
---- MY PROGRAMS ----
---------------------
local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "rofi -show drun"
local browser     = "zen-browser"

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@120",
    position = "0x0",
    scale    = 1,
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Services & Tools
    hl.exec_cmd("sleep 5 && conky & hyprpaper & waybar")
    hl.exec_cmd("batsignal -w 20 -c 10 -d 5 -f 80")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprctl setcursor Empty-Butterfly-Blue 48")

    -- Logic & Audio
    hl.exec_cmd("pw-play --volume=0.5 /home/Mokshagna/Downloads/kuru-kuru-herta-made-with-Voicemod.mp3")

    -- Shaders
    -- Replace hyprctl keyword with hyprctl eval
 hl.exec_cmd("hyprctl eval 'decoration:screen_shader = /home/Mokshagna/.config/hypr/shaders/ICC.frag" )
 end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QS_ICON_THEME", "Papirus-Dark")
hl.env("XCURSOR_THEME", "Empty-Butterfly-Blue")
hl.env("XCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("WLR_DRM_DEVICES", "/dev/dri/card1")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(284ec3ff)", "rgba(b9daf8ff)" }, angle = 90 },
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",
        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        screen_shader = "/home/Mokshagna/.config/hypr/shaders/ICC.frag",
        rounding = 10,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0x1a1a1aee,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },

        motion_blur = {
            enabled = true,
        },

        glow = {
            enabled      = true,
            range        = 18,
            render_power = 3,
            color        = { colors = { "rgba(284ec3ff)", "rgba(b9daf8ff)" }, angle = 45 },
        },
    },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
    },

    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

--------------------
---- ANIMATIONS ----
--------------------
-- Bezier curves
hl.curve("fluent_decel", { type = "bezier", points = { {0, 1}, {0, 1} } })

-- Animation tree
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 10, bezier = "fluent_decel", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 10, bezier = "fluent_decel", style = "slide" })

------------------
---- GESTURES ----
------------------
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name  = "rofi-float",
    match = { class = "rofi" },
    float = true,
    center = true,
    stay_focused = true,
})

hl.window_rule({
    name  = "floating-wifi-mod",
    match = { class = "floating_wifi" },
    float = true,
    center = true,
    size  = "600 400",
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Apps & Quick Launch
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wleave"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- Full Fullscreen (0)
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen({ mode = 0 }))

-- Maximize / Keep Gaps (1) 
hl.bind(mainMod .. " + Prior", hl.dsp.window.fullscreen({ mode = 1 }))

-- System Tools
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("/home/Mokshagna/.config/hypr/scripts/toggle_wallpaper.sh"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty --class floating_wifi -e nmtui"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("swaync-client --toggle-panel"))

-- Navigation & Layout
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + H", hl.dsp.layout("rotatesplit"))

-- Workspaces Navigation (1-10)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to '0'
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse Bindings
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Hardware / Multimedia Keys (Dell G15)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"),                         { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),                         { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -d *kbd_backlight* set 33%+"),    { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *kbd_backlight* set 33%-"),    { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"),      { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })

-- Extra Fn / Special Keys
hl.bind("XF86Calculator", hl.dsp.exec_cmd("kitty -e qalculator"))
hl.bind("XF86Search",     hl.dsp.exec_cmd(menu))
hl.bind("XF86HomePage",   hl.dsp.exec_cmd(browser))
hl.bind("XF86Mail",       hl.dsp.exec_cmd("thunderbird"))
hl.bind("XF86Display",    hl.dsp.workspace.toggle_special("magic"))
hl.bind("XF86Tools",      hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind("code:210",       hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind("code:107",       hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + code:107", hl.dsp.exec_cmd("hyprshot -m window"))
