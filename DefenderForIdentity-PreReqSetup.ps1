# Specify the name of the gMSA you want to create:
$gMSA_AccountName = 'DfIDirAccess'
# Specify the name of the group you want to create for the gMSA
$gMSA_HostsGroupName = 'DfIServiceGroup'
# Specify the computer accounts that will become members of the gMSA group and have permission to use the gMSA.
$gMSA_HostNames = 'WIN-7S5SL2T1RK9','WIN-SVHIDGK7NIK','WIN-SA3SN0BCI9T'

## Script Pre-Reqs
Install-Module -Name DefenderForIdentity

## Execution
if (Get-KdsRootKey){
    Set-MDIConfiguration -Mode Domain -Configuration All
    New-MDIDSA -Identity $gMSA_AccountName -GmsaGroupName $gMSA_HostsGroupName
    $gMSA_HostNames | ForEach-Object { Get-ADComputer -Identity $_ } | ForEach-Object { Add-ADGroupMember -Identity $gMSA_HostsGroupName -Members $_ }
}
else{
    Write-Output "KDS Root Key not found. See: https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key"
}