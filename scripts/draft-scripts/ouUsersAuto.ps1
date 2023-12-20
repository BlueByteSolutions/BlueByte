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
        [string]$title
    )

    try {
        $username = "$($firstName[0]).$lastName" -replace "[^\w\d]"
        $displayName = "$title $firstName $lastName" -replace "[^\w\d]"
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

# Define OUs and Users
$ouList = @(
    "Executive Team",
    "Sales Team",
    "R&D",
    "IT",
    "HR"
)

$userList = @(
    ("CEO", "Martin", "Brody", "Executive Team"),
    ("CFO", "Larry", "Vaughn", "Executive Team"),
    ("CTO", "Matt", "Hooper", "Executive Team"),
    ("COO", "Quint", "William", "Executive Team"),
    ("Sales Manager", "Ellen", "Brody", "Sales Team"),
    ("Marketing Specialist", "Matt", "Hooper Jr.", "Sales Team"),
    ("Account Executive", "Harry", "Meadows", "Sales Team"),
    ("Social Media Coordinator", "Chrissie", "Watkins", "Sales Team"),
    ("R&D Manager", "Drake", "Elkins", "R&D"),
    ("Software Engineer", "Mike", "Brody", "R&D"),
    ("Data Scientist", "Sean", "Brody", "R&D"),
    ("UX/UI Designer", "Tina", "Wilcox", "R&D"),
    ("IT Director", "Leonard", "Hendricks", "IT"),
    ("Network Administrator", "Larry", "Vaughn Jr.", "IT"),
    ("Cybersecurity Specialist", "Carl", "Gottlieb", "IT"),
    ("System Administrator", "Josh", "Mills", "IT"),
    ("HR Manager", "Lorraine", "Kitner", "HR"),
    ("Recruitment Specialist", "Sarah", "Thompson", "HR"),
    ("Employee Relations Specialist", "Robert", "Kintner", "HR"),
    ("Training Coordinator", "Amanda", "Mills", "HR")
)

# Create OUs
foreach ($ou in $ouList) {
    Create-OU -ouName $ou
}

# Create Users
foreach ($user in $userList) {
    $ouName = $user[3]  # Use the provided OU name directly
    Create-User -ouName $ouName -firstName $user[1] -lastName $user[2] -title $user[0]
}
