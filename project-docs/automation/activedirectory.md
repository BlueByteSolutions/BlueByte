# Install RSAT-AD-PowerShell Feature:
    Uses the Add-WindowsFeature cmdlet to install the Remote Server Administration Tools (RSAT)

# User Input for Domain Configuration:
    Prompts the user to input the following information:
    Domain name
    NetBIOS name

# Install Required Windows Features:
    Uses the Install-WindowsFeature cmdlet to install the following features:
    AD-Domain-Services
    Windows-Server-Backup
    Includes management tools during the installation.

# Promote to Domain Controller and Configure Active Directory Forest:
    Uses the Install-ADDSForest cmdlet to promote the server to a domain controller and configure the Active Directory Forest.
    Configures the domain name, domain mode, forest mode, NetBIOS name, DNS installation, and enforces the operation with the force option.

# Restart the Server:
    Uses the Restart-Computer cmdlet to forcefully restart the server, completing the installation process.