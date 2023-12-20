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
        [string]$role
    )

    try {
        $userName = "$($firstName[0]).$lastName"
        $password = "Strongpass1"

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

# Define OUs and users
$ouList = @(
    "Executive Team",
    "Sales Team",
    "R&D",
    "IT Management",
    "HR"
)

$userList = @(
    ("Martin", "Brody", "CEO"),
    ("Larry", "Vaughn", "CFO"),
    ("Matt", "Hooper", "CTO"),
    ("Quint", "", "COO"),
    ("Ellen", "Brody", "Sales Manager"),
    ("Matt", "Hooper Jr.", "Marketing Specialist"),
    ("Harry", "Meadows", "Account Executive"),
    ("Chrissie", "Watkins", "Social Media Coordinator"),
    ("Dr.", "Elkins", "R&D Manager"),
    ("Mike", "Brody", "Software Engineer"),
    ("Sean", "Brody", "Data Scientist"),
    ("Tina", "Wilcox", "UX/UI Designer"),
    ("Leonard", "Hendricks", "IT Director"),
    ("Larry", "Vaughn Jr.", "Network Administrator"),
    ("Carl", "Gottlieb", "Cybersecurity Specialist"),
    ("Josh", "Mills", "System Administrator"),
    ("Lorraine", "Kitner", "HR Manager"),
    ("Sarah", "Thompson", "Recruitment Specialist"),
    ("Robert", "Kintner", "Employee Relations Specialist"),
    ("Amanda", "Mills", "Training Coordinator")
)

# Call functions to create OUs and Users
foreach ($ou in $ouList) {
    Create-OU -ouName $ou
}

for ($i = 0; $i -lt $userList.Count; $i++) {
    $user = $userList[$i]
    Create-User -ouName $ouList[$i] -firstName $user[0] -lastName $user[1] -role $user[2]
}
