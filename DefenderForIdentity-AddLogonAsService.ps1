## Requires AD RSAT tools to be installed

install-module psPrivilege
$gMSAuser = (Get-ADServiceAccount -Identity DfIDirAccess)
Add-WindowsRight -Name SeServiceLogonRight -Account $gMSAuser.sid