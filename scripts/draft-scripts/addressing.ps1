# Prompt user for static IPv4 address, subnet mask, and default gateway
$ipv4Address = Read-Host "Enter the static IPv4 address"
$subnetMask = Read-Host "Enter the subnet mask"
$defaultGateway = Read-Host "Enter the default gateway"

# Set the static IPv4 address
$networkInterface = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
$ipv4Configuration = $networkInterface | Get-NetIPInterface -AddressFamily IPv4
$ipv4Configuration | Set-NetIPInterface -Dhcp Enabled:$false
$networkInterface | New-NetIPAddress -IPAddress $ipv4Address -PrefixLength $subnetMask -DefaultGateway $defaultGateway

# Prompt user for DNS server
$dnsServer = Read-Host "Enter the DNS server address"

# Set DNS server
Set-DnsClientServerAddress -InterfaceAlias $networkInterface.Name -ServerAddresses $dnsServer

# Prompt user for new server name
$newServerName = Read-Host "Enter the new server name"

# Rename the server
Rename-Computer -NewName $newServerName -Force -Restart

Write-Host "Configuration completed. The server will now restart with the new settings."
