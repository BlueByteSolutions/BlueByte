# Create Organizational Units (OUs)
New-ADOrganizationalUnit -Name "Sales" -Path "DC=YourDomainName,DC=com"
New-ADOrganizationalUnit -Name "Marketing" -Path "DC=YourDomainName,DC=com"

# Create Users
$ouPath = "OU=Sales,DC=YourDomainName,DC=com"
New-ADUser -SamAccountName "User1" -UserPrincipalName "User1@YourDomainName.com" -Name "User1" -GivenName "User" -Surname "One" -Enabled $true -Path $ouPath -AccountPassword (ConvertTo-SecureString -AsPlainText "User1Password" -Force) -PassThru

$ouPath = "OU=Marketing,DC=YourDomainName,DC=com"
New-ADUser -SamAccountName "User2" -UserPrincipalName "User2@YourDomainName.com" -Name "User2" -GivenName "User" -Surname "Two" -Enabled $true -Path $ouPath -AccountPassword (ConvertTo-SecureString -AsPlainText "User2Password" -Force) -PassThru