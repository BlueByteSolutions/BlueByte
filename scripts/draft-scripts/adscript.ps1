# Import the Active Directory module
Import-Module ActiveDirectory

# Prompt user for domain name
$domainName = Read-Host "Enter the domain name (e.g., contoso.local):" -ValidatePattern "^[a-z0-9-]+\.[a-z0-9]+$"

# Prompt user for number of OUs
$ouCount = Read-Host "Enter the number of OUs you want to create:" -ValidateRange 1 999

# Loop to create OUs based on user input
for ($i = 1; $i -le $ouCount; $i++) {
  # Prompt user for individual OU name
  $ouName = Read-Host "Enter the name of OU #$i"

  # Create the OU with user-provided name
  New-ADOrganizationalUnit -Name $ouName -Path "DC1:\$domainName"

  # Write confirmation message
  Write-Host "OU '$ouName' created successfully!"

  # Prompt user for number of users within the current OU
  $userCount = Read-Host "Enter the number of users to create in OU '$ouName' (0 to skip):" -ValidateRange 0 999

  # Loop to create users based on user input
  for ($j = 1; $j -le $userCount; $j++) {
    # Prompt user for individual user details
    $userFirstName = Read-Host "Enter first name for user #$j in OU '$ouName':"
    $userLastName = Read-Host "Enter last name for user #$j in OU '$ouName':"
    $userName = Read-Host "Enter username for user #$j in OU '$ouName':"

    # Generate a random secure password
    $userPassword = ConvertTo-SecureString -AsPlainText -Force (New-Object System.Management.Automation.SecureString -constructor ([System.Security.SecureString], 'P@ssw0rd$!$23'))

    # Create the user in the specified OU
    New-ADUser -Name "$userFirstName $userLastName" -SamAccountName $userName -Password $userPassword -Enabled $true -OUPath "DC1:\$domainName\$ouName"

    # Write confirmation message with generated password
    Write-Host "User '$userFirstName $userLastName' created in OU '$ouName'. Password: $userPassword"
  }
}

Write-Host "All Organizational Units and Users created in domain '$domainName'!"
