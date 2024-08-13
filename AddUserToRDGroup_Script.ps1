# Get user input for the new user's username
$newUserName = Read-Host "Enter the username of the new user"

# Define your domain
$domain = "Domain.name"  # Replace with your actual domain

# Construct the Distinguished Name (DN) of the new user
$newUserOU = "OU=EnterFirstOU,OU=SecondaryOU"  # Update with the correct OU path
$newUserDN = "CN=$newUserName,$newUserOU,DC=" + $domain.Replace('.', ',DC=')

# Define the group DN
$groupOU = "OU=IT_Admin,OU=AD Groups"  # RDP Access custom group
$groupDN = "CN=RDP Access,$groupOU,DC=" + $domain.Replace('.', ',DC=')

# Add the user to the group
Add-ADGroupMember -Identity $groupDN -Members $newUserDN

Write-Host "User $newUserName has been added to the RDP Access group."
