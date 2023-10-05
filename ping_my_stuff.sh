#!/bin/bash
## THANKS FOR CHECKING OUT SNS-NET USFULL-Scrips!! This is inteded to ping a range of ip address  that you specify and save them to a file. 

# This will prompt you to enter the network ID (ex: for a CLASS C = '192.168.122'.... CLASS B = '10.0')
read -p "Enter the first part of you network ID (e.g., class C = 192.168.1): " network_id

# This will prompt for the starting and ending IP range with all 4 octects (e.g., 10.0.0.4)
read -p "Enter the starting IP address: " start_ip
read -p "Enter the ending IP address: " end_ip

# Validate IP addresses
if ! [[ $start_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ && $end_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid IP address format. Please use the format 'x.x.x.x'."
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
    hostname=$(nslookup "$ip" | awk '/^Name:/ {print $2}')
    echo "IP: $ip, Hostname: $hostname" >> "$output_file"
  fi
done

echo "
========================================================
Ping and hostname results are saved in $output_file
========================================================"

echo " 
********************************************
**THANK YOU FOR USING SNS USFULL-SCRIPT!!***
********************************************"

exit
