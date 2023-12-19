# Import the Active Directory module
Import-Module ActiveDirectory

# Function to create an Organizational Unit
function Create-OU {
    param (
        [string]$ouName
    )

    try {
        New-ADOrganizationalUnit -Name $ouName -Path "OU=Users,DC=corp,DC=BlueByte,DC=com" -ErrorAction Stop
        Write-Host "Organizational Unit '$ouName' created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error creating Organizational Unit: $_" -ForegroundColor Red
    }
}

# Function to create a User
function Create-User {
    param (
        [string]$firstName,
        [string]$lastName,
        [string]$userName,
        [string]$password
    )

    try {
        $userParams = @{
            SamAccountName  = $userName
            GivenName       = $firstName
            Surname         = $lastName
            UserPrincipalName = "$userName@corp.BlueByte.com"
            Name            = "$firstName $lastName"
            DisplayName     = "$firstName $lastName"
            Enabled         = $true
            Path            = "OU=Users,DC=corp,DC=BlueByte,DC=com"
            AccountPassword = (ConvertTo-SecureString -AsPlainText $password -Force)
            ChangePasswordAtLogon = $true
        }

        New-ADUser @userParams -ErrorAction Stop
        Write-Host "User '$userName' created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error creating user: $_" -ForegroundColor Red
    }
}

# Get user input for Organizational Unit
$ouName = Read-Host "Enter the name of the Organizational Unit"

# Get user input for User
$firstName = Read-Host "Enter the first name of the user"
$lastName = Read-Host "Enter the last name of the user"
$userName = Read-Host "Enter the username for the user"
$password = Read-Host "Enter the password for the user" -AsSecureString

# Call functions to create OU and User
Create-OU -ouName $ouName
Create-User -firstName $firstName -lastName $lastName -userName $userName -password $password
