# Define variables
$domainAdminUsername = "Administrator"
$domainAdminPassword = "YourPassword"
$domainName = "YourDomain.local"
$domainNetBIOSName = "YourDomain"
$domainAdminPasswordSecure = ConvertTo-SecureString $domainAdminPassword -AsPlainText -Force

# Set the execution policy (if needed)
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

# Install AD DS role
try {
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -ErrorAction Stop
    Write-Host "AD DS role installed successfully."
} catch {
    Write-Host "Error installing AD DS role: $_"
    exit 1
}

# Promote to domain controller
try {
    Install-ADDSDomainController -NoGlobalCatalog:$false `
        -CreateDnsDelegation:$false -CriticalReplicationOnly:$false -DatabasePath "C:\Windows\NTDS" `
        -DomainName $domainName -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false `
        -SiteName "Default-First-Site-Name" -SysvolPath "C:\Windows\SYSVOL" -Force:$true `
        -Credential (New-Object System.Management.Automation.PSCredential ($domainAdminUsername, $domainAdminPasswordSecure)) -ErrorAction Stop

    Write-Host "Domain controller promotion completed successfully."
} catch {
    Write-Host "Error promoting to domain controller: $_"
    exit 1
}

# Restart the server
try {
    Restart-Computer -Force -ErrorAction Stop
    Write-Host "Server restarted successfully."
} catch {
    Write-Host "Error restarting the server: $_"
    exit 1
}

# Script completed successfully
Write-Host "Script executed successfully."
exit 0

