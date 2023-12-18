
Add-WindowsFeature RSAT-AD-PowerShell

# Install Active Directory Domain Services
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote to Domain Controller and create a new forest
Install-ADDSForest `
    -DomainName "YourDomainName.com" `
    -DomainMode Win2012R2 `
    -ForestMode Win2012R2 `
    -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "YourPassword" -Force) `
    -Force:$true
