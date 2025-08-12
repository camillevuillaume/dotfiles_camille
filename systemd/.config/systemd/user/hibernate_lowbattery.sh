#!/usr/bin/env zsh

# Get battery info using acpi
acpi_out=$(acpi -b)
battery_percent=$(echo $acpi_out | grep -o '[0-9]\+%' | tr -d '%')
battery_status=$(echo $acpi_out | awk '{print $3}' | tr -d ',')

#echo "Battery Status: $battery_status"
#echo "Battery Percentage: $battery_percent%"

if [[ $battery_percent -le 5 && $battery_status == "Discharging" ]]; then
    systemctl hibernate
fi

