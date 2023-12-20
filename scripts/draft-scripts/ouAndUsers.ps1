# Script Name:                  addressing.ps1
# Author:                       Michael Sineiro
# Date of latest revision:      12/18/2023
# Purpose:                      creates new ou's and fills them w/ inputed names and users.

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
            Path            = "OU=$ouName,DC=corp,DC=BlueByte,DC=com"
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

# Get user input for Users
$userCount = Read-Host "Enter the number of users to create"
$users = @()
for ($i = 1; $i -le $userCount; $i++) {
    $firstName = Read-Host "Enter the first name for user $i"
    $lastName = Read-Host "Enter the last name for user $i"
    $userName = Read-Host "Enter the username for user $i"
    $password = Read-Host "Enter the password for user $i" -AsSecureString

    $users += [PSCustomObject]@{
        FirstName = $firstName
        LastName = $lastName
        UserName = $userName
        Password = $password
    }
}

# Call functions to create OU and Users
Create-OU -ouName $ouName
foreach ($user in $users) {
    Create-User -ouName $ouName -firstName $user.FirstName -lastName $user.LastName -userName $user.UserName -password $user.Password
}
