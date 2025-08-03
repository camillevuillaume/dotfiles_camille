#!/bin/bash

sleep 1

# Define daytime and nighttime image to respective variables
DAY_WALLPAPER=~/.config/hypr/wallpapers/Fuji-day.jpg
NIGHT_WALLPAPER=~/.config/hypr/wallpapers/Fuji-night.jpg
SHADE1_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade1.jpg
SHADE2_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade2.jpg
SHADE3_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade3.jpg
SHADE4_WALLPAPER=~/.config/hypr/wallpapers/Fuji-shade4.jpg


# Preload the wallpapers.
#hyprctl hyprpaper preload "$DAY_WALLPAPER"
#hyprctl hyprpaper preload "$NIGHT_WALLPAPER"
#hyprctl hyprpaper preload "$SHADE1_WALLPAPER"
#hyprctl hyprpaper preload "$SHADE2_WALLPAPER"
#hyprctl hyprpaper preload "$SHADE3_WALLPAPER"  
#hyprctl hyprpaper preload "$SHADE4_WALLPAPER"

# Calculate the present hour and save it to a variable 
PRESENT_TIME=$(date +%H)

# In an if loop, check if current time is between 6 am and 6 pm 
# and assign day wallpaper to wallpaper variable.
# Else, if time is between 6 pm and 6 am, 
# assign night time wallpaper to wallpaper variable.
if [ $PRESENT_TIME -ge 9 ] && [ $PRESENT_TIME -lt 18 ]; then
	WALLPAPER=$DAY_WALLPAPER
elif [ $PRESENT_TIME -ge 16 ] && [ $PRESENT_TIME -lt 17 ]; then
	WALLPAPER=$SHADE1_WALLPAPER
elif [ $PRESENT_TIME -ge 17 ] && [ $PRESENT_TIME -lt 18 ]; then
  WALLPAPER=$SHADE2_WALLPAPER
elif [ $PRESENT_TIME -ge 18 ] && [ $PRESENT_TIME -lt 19 ]; then
  WALLPAPER=$SHADE3_WALLPAER
elif [ $PRESENT_TIME -ge 19 ] && [ $PRESENT_TIME -lt 20 ]; then
  WALLPAPER=$SHADE4_WALLPAPER
elif [ $PRESENT_TIME -ge 5 ] && [ $PRESENT_TIME -lt 6 ]; then
	WALLPAPER=$SHADE4_WALLPAPER
elif [ $PRESENT_TIME -ge 6 ] && [ $PRESENT_TIME -lt 7 ]; then
  WALLPAPER=$SHADE3_WALLPAPER
elif [ $PRESENT_TIME -ge 7 ] && [ $PRESENT_TIME -lt 8 ]; then
  WALLPAPER=$SHADE2_WALLPAPER
elif [ $PRESENT_TIME -ge 8 ] && [ $PRESENT_TIME -lt 9 ]; then
  WALLPAPER=$SHADE1_WALLPAPER
else	
	WALLPAPER=$NIGHT_WALLPAPER
fi

# Apply the wallpaper to current display.
hyprctl hyprpaper reload ,"$WALLPAPER"
hyprctl hyprpaper unload unused
# Exit with success.
exit 0

