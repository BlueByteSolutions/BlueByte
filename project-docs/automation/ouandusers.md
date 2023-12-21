# Install RSAT-AD-PowerShell Feature:
    Uses the Add-WindowsFeature cmdlet to install the Remote Server Administration Tools
    (RSAT) feature for Active Directory PowerShell.

# Import Active Directory Module:
    Imports the Active Directory module using Import-Module ActiveDirectory.

# Functions for Creating Organizational Unit (OU) and User:

## Create-OU Function:
    Takes an OU name as a parameter.
    Attempts to create the specified Organizational Unit using New-ADOrganizationalUnit.
    Displays success or error messages.

## Create-User Function:
    Takes OU name, position, and name as parameters.
    Extracts first and last names from the full name, generates a username and display name.
    Sets user parameters and creates a new Active Directory user using New-ADUser.
    Displays success or error messages.

# Read Data from CSV File:
    Uses Import-Csv to read data from a CSV file located at "C:\Users\Administrator\Desktop\comp-org.csv".

# Create Organizational Units (OUs):
    Iterates over unique team names from the CSV data and calls the Create-OU function to create OUs.

# Create Users:
    Iterates over each row in the CSV data.
    Calls the Create-User function to create users within the respective OUs. User details are extracted from the CSV data.