#!/bin/bash

# Check so we have at least two inputs
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 ip1 ip2 ... port1 port2 ..."
    echo "Example: $0 192.168.1.1 192.168.1.2 22 80 443"
    exit 1
fi

#split arguments to IPs and Ports
ips=()
ports=()

# Loop
for arg in "$@"; do
    if [[ "$arg" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        ips+=("$arg")
    elif [[ "$arg" =~ ^[0-9]+$ ]]; then
        ports+=("$arg")
    else
        echo "Invalid argument: $arg"
        exit 1
    fi
done

# Check so we have at least one IP and one port
if [ "${#ips[@]}" -eq 0 ] || [ "${#ports[@]}" -eq 0 ]; then
    echo "You need to supply at least one IP and one port"
    exit 1
fi

# Loop genom IP-adresser och portar
for ip in "${ips[@]}"; do
    for port in "${ports[@]}"; do
        nc -vz -w1 "$ip" "$port" &>/dev/null && \
        echo "$ip:$port is open" || \
        echo "$ip:$port is closed"
    done
done
