#!/bin/bash
# Colors for terminal output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "
-------------------------------------------------------------
${YELLOW} [INFO]:${RESET} Installing packages necessary for Python Networking
-------------------------------------------------------------"
# This defines an array of package names necessary for python networking
PACKAGES=(
    python3
    python3-pip
    micro
    expect
    build-essential
    libssl-dev
    libffi-dev
)

# Installing the packages using a "for" loop
for pkg in "${PACKAGES[@]}"; do
    sudo apt install -y "$pkg"  # Use -y to automatically confirm installation
done

echo "Install pip packages"

# Upgrade pip using the appropriate Python version (python3)
sudo python3 -m pip install --upgrade pip

# Install Python packages using pip3 (use pip3 for Python 3)
sudo python3 -m pip install paramiko netmiko

echo -e "
******************************************************
${GREEN} All DONE!!! THANKS FOR USING USEFULL-SCRIPTS ${RESET}
******************************************************"
exit
