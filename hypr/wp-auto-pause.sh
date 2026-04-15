#!/bin/bash

PROC="linux-wallpaperengine"
WP_CMD="SDL_AUDIODRIVER=dummy prime-run linux-wallpaperengine /home/Mokshagna/.local/share/Steam/steamapps/workshop/content/431960/3556568863 --silent --fps 30 --screen-root eDP-1 --volume 0 --disable-mouse --disable-parallax --scaling fill --max-memory-usage 1024 --no-audio-processing --no-sync --geometry 1920x1080 --disable-audio"

handle() {
  case $1 in
    workspace*|openwindow*|closewindow*|movewindow*)
      WINDOW_COUNT=$(hyprctl activeworkspace -j | jq '.windows')

      if [ "$WINDOW_COUNT" -gt 0 ]; then
        # KILL: Wipes VRAM instantly when you start working
        pkill -f "$PROC"
      else
        # --- THE 5-SECOND SHIELD ---
        # Only try to restart if it's not already running
        if ! pgrep -f "$PROC" > /dev/null; then
          # Wait 5 seconds to make sure you actually WANT the wallpaper
          sleep 5 
          
          # Re-check: Did you open a window during those 5 seconds?
          if [ "$(hyprctl activeworkspace -j | jq '.windows')" -eq 0 ]; then
             eval "$WP_CMD &"
          fi
        fi
      fi
      ;;
  esac
}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do 
    handle "$line"
done