#!/bin/bash
# ANvänder för att lägga till flera IP i storage accounts vitlista
# Variabler
RESOURCE_GROUP="rg-customerprod-swedencentral-sftp-583"  # Ange din resursgrupp
STORAGE_ACCOUNT="adlssftp001"  # Ange ditt lagringskonto
IP_LIST=(
"13.69.64.208/28"
"13.69.71.192/27"
"20.82.14.39"
"20.82.15.2"
"20.86.93.32/27"
"20.86.93.64/28"
"20.103.131.1"
"20.103.132.139"
"20.103.158.245"
"20.103.159.225"
"20.126.241.238"
"20.126.243.151"
"40.91.208.65"
"52.174.88.118"
"52.174.180.160"
"137.117.161.181"
"13.69.171.0"
)

# Funktion för att lägga till IP-adresser till Storage Account Firewall
add_ip_to_firewall() {
    for IP in "${IP_LIST[@]}"; do
        echo "Lägger till IP-adress: $IP till Storage Account Firewall..."
        az storage account network-rule add \
            --resource-group $RESOURCE_GROUP \
            --account-name $STORAGE_ACCOUNT \
            --ip-address $IP
        sleep 1 # Vänta för att säkerställa att ändringen behandlas
    done
}

# Kör funktionen
add_ip_to_firewall

echo "Alla IP-adresser har lagts till i Storage Account Firewall."
