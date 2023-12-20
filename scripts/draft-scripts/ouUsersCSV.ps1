# Define the path to your CSV file
$csvPath = "C:\Users\Administrator\desktop\comp-org.csv"

# Import the ConvertFrom-Csv cmdlet
Import-Csv -Path $csvPath | ForEach-Object {
    # Extract user information from each row
    $ouName = $_.OU
    $firstName = $_.FirstName
    $lastName = $_.LastName
    $title = $_.Title
  
    # Call the Create-User function with the extracted data
    Create-User -ouName $ouName -firstName $firstName -lastName $lastName -title $title
  }