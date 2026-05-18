### --- Appearance & Shell Init --- ###
# Disable the greeting
set -g fish_greeting ""

# Initialize Starship (Must be at the top)
starship init fish | source

# Run fastfetch on startup
if status is-interactive
    fastfetch
end

### --- Environment Variables --- ###
# Fish uses fish_add_path for a cleaner $PATH
fish_add_path $HOME/.local/bin
set -gx SUDO_EDITOR nvim

### --- Aliases --- ###
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wp-stop='killall linux-wallpaperengine'
### --- Functions --- ###

# Wallpaper Engine Function (wp-show)
function wp-show
    set -l WP_ROOT "/home/Mokshagna/.local/share/Steam/steamapps/workshop/content/431960"
    set -l ID "3556568863"

    # Use the first argument if provided, otherwise use the default ID
    if count $argv > /dev/null
        set ID $argv[1]
    end

    # Kill existing process
    pkill -f linux-wallpaperengine 2>/dev/null

    # Run on NVIDIA for 3050 smoothness
    # Using 'nohup' and '&' for backgrounding in Fish
    begin
        set -x __NV_PRIME_RENDER_OFFLOAD 1
        set -x __GLX_VENDOR_LIBRARY_NAME nvidia
        set -x SteamAppId 0
        set -x SteamGameId 0
        set -x SDL_AUDIODRIVER dummy

        nohup linux-wallpaperengine "$WP_ROOT/$ID" \
            --layer background \
            --wayland \
            --silent \
            --fps 60 \
            --screen-root eDP-1 \
            --scaling fill \
            --no-shared-texture \
            --geometry 1920x1080 \
            --max-memory-usage 1024 >/dev/null 2>&1 &
    end
    disown
end

alias gamer='powerprofilesctl set performance'
alias silence='powerprofilesctl set power-saver'
alias batcheck='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias bgm='mpv --volume=50 --save-position-on-quit --watch-later-options-add=playlist-pos,curtime Music/J-POP+Outliers/ & disown'
alias clock-lock='sudo cpupower frequency-set -u 2.4GHz'
alias clock-unlock='sudo cpupower frequency-set -u 4.6GHz'
