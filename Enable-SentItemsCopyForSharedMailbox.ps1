# This script allows for items sent from a shared mailbox to be viewable in the sent folder of the shared mailbox
# Import the Exchange Online Management module
Import-Module ExchangeOnlineManagement

# Connect to Exchange Online (ensure you have the appropriate permissions)
Connect-ExchangeOnline -UserPrincipalName admin@example.com

# Enable saving a copy of messages sent as the shared mailbox
Set-Mailbox "payroll@example.com" -MessageCopyForSentAsEnabled $True

# Enable saving a copy of messages sent on behalf of the shared mailbox
Set-Mailbox "payroll@example.com" -MessageCopyForSendOnBehalfEnabled $True

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
