#/bin/bash
pacman -S base.txt
ln -sf ../run/systemd/resolve/stub-resolve.conf /etc/resolv.conf

