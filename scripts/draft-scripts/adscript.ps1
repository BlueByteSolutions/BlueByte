# Install Active Directory Domain Services
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote to Domain Controller and create a new forest
Install-ADDSForest `
    -DomainName "YourDomainName.com" `
    -DomainMode Win2012R2 `
    -ForestMode Win2012R2 `
    -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "YourPassword" -Force) `
    -Force:$true

# Create Organizational Units (OUs)
New-ADOrganizationalUnit -Name "Sales" -Path "DC=YourDomainName,DC=com"
New-ADOrganizationalUnit -Name "Marketing" -Path "DC=YourDomainName,DC=com"

# Create Users
$ouPath = "OU=Sales,DC=YourDomainName,DC=com"
New-ADUser -SamAccountName "User1" -UserPrincipalName "User1@YourDomainName.com" -Name "User1" -GivenName "User" -Surname "One" -Enabled $true -Path $ouPath -AccountPassword (ConvertTo-SecureString -AsPlainText "User1Password" -Force) -PassThru

$ouPath = "OU=Marketing,DC=YourDomainName,DC=com"
New-ADUser -SamAccountName "User2" -UserPrincipalName "User2@YourDomainName.com" -Name "User2" -GivenName "User" -Surname "Two" -Enabled $true -Path $ouPath -AccountPassword (ConvertTo-SecureString -AsPlainText "User2Password" -Force) -PassThru
