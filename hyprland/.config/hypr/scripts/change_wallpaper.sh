#!/bin/bash

# Quit if hyprpaper is not running.
if pgrep -x niri > /dev/null; then
  if ! pgrep swww-daemon > /dev/null; then
    exit 0
  fi  
else
  if ! pgrep -x hyprpaper > /dev/null; then
    exit 0
  fi
fi
# Define daytime and nighttime image to respective variables
DAY_WALLPAPER=~/.config/hypr/wallpapers/Fuji-day.jpg
NIGHT_WALLPAPER=~/.config/hypr/wallpapers/Fuji-night.jpg
SHADE1_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade1.jpg
SHADE2_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade2.jpg
SHADE3_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade3.jpg
SHADE4_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade4.jpg

# Calculate the present hour and save it to a variable 
PRESENT_TIME=$(date +%H)

# Assign wallpaper depending on time
if [ "$PRESENT_TIME" -ge 9 ] && [ "$PRESENT_TIME" -lt 16 ]; then
	WALLPAPER=$DAY_WALLPAPER
elif [ "$PRESENT_TIME" -ge 16 ] && [ "$PRESENT_TIME" -lt 17 ]; then
	WALLPAPER=$SHADE1_WALLPAPER
elif [ "$PRESENT_TIME" -ge 17 ] && [ "$PRESENT_TIME" -lt 18 ]; then
	WALLPAPER=$SHADE2_WALLPAPER
elif [ "$PRESENT_TIME" -ge 18 ] && [ "$PRESENT_TIME" -lt 19 ]; then
	WALLPAPER=$SHADE3_WALLPAPER
elif [ "$PRESENT_TIME" -ge 19 ] && [ "$PRESENT_TIME" -lt 20 ]; then
	WALLPAPER=$SHADE4_WALLPAPER
elif [ "$PRESENT_TIME" -ge 5 ] && [ "$PRESENT_TIME" -lt 6 ]; then
	WALLPAPER=$SHADE4_WALLPAPER
elif [ "$PRESENT_TIME" -ge 6 ] && [ "$PRESENT_TIME" -lt 7 ]; then
	WALLPAPER=$SHADE3_WALLPAPER
elif [ "$PRESENT_TIME" -ge 7 ] && [ "$PRESENT_TIME" -lt 8 ]; then
	WALLPAPER=$SHADE2_WALLPAPER
elif [ "$PRESENT_TIME" -ge 8 ] && [ "$PRESENT_TIME" -lt 9 ]; then
	WALLPAPER=$SHADE1_WALLPAPER
else
	WALLPAPER=$NIGHT_WALLPAPER
fi

# echo "Applying wallpaper: $WALLPAPER"

# Apply the wallpaper to current display.
if pgrep -x niri > /dev/null; then
  swww img "$WALLPAPER" 
else
  if ! pgrep -x hyprpaper > /dev/null; then
    exit 0
  fi
	hyprctl hyprpaper wallpaper ",$WALLPAPER"
fi
# Exit with success.
exit 0

