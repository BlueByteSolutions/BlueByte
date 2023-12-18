# Prompt for user input
$newIPAddress = Read-Host "Enter the new static IP address (e.g., 192.168.1.10): "
$newDNSServer = Read-Host "Enter the primary DNS server IP address (e.g., 8.8.8.8): "
$newServerName = Read-Host "Enter the new server name (e.g., MyServer): "

# Get active network adapter
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

# Check if adapter found
if (!$adapter) {
    Write-Error "No active network adapter found!"
    exit
}

# Get current configuration
$currentAdapterConfig = Get-NetIPConfiguration -InterfaceIndex $adapter.InterfaceIndex

# Disable DHCP
Set-NetIPAddress -IPAddress $currentAdapterConfig.IPv4Addresses[0].IPAddress -InterfaceIndex $adapter.InterfaceIndex -AddressFamily IPv4 -UnAssign

# Set static IP and subnet mask
Set-NetIPAddress -IPAddress $newIPAddress -InterfaceIndex $adapter.InterfaceIndex -AddressFamily IPv4 -PrefixLength 24

# Set default gateway
Set-NetRoute -InterfaceIndex $adapter.InterfaceIndex -DestinationPrefix 0.0.0.0 -NextHop $currentAdapterConfig.IPv4DefaultGateway

# Set primary DNS server
Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $newDNSServer

# Rename server
Rename-Computer $newServerName

# Restart network adapter to apply changes
Restart-NetAdapter $adapter.Name

Write-Host "The server has been successfully configured with:"
Write-Host "  - IP address: $newIPAddress"
Write-Host "  - DNS server: $newDNSServer"
Write-Host "  - Server name: $newServerName"

# Optionally, restart the server for complete name change
# Restart-Computer -Force

