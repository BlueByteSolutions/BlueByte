# Import the Active Directory module
Import-Module ActiveDirectory

# Function to create an Organizational Unit
function Create-OU {
    param (
        [string]$ouName
    )

    try {
        # Create the specified Organizational Unit
        New-ADOrganizationalUnit -Name $ouName -Path "DC=corp,DC=BlueByte,DC=com" -ErrorAction Stop
        Write-Host "Organizational Unit '$ouName' created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error creating Organizational Unit: $_" -ForegroundColor Red
    }
}

# Function to create a User
function Create-User {
    param (
        [string]$ouName,
        [string[]]$userNames,
        [string]$password
    )

    try {
        foreach ($userName in $userNames) {
            $userParams = @{
                SamAccountName  = $userName
                GivenName       = $userName
                Surname         = "LastName"
                UserPrincipalName = "$userName@corp.BlueByte.com"
                Name            = "$userName LastName"
                DisplayName     = "$userName LastName"
                Enabled         = $true
                Path            = "OU=$ouName,DC=corp,DC=BlueByte,DC=com"
                AccountPassword = (ConvertTo-SecureString -AsPlainText $password -Force)
                ChangePasswordAtLogon = $true
            }

            New-ADUser @userParams -ErrorAction Stop
            Write-Host "User '$userName' created successfully." -ForegroundColor Green
        }
    } catch {
        Write-Host "Error creating user: $_" -ForegroundColor Red
    }
}

# Get user input for Organizational Unit
$ouName = Read-Host "Enter the name of the Organizational Unit"

# Get user input for Users
$userCount = Read-Host "Enter the number of users to create"
$userNames = @()
for ($i = 1; $i -le $userCount; $i++) {
    $userNames += Read-Host "Enter the username for user $i"
}
$password = Read-Host "Enter the password for the users" -AsSecureString

# Call functions to create OU and Users
Create-OU -ouName $ouName
Create-User -ouName $ouName -userNames $userNames -password $password
