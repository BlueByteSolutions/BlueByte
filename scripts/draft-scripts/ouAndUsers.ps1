Add-WindowsFeature RSAT-AD-PowerShell

Set-ExecutionPolicy RemoteSigned


# Function to create an Organizational Unit
function Create-OU {
    param (
        [string]$OUName
    )

    # Construct the LDAP path for the new OU
    $OUPath = "OU=$OUName,DC=yourdomain,DC=com" # Update with your actual domain information

    # Create the new OU
    New-ADOrganizationalUnit -Name $OUName -Path "OU=YourParentOU,DC=yourdomain,DC=com" -Description "Description for $OUName"
}

# Function to create a User
function Create-User {
    param (
        [string]$Username,
        [string]$Password,
        [string]$Description
    )

    # Construct the LDAP path for the new user
    $UserPath = "OU=YourOU,DC=yourdomain,DC=com" # Update with the OU path where you want to create the user

    # Create the new user
    New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@yourdomain.com" -Name $Username -GivenName $Username -Surname "User" -Description $Description -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -Enabled $true -Path $UserPath
}

# Main script

# Prompt for OU name
$OUName = Read-Host "Enter the name of the Organizational Unit (OU)"

# Create the OU
Create-OU -OUName $OUName

# Prompt for User details
$Username = Read-Host "Enter the username"
$Password = Read-Host -AsSecureString "Enter the password"
$Description = Read-Host "Enter the user description"

# Create the User
Create-User -Username $Username -Password $Password -Description $Description
