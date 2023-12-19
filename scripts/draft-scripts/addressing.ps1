# Script Name:                  addressing.ps1
# Author:                       Michael Sineiro
# Date of latest revision:      12/18/2023
# Purpose:                     set static ip, dns, gateway and server name.


# Prompt for static IPv4 Address
$ipv4Address = Read-Host "Enter the static IPv4 address (e.g., 192.168.1.100)"

# Prompt for DNS server
$dnsServer = Read-Host "Enter the DNS server address (e.g., 8.8.8.8)"

# Prompt for default gateway
$defaultGateway = Read-Host "Enter the default gateway address (e.g., 192.168.1.1)"

# Prompt for new server name
$newServerName = Read-Host "Enter the new server name"

# Set static IPv4 address
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $ipv4Address -PrefixLength 24 -DefaultGateway $defaultGateway

# Set DNS server
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $dnsServer

# Rename the Windows Server
Rename-Computer -NewName $newServerName -Force -Restart
