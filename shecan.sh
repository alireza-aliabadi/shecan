#!/bin/bash

# Spinner function - runs a command with a loading animation
spin_with_message() {
    local message="$1"
    shift
    local pid
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0

    # Run command in background
    "$@" &>/dev/null &
    pid=$!

    # Show spinner while command runs
    while kill -0 $pid 2>/dev/null; do
        printf "\r${spin:i++%${#spin}:1} %s" "$message"
        sleep 0.1
    done

    # Wait for command to finish and get exit code
    wait $pid
    local exit_code=$?

    # Clear spinner line
    printf "\r%-$((${#message} + 3))s\r" " "

    return $exit_code
}

read -p "Which action do you wanna run? [apply|disable]: " action

# Auto-detect active connection
connection=$(nmcli -t -f NAME connection show --active | head -n 1)

if [ -z "$connection" ]; then
    echo "No active network connection found!"
    exit 1
fi

echo "Detected active connection: $connection"

# action decision
if [ "$action" == "apply" ]; then
    read -p "What's your Shecan plan? [free|pro]: " plan
    # plan decision
    if [ "$plan" == "pro" ]; then
        dns="178.22.122.101 185.51.200.1"
        read -p "Enter your IP update link: " ip_update_link
    elif [ "$plan" == "free" ]; then
        dns="178.22.122.100 185.51.200.2"
    else
        echo "Invalid plan!"
        exit 1
    fi
    # applying shecan
    spin_with_message "Configuring DNS..." nmcli connection modify "$connection" ipv4.dns "$dns"
    spin_with_message "Setting auto-dns..." nmcli connection modify "$connection" ipv4.ignore-auto-dns yes
    spin_with_message "Reconnecting network..." bash -c "nmcli connection down '$connection' && nmcli connection up '$connection'"
    spin_with_message "Waiting for network stabilization..." sleep 5

    if [ "$plan" == "pro" ]; then
        if [ -n "$ip_update_link" ]; then
            spin_with_message "Updating Shecan DDNS..." curl -s "$ip_update_link"
        else
            echo "⚠️  IP update link not provided. Please update your IP manually in the Shecan panel."
        fi
    fi

    echo "✅ Shecan applied successfully!"

elif [ "$action" == "disable" ]; then
    spin_with_message "Removing DNS settings..." nmcli connection modify "$connection" ipv4.dns ""
    spin_with_message "Restoring auto-dns..." nmcli connection modify "$connection" ipv4.ignore-auto-dns no
    spin_with_message "Reconnecting network..." bash -c "nmcli connection down '$connection' && nmcli connection up '$connection'"
    echo "✅ Shecan disabled successfully!"

else
    echo "Invalid action!"
    exit 1
fi