# Validate IP Address Format:
    Validate-IPAddress takes a string parameter representing an IP address.
    It checks whether the provided string is a valid IP address format. 
    If not, it displays an error message in red and exits the script.

# Error Handling Function:
    Handle-Error takes a string parameter representing an error message.
    It displays the error message in red and exits the script.

# User Input for Configuration:
    prompts the user to input the following information:
    Static IPv4 Address
    DNS server address
    Default gateway address
    New server name
    
# Network Configuration:
    New-NetIPAddress cmdlet with error handling.
    Configures the DNS server address using the Set-DnsClientServerAddress cmdlet.
    Renames the Windows Server using the Rename-Computer cmdlet. 
    This includes a forceful restart.

# Output:
    If all the configuration steps are completed successfully, the script outputs a success message in green.
