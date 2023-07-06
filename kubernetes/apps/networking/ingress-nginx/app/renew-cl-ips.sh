#!/bin/bash

# Function to fetch and format IP addresses
fetch_ips() {
    url=$1
    # Fetch the IPs and replace newline characters with "\,"
    ips=$(curl -s $url | tr '\n' ',' | sed 's/,/\\,/g')
    echo -n "$ips"
}

# Fetch IPv4 addresses
ipv4_ips=$(fetch_ips "https://www.cloudflare.com/ips-v4")

# Fetch IPv6 addresses
ipv6_ips=$(fetch_ips "https://www.cloudflare.com/ips-v6")

# Combine IPv4 and IPv6 addresses with a comma and backslash
ips="$ipv4_ips\\,$ipv6_ips"

# Remove the trailing comma and its preceding backslash
ips=${ips%\\,}

# Print the formatted IP addresses with backslashes
echo "$ips" > kubernetes/apps/networking/ingress-nginx/app/cloudflare-proxied-networks.txt
