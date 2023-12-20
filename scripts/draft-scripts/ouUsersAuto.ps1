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
        $username = "$($firstName[0]).$lastName"
        $password = ConvertTo-SecureString -String "Strongpass1" -AsPlainText -Force

        $userParams = @{
            SamAccountName  = $username
            GivenName       = $firstName
            Surname         = $lastName
            UserPrincipalName = "$username@corp.BlueByte.com"
            Name            = "$firstName $lastName"
            DisplayName     = "$title $firstName $lastName"
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
    ("CEO", "Martin", "Brody"),
    ("CFO", "Larry", "Vaughn"),
    ("CTO", "Matt", "Hooper"),
    ("COO", "Quint", "William"),
    ("Sales Manager", "Ellen", "Brody"),
    ("Marketing Specialist", "Matt", "Hooper Jr."),
    ("Account Executive", "Harry", "Meadows"),
    ("Social Media Coordinator", "Chrissie", "Watkins"),
    ("R&D Manager", "Drake", "Elkins"),
    ("Software Engineer", "Mike", "Brody"),
    ("Data Scientist", "Sean", "Brody"),
    ("UX/UI Designer", "Tina", "Wilcox"),
    ("IT Director", "Leonard", "Hendricks"),
    ("Network Administrator", "Larry", "Vaughn Jr."),
    ("Cybersecurity Specialist", "Carl", "Gottlieb"),
    ("System Administrator", "Josh", "Mills"),
    ("HR Manager", "Lorraine", "Kitner"),
    ("Recruitment Specialist", "Sarah", "Thompson"),
    ("Employee Relations Specialist", "Robert", "Kintner"),
    ("Training Coordinator", "Amanda", "Mills")
)

# Create OUs
foreach ($ou in $ouList) {
    Create-OU -ouName $ou
}

# Create Users
foreach ($user in $userList) {
    $ouName = $user[0].Split(' ')[-1]  # Extract department from the title
    Create-User -ouName $ouName -firstName $user[1] -lastName $user[2] -title $user[0]
}
