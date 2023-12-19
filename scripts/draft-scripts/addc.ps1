Add-WindowsFeature RSAT-AD-PowerShell

# Define variables
$domainAdminUsername = "Administrator"
$domainAdminPassword = "YourPassword"
$domainName = "YourDomain.local"
$domainNetBIOSName = "YourDomain"
$domainAdminPasswordSecure = ConvertTo-SecureString $domainAdminPassword -AsPlainText -Force

# Install AD DS role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote to domain controller
Install-ADDSDomainController -NoGlobalCatalog:$false `
    -CreateDnsDelegation:$false -CriticalReplicationOnly:$false -DatabasePath "C:\Windows\NTDS" `
    -DomainName $domainName -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false `
    -SiteName "Default-First-Site-Name" -SysvolPath "C:\Windows\SYSVOL" -Force:$true `
    -Credential (New-Object System.Management.Automation.PSCredential ($domainAdminUsername, $domainAdminPasswordSecure))

# Restart the server
Restart-Computer -Force
