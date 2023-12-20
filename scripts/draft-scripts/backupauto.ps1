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
        [string]$password
    )

    try {
        $userName = ($firstName[0] + "." + $lastName).ToLower()
        $userParams = @{
            SamAccountName    = $userName
            GivenName         = $firstName
            Surname           = $lastName
            UserPrincipalName = "$userName@corp.BlueByte.com"
            Name              = "$firstName $lastName"
            DisplayName       = "$firstName $lastName"
            Enabled           = $true
            Path              = "OU=$ouName,DC=corp,DC=BlueByte,DC=com"
            AccountPassword   = (ConvertTo-SecureString -AsPlainText $password -Force)
            ChangePasswordAtLogon = $true
        }

        New-ADUser @userParams -ErrorAction Stop
        Write-Host "User '$userName' created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error creating user: $_" -ForegroundColor Red
    }
}

# Create Executive Team OUs and Users
$executiveTeamOUs = @("CEO", "CFO", "CTO", "COO")
foreach ($ou in $executiveTeamOUs) {
    Create-OU -ouName $ou
}

Create-User -ouName "CEO" -firstName "Martin" -lastName "Brody" -password "jmartintemppass1"
Create-User -ouName "CFO" -firstName "Larry" -lastName "Vaughn" -password "lvaughntemppass1"
Create-User -ouName "CTO" -firstName "Matt" -lastName "Hooper" -password "mhoopertemppass1"
Create-User -ouName "COO" -firstName "Quint" -lastName "" -password "qquinttemppass1"

# Create Sales Team OUs and Users
$salesTeamOUs = @("SalesManager", "MarketingSpecialist", "AccountExecutive")
foreach ($ou in $salesTeamOUs) {
    Create-OU -ouName $ou
}

Create-User -ouName "SalesManager" -firstName "Ellen" -lastName "Brody" -password "ebrodytemppass1"
Create-User -ouName "MarketingSpecialist" -firstName "Matt" -lastName "HooperJr" -password "mhooperjrtemppass1"
Create-User -ouName "AccountExecutive" -firstName "Harry" -lastName "Meadows" -password "hmeadowstemppass1"

# Create R&D OUs and Users
$rdOUs = @("RDManager", "SoftwareEngineer", "DataScientist", "UXUIDesigner")
foreach ($ou in $rdOUs) {
    Create-OU -ouName $ou
}

Create-User -ouName "RDManager" -firstName "Dr." -lastName "Elkins" -password "delkinstemppass1"
Create-User -ouName "SoftwareEngineer" -firstName "Mike" -lastName "Brody" -password "mbrodytemppass1"
Create-User -ouName "DataScientist" -firstName "Sean" -lastName "Brody" -password "sbrodytemppass1"
Create-User -ouName "UXUIDesigner" -firstName "Tina" -lastName "Wilcox" -password "twilcoxtemppass1"

# Create IT Management OUs and Users
$itOUs = @("ITDirector", "NetworkAdministrator", "CybersecuritySpecialist", "SystemAdministrator")
foreach ($ou in $itOUs) {
    Create-OU -ouName $ou
}

Create-User -ouName "ITDirector" -firstName "Leonard" -lastName "Hendricks" -password "lhendrickstemppass1"
Create-User -ouName "NetworkAdministrator" -firstName "Larry" -lastName "VaughnJr" -password "lvaughnjrtemppass1"
Create-User -ouName "CybersecuritySpecialist" -firstName "Carl" -lastName "Gottlieb" -password "cgottliebtemppass1"
Create-User -ouName "SystemAdministrator" -firstName "Josh" -lastName "Mills" -password "jmillsstemppass1"

# Create HR Management OUs and Users
$hrOUs = @("HRManager", "RecruitmentSpecialist", "EmployeeRelationsSpecialist", "TrainingCoordinator")
foreach ($ou in $hrOUs) {
    Create-OU -ouName $ou
}

Create-User -ouName "HRManager" -firstName "Lorraine" -lastName "Kitner" -password "lkitnertemppass1"
Create-User -ouName "RecruitmentSpecialist" -firstName "Sarah" -lastName "Thompson" -password "sthompsontemppass1"
Create-User -ouName "EmployeeRelationsSpecialist" -firstName "Robert" -lastName "Kintner" -password "rkintnertemppass1"
Create-User -ouName "TrainingCoordinator" -firstName "Amanda" -lastName "Mills" -password "amillstemppass1"
