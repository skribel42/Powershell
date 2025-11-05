Get-ADUser -Filter 'enabled -eq $true' -Properties DisplayName, memberOf |
Select-Object `
    @{Name='oSamAccountName';Expression={$_.SamAccountName}},
    @{Name='UserName';Expression={$_.DisplayName}},
    @{Name='Groups';Expression={($_.memberOf -replace '^CN=([^,]+).+$','$1') -join ','}} |
Export-Csv "C:\ADUserGroups.csv" -NoTypeInformation -Encoding UTF8
