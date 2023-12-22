# Script Name:                 ouUserCSV.ps1
# Author:                      Michael Sineiro
# Date of latest revision:     12/21/2023
# Purpose:                     Creates new OUs, fills them with predefined users, and creates corresponding security groups, adding members to each group

# Install the RSAT-AD-PowerShell module if not already installed
Add-WindowsFeature RSAT-AD-PowerShell -ErrorAction SilentlyContinue

# Import the Active Directory module
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Function to create an Organizational Unit and its security group
function Create-OUAndSecurityGroup {
    param (
        [string]$ouName
    )

    try {
        # Create the Organizational Unit
        New-ADOrganizationalUnit -Name $ouName -Path "DC=corp,DC=BlueByte,DC=com" -ErrorAction SilentlyContinue
        Write-Host "Organizational Unit '$ouName' created successfully." -ForegroundColor Green

        # Create the security group for the OU
        $groupName = "$ouName Users"
        New-ADGroup -Name $groupName -Path "OU=$ouName,DC=corp,DC=BlueByte,DC=com" -GroupScope Global -ErrorAction SilentlyContinue
        Write-Host "Security group '$groupName' created successfully." -ForegroundColor Green
    } catch {
        # Log error to a file or another output stream if needed
        # Alternatively, you can choose to not display any error messages
    }
}

# Function to create a User
function Create-User {
    param (
        [string]$ouName,
        [string]$position,
        [string]$name,
        [string]$department,
        [string]$title
    )

    try {
        $firstName, $lastName = $name -split ' ', 2
        $username = "$($firstName[0].ToString().ToLower()).$($lastName.ToLower())" -replace "[^\w\d]"
        $displayName = "$firstName $lastName" -replace "[^\w\d]"
        $password = ConvertTo-SecureString -String "Strongpass1" -AsPlainText -Force

        $userParams = @{
            SamAccountName         = $username
            GivenName              = $firstName
            Surname                = $lastName
            UserPrincipalName      = "$username@corp.BlueByte.com"
            Name                   = $displayName
            DisplayName            = $displayName
            Enabled                = $true
            Path                   = "OU=$ouName,DC=corp,DC=BlueByte,DC=com"
            AccountPassword        = $password
            ChangePasswordAtLogon  = $true
            Department             = $department
            Title                  = $title
        }

        New-ADUser @userParams -ErrorAction SilentlyContinue
        Write-Host "User '$username' created successfully." -ForegroundColor Green

        # Add user to the corresponding security group
        $groupName = "$($ouName) Users"
        Add-ADGroupMember -Identity $groupName -Members $username -ErrorAction SilentlyContinue
        Write-Host "User '$username' added to security group '$groupName'." -ForegroundColor Green
    } catch {
        # Log error to a file or another output stream if needed
        # Alternatively, you can choose to not display any error messages
    }
}

# Read data from CSV file
$csvData = Import-Csv -Path "C:\Users\Administrator\Desktop\comp-org.csv"

# Create OUs and security groups
foreach ($ou in ($csvData | Select-Object -Property Team -Unique)) {
    Create-OUAndSecurityGroup -ouName $ou.Team
}

# Create Users and add them to groups
foreach ($user in $csvData) {
    Create-User -ouName $user.Team -position $user.Position -name $user.Name -department $user.Department -title $user.Title
}
