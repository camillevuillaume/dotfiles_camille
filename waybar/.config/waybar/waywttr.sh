#!/usr/bin/env bash

# A simple script to fetch and display weather information for a specified location using wttr.in


weather_bar() {
  curl "wttr.in/${LOCATION}?format=1" 2>/dev/null
}


weather_popup() {
  curl "wttr.in/${LOCATION}?3nF" 2>/dev/null
  read -s -n 1
}


get_config() {
  if [[ -f "$HOME/.config/waywttr.conf" ]]; then
    source "$HOME/.config/waywttr.conf"
  elif [[ -f "$HOME/.config/waybar/waywttr.conf" ]]; then
    source "$HOME/.config/waybar/waywttr.conf"
  else
    #Use default values
    LOCATION="Paris"
  fi
}


# barsymbol("Tokyo")
get_config
if [ "$1" == "bar" ]; then
  weather_bar
elif [ "$1" == "popup" ]; then
  weather_popup
else
  echo "Usage: $0 [bar|popup]"
  exit 1
fi
exit 0
