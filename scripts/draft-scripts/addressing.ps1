# Script Name: addressing.ps1
# Author: Michael Sineiro
# Date of latest revision: 12/18/2023
# Purpose: Set static IP, DNS, gateway, and server name.

# Function to validate IP address format
function Validate-IPAddress {
    param (
        [string]$IPAddress
    )

    if (-not ($IPAddress -as [ipaddress])) {
        Write-Host "Invalid IP address format. Please enter a valid address." -ForegroundColor Red
        exit
    }
}

# Function for error handling
function Handle-Error {
    param (
        [string]$ErrorMessage
    )

    Write-Host "Error: $ErrorMessage" -ForegroundColor Red
    exit
}

# Prompt for static IPv4 Address
$ipv4Address = Read-Host "Enter the static IPv4 address (e.g., 192.168.1.100)"
Validate-IPAddress -IPAddress $ipv4Address

# Prompt for DNS server
$dnsServer = Read-Host "Enter the DNS server address (e.g., 8.8.8.8)"
Validate-IPAddress -IPAddress $dnsServer

# Prompt for default gateway
$defaultGateway = Read-Host "Enter the default gateway address (e.g., 192.168.1.1)"
Validate-IPAddress -IPAddress $defaultGateway

# Prompt for new server name
$newServerName = Read-Host "Enter the new server name"

# Define the network interface alias
$networkInterfaceAlias = "Ethernet"

# Set static IPv4 address with error handling
try {
    New-NetIPAddress -InterfaceAlias $networkInterfaceAlias -IPAddress $ipv4Address -PrefixLength 24 -DefaultGateway $defaultGateway -ErrorAction Stop
} catch {
    Handle-Error -ErrorMessage $_.Exception.Message
}

# Set DNS server with error handling
try {
    Set-DnsClientServerAddress -InterfaceAlias $networkInterfaceAlias -ServerAddresses $dnsServer -ErrorAction Stop
} catch {
    Handle-Error -ErrorMessage $_.Exception.Message
}

# Rename the Windows Server with error handling
try {
    Rename-Computer -NewName $newServerName -Force -Restart -ErrorAction Stop
} catch {
    Handle-Error -ErrorMessage $_.Exception.Message
}

Write-Host "Addressing configuration completed successfully." -ForegroundColor Green
