!/bin/bash

# Configuration
MONITOR="eDP-1"
WP_ROOT="/home/Mokshagna/.local/share/Steam/steamapps/workshop/content/431960"
ID="3556568863" # Iuno -5- Wallpaper

# Check if linux-wallpaperengine is already running
if pgrep -f "linux-wallpaperengine" > /dev/null
then
    # If it is running, kill it to clear VRAM
    pkill -f "linux-wallpaperengine"
else
    # If it is NOT running, launch with NVIDIA offload and your optimization flags
    # Using 'env' to pass the prime render and glx vendor variables
    nohup env __NV_PRIME_RENDER_OFFLOAD=1 \
        __GLX_VENDOR_LIBRARY_NAME=nvidia \
        SDL_AUDIODRIVER=dummy \
        linux-wallpaperengine "$WP_ROOT/$ID" \
        --wayland \
        --silent \
        --volume 0 \
        --fps 30 \
        --screen-root eDP-1 \
        --disable-mouse \
        --disable-parallax \
        --disable-audio \
        --scaling fill \
        --geometry 1920x1080 \
        --no-audio-processing \
        --no-sync \
        --max-memory-usage 1024 >/dev/null 2>&1 &
fi
