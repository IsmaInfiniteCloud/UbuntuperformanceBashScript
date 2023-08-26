#!/bin/bash

# This script displays system information using visual effects

# Function to display rotating symbols
spinner() {
    local pid=$!                     # Get the process ID of the last background command
    local delay=0.1                   # Delay between symbol rotations
    local spinstr='|/-\'             # Rotating symbols
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}       # Remove the first character from the symbol string
        printf " [%c]  " "$spinstr"   # Print the rotating symbol
        local spinstr=$temp${spinstr%"$temp"}  # Move the removed character to the end
        sleep $delay
        printf "\b\b\b\b\b\b"         # Move the cursor back to overwrite the symbol
    done
    printf "    \b\b\b\b"             # Clear the last symbol
}

# Function to display separator
separator() {
    echo "********************************"
}

# Function to display memory info
check_memory() {
    separator
    echo "Memory Usage:"
    free -h                           # Display memory usage in human-readable format
}

# Function to display disk space
check_disk_space() {
    separator
    echo "Disk Space:"
    df -h                             # Display disk space in human-readable format
}

# Function to check internet speed
check_internet_speed() {
    separator
    echo "Internet Speed:"
    speedtest-cli | grep 'Download\|Upload'  # Use speedtest-cli to check internet speed and filter for Download/Upload
}

# Display memory, disk space, and internet speed with visual effects
check_memory &       # Run check_memory in the background
spinner              # Display rotating symbols while check_memory is running
check_disk_space &   # Run check_disk_space in the background
spinner              # Display rotating symbols while check_disk_space is running
check_internet_speed &  # Run check_internet_speed in the background
spinner              # Display rotating symbols while check_internet_speed is running

separator            # Display a separator at the end

