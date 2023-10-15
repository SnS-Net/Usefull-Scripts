#!/bin/bash

# Colors for terminal output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Header message
echo -e "${GREEN}** THANKS FOR CHECKING OUT SNS-NET USEFUL-SCRIPTS! **${RESET}"
echo -e "${YELLOW}This script pings a range of IP addresses that you specify and saves them to a file.${RESET}"

# Prompt the user to enter the network ID
read -p "Enter the first part of your network ID (e.g., class C = 192.168.1): " network_id

# Prompt for the starting and ending IP range with all 4 octets (e.g., 10.0.0.4)
read -p "Enter the starting IP address: " start_ip
read -p "Enter the ending IP address: " end_ip

# Validate IP addresses
if ! [[ $start_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ && $end_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo -e "
  ////////////////////////////////////////////////////////////////////////////
  \\ ${RED}Invalid IP address format. Please use the format 'x.x.x.x'.${RESET}\\
  ///////////////////////////////////////////////////////////////////////////"
  exit 1
fi

# Define the output file
output_file="responsive_ips.txt"

# Split IP addresses into components
IFS='.' read -r -a start_ip_parts <<< "$start_ip"
IFS='.' read -r -a end_ip_parts <<< "$end_ip"

# Loop through the IP range and ping each IP address
for ((i=${start_ip_parts[3]};i<=${end_ip_parts[3]};i++)); do
  ip="${network_id}.${i}"
  if ping -c 1 -W 1 "$ip" >/dev/null; then
    hostname=$(host "$ip" | awk '/has address/ {print $1}')
    echo -e "IP: ${YELLOW}$ip${RESET}, Hostname: ${YELLOW}$hostname${RESET}" >> "$output_file"
  fi
done

# Completion message
echo -e "
${GREEN}========================================================
Ping and hostname results are saved in $output_file
========================================================${RESET}"

echo -e " 
${YELLOW}********************************************
** THANK YOU FOR USING SNS USEFUL-SCRIPT! **
For more documentations check out the wiki:
https://github.com/SnS-Net/Usefull-Scripts/wiki/PING_MY_STUFF
********************************************${RESET}"

exit
