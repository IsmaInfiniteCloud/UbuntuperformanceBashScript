#!/bin/bash

# Function to display rotating symbols
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Function to display separator
separator() {
    echo "********************************"
}

# Function to display memory info
check_memory() {
    separator
    echo "Memory Usage:"
    free -h
}

# Function to display disk space
check_disk_space() {
    separator
    echo "Disk Space:"
    df -h
}

# Function to check internet speed
check_internet_speed() {
    separator
    echo "Internet Speed:"
    speedtest-cli | grep 'Download\|Upload'
}

# Display memory, disk space, and internet speed with visual effects
check_memory &
spinner
check_disk_space &
spinner
check_internet_speed &
spinner

separator

