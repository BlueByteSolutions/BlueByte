# Ask for user input for IP address
$new_ip_address = Read-Host "Enter the new IP address for the server: "

# Ask for subnet mask
$subnet_mask = Read-Host "Enter the subnet mask for the server: "

# Ask for default gateway
$default_gateway = Read-Host "Enter the default gateway for the server: "

# Ask for DNS server addresses (comma-separated)
$dns_servers_string = Read-Host "Enter the DNS server addresses (comma-separated): "

# Convert comma-separated string to array of server addresses
$dns_servers = ($dns_servers_string -split ",") -replace '\s+',''

# Get the network adapter
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

# Set the static IP address
Set-NetIPAddress -IPAddress $new_ip_address -SubnetMask $subnet_mask -InterfaceIndex $adapter.InterfaceIndex -DefaultGateway $default_gateway

# Set the DNS server addresses
Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $dns_servers

# Rename the server
Rename-Computer -NewName $new_server_name

# Restart the ServerManager service for the changes to take effect
Restart-Service ServerManager

# Test the network connectivity
Ping -n 5 $default_gateway
Ping -n 5 $dns_servers

Write-Host "Server network configuration and name changed successfully!"



