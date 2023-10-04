#!/bin/bash/

ERROR="Their was a problem installing packages. Check Network Connections"
ZEROTIER_STATUS=$(sudo zerotier-cli status)
ZEROTIER_IP=$(ifconfig | grep -A 1 "zt" | grep "inet")
echo "
*************************************************************************
This is a Simple install script for your Zero-Tier Installations!!!!
It will require your Zero-Tier Network ID to commplete this installations
*************************************************************************"
sleep 15

echo "
----------------------------------------------
[INFO] : UP DATING YOUR SYSTEMS PACKAGAGES!!
----------------------------------------------"
sudo apt update && sudo apt dist-upgrade -y || echo "$ERROR"
sudo apt install curl -y && apt install net-tools
sleep 2

echo "
=====================================
What is your Zeroteir Network ID? e:
====================================="
read -NETWORK_ID

echo "
-----------------------------------------------
[INFO] : INSTALLING ZERO-TEIR AND IT'S DEPENDS!
-----------------------------------------------"
curl -s https://install.zerotier.com | sudo bash
sleep 3

echo "
--------------------------------------------------
[INFO] : Connecting to NETWORK: $NETWORK_ID
--------------------------------------------------"
sleep 5
sudo zerotier-cli join $NETWORK_ID
sleep 2

echo "
=========================================================================================
The install was successful go to your zerotier account and AUTHORIZE your new interface!
TYPE ready WHEN YOUR DONE!!!!!
========================================================================================="

read -READY

if [ $READY == ready ] then
    echo "Checking your network status  \
    ******************************************** \
    ZeroTier stats : $ZEROTIER_STATUS \
    ZeroTier IP: $ZEROTIER_IP \
    *********************************************" || echo " You typed $READY! instead of ready. \
    ##########################################################################
    You can check verify your zerotier status following command: \
    sudo zerotier-cli status \
    ##########################################################################"
    exit

echo "ALL DONE! THANKS FOR USING SNS_SCRIPTS!!!"

exit
    
