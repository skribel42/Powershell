# Ensure Microsoft.Graph module is imported
Import-Module Microsoft.Graph

# Connect to Microsoft Graph (Make sure you have appropriate permissions)
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Function to generate a secure random password
function Generate-Password {
    $length = 6  # Define the length of the password
    $complexity = @(
        0..9   # Digits
        'a'..'z' # Lowercase letters
        'A'..'Z' # Uppercase letters
        '@', '#', '$', '%', '&', '*' # Special characters
    )
    
    $password = -join ((0..($length-1)) | ForEach-Object { $complexity | Get-Random })
    return $password
}

# Generate a temporary password
$tempPassword = Generate-Password

# Define user details as variables
$firstName = "John"
$lastName = "Doe"
$displayName = "$firstName $lastName"  # Full name (display name) of the user
$mailNickname = "jdoe"                 # Mail nickname (alias)
$userPrincipalName = "jdoe@yourdomain.com"  # User principal name (email)

# Define the user object
$user = @{
    AccountEnabled = $true
    DisplayName = $displayName
    GivenName = $firstName
    Surname = $lastName
    MailNickname = $mailNickname
    UserPrincipalName = $userPrincipalName
    PasswordProfile = @{
        ForceChangePasswordNextSignIn = $true
        Password = $tempPassword  # Use the generated temporary password
    }
    # Optionally, you can add additional properties here
}

# Create the user
$newUser = New-MgUser -BodyParameter $user

# Display the created user's details and temporary password
Write-Output "User created successfully."
Write-Output "User Principal Name: $($newUser.UserPrincipalName)"
Write-Output "Temporary Password: $tempPassword"

# OPTIONAL: Assign a license to the user
# Uncomment and adjust if needed
# Replace `LICENSE_SKU_ID` with the actual license SKU ID you want to assign
# $license = @{
#     AddLicenses = @(
#         @{
#             SkuId = "LICENSE_SKU_ID"
#         }
#     )
#     RemoveLicenses = @()
# }
# Set-MgUserLicense -UserId $newUser.Id -BodyParameter $license

# Disconnect from Microsoft Graph
Disconnect-MgGraph