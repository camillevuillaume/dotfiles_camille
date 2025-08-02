#!/bin/sh
sudo pacman -S --needed - < base_user.txt
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version
cd ..
rm -rf yay
git config --global user.name "Camille Vuillaume"
git config --global user.email camillevuillaume@gmail.com
