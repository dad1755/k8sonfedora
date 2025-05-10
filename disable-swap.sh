#!/bin/bash

# Disable zram swap
swapoff /dev/zram0 2>/dev/null || true

# Mask zram service
systemctl stop systemd-zram-setup@zram0.service
systemctl mask systemd-zram-setup@zram0.service

# Create udev rule to disable zram
echo 'ACTION=="add", KERNEL=="zram0", ATTR{disksize}="0"' > /etc/udev/rules.d/99-disable-zram.rules
chmod 0644 /etc/udev/rules.d/99-disable-zram.rules
