#!/bin/bash

echo "Thank you for using sns-net scripts."
sleep 3
echo "Welcome, Admin! Let's add a new user."

# Prompt for username
read -p "Enter the username: " username

# Prompt for additional groups
read -p "Enter additional groups (comma-separated, press Enter for none): " groups

# Set default password to 'changeme'
password='changeme'

# Set password expiration to 90 days
expiration_date=$(date -d "+90 days" +%Y-%m-%d)

# Create the user with the specified options
sudo useradd -m -G $groups $username

# Set the password
echo "$username:$password" | sudo chpasswd

# Expire the password after 90 days
sudo chage -d $expiration_date $username

# Set "must change password at next login"
sudo chage -d 0 $username

echo "User $username added successfully!"
echo "
****************************************************************************************
The user will be prompted to change their password at the next login from 'changeme'.
They will have to change their password every 90 days for security.
****************************************************************************************"
sleep 5
echo "Thank you for using sns-net scripts."
