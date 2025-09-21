#!/bin/bash

rm ~/dotfiles_camille/hyprland/.config/hypr/custom-by-hostname.conf &> /dev/null
ln -s "./custom-$HOSTNAME.conf" ~/dotfiles_camille/hyprland/.config/hypr/custom-by-hostname.conf &> /dev/null

