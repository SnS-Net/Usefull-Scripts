#!/bin/bash

# Error message for package installation failure
ERROR="There was a problem installing packages. Check network connections."

# Check ZeroTier status and store it in a variable
ZEROTIER_STATUS=$(sudo zerotier-cli status)

# Get ZeroTier interface IP address
ZEROTIER_IP=$(ifconfig | grep -A 1 "zt" | grep "inet")

# Print a welcome message
echo "
*************************************************************************
This is a simple installation script for ZeroTier!
It will require your ZeroTier Network ID to complete the installation.
*************************************************************************"
sleep 15

# Update system packages
echo "
----------------------------------------------
[INFO] : UPDATING YOUR SYSTEM PACKAGES!
----------------------------------------------"
sudo apt update && sudo apt dist-upgrade -y || echo "$ERROR"
sudo apt install curl -y && sudo apt install net-tools -y
sleep 2

# Prompt for ZeroTier Network ID
echo "
=====================================
What is your ZeroTier Network ID? :
====================================="
read -r NETWORK_ID

# Install ZeroTier and its dependencies
echo "
---------------------------------------------------
[INFO] : INSTALLING ZERO-TIER AND ITS DEPENDENCIES!
---------------------------------------------------"
curl -s https://install.zerotier.com | sudo bash
sleep 3

# Connect to the specified ZeroTier network
echo "
--------------------------------------------------
[INFO] : CONNECTING TO NETWORK: $NETWORK_ID
--------------------------------------------------"
sleep 5
sudo zerotier-cli join "$NETWORK_ID"
sleep 2

# Prompt to authorize the new interface
echo "
=========================================================================================
The installation was successful. Go to your ZeroTier account and AUTHORIZE your new interface!
TYPE 'ready' WHEN YOU'RE DONE!!!!!
========================================================================================="

read -r READY

if [ "$READY" == "ready" ]; then
    echo "Checking your network status \
    ******************************************** \
    ZeroTier status: $ZEROTIER_STATUS \
    ZeroTier IP: $ZEROTIER_IP \
    *********************************************" || echo "You typed '$READY' instead of 'ready'. \
    ##########################################################################
    You can verify your ZeroTier status using the following command: \
    sudo zerotier-cli status \
    ##########################################################################"
    exit
fi

echo "
===========================================
ALL DONE! THANKS FOR USING SNS_SCRIPTS!!!!!
==========================================="

exit
