#!/bin/bash
# swayidle configuration for multiple hosts

# Get the hostname
HOST1="ajax"
HOST2="achilles"
CONFIG_DIR="$HOME/.config/swayidle"


# Define idle parameters for host 1
if [ "$HOSTNAME" = "$HOST1" ]; then
  swayidle -w -C $CONFIG_DIR/swayidle_${HOST1}.conf 
  #echo $CONFIG_DIR/swayidle_${HOST1}.conf

# Define idle parameters for host2
elif [ "$HOSTNAME" = "$HOST2" ]; then
  swayidle -w -C $CONFIG_DIR/swayidle_${HOST2}.conf
  #echo $CONFIG_DIR/swayidle_${HOST2}.conf
fi

