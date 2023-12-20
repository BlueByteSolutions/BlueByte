# Script Name:                  addressing.ps1
# Author:                       Michael Sineiro
# Date of latest revision:      12/18/2023
# Purpose:                      creates new ou's and fills them w/ predifined names and users



Add-WindowsFeature RSAT-AD-PowerShell
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
        [string]$position,
        [string]$name
    )

    try {
        $firstName, $lastName = $name -split ' ', 2
        $username = "$($firstName[0].ToString().ToLower()).$($lastName.ToLower())" -replace "[^\w\d]"
        $displayName = "$firstName $lastName" -replace "[^\w\d]"
        $password = ConvertTo-SecureString -String "Strongpass1" -AsPlainText -Force

        $userParams = @{
            SamAccountName  = $username
            GivenName       = $firstName
            Surname         = $lastName
            UserPrincipalName = "$username@corp.BlueByte.com"
            Name            = $displayName
            DisplayName     = $displayName
            Enabled         = $true
            Path            = "OU=$ouName,DC=corp,DC=BlueByte,DC=com"
            AccountPassword = $password
            ChangePasswordAtLogon = $true
        }

        New-ADUser @userParams -ErrorAction Stop
        Write-Host "User '$username' created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error creating user: $_" -ForegroundColor Red
    }
}

# Read data from CSV file
$csvData = Import-Csv -Path "C:\Users\Administrator\Desktop\comp-org.csv"

# Create OUs
foreach ($ou in ($csvData | Select-Object -Property Team -Unique)) {
    Create-OU -ouName $ou.Team
}

# Create Users
foreach ($user in $csvData) {
    Create-User -ouName $user.Team -position $user.Position -name $user.Name
}
