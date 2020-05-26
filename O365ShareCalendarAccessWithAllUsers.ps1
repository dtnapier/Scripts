#GIVE ALL USERs ACCESS TO ALL CALENDAR
cls
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Write-Output "======================================================="
Write-host "============= Setting Calendar Permission =============" -foreground "yellow"
Write-Output "======================================================="
$useAccess = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Select Identity
cls
Write-Host "AccessRights: None, Owner, PublishingEditor, Editor, PublishingAuthor, Author, NonEditingAuthor, Reviewer, Contributor" -foreground "yellow"
Write-Host "This script will attempt to modify and add a user permission. You may have an error message if the user is already added. Please ignore." -foreground "darkcyan"
Write-Host "---------------------" -foreground "gray"
$accRight=read-host "Please enter the desired access right for all users. Ex: Reviewer"
ForEach ( $user in $useAccess ) {
Get-Mailbox -ResultSize Unlimited | ForEach {
If ( $_.Identity -ne $user.Identity ) {
Add-MailboxFolderPermission "$($_.SamAccountName):\calendar" -User $user.Identity -AccessRights $accRight
Set-MailboxFolderPermission "$($_.SamAccountName):\calendar" -User $user.Identity -AccessRights $accRight
}
}
}
cls
Write-Output "======================================================="
Write-host "============ CALENDAR INFORMATION UPDATED =============" -foreground "green"
Write-Output "======================================================="
ForEach ($mbx in Get-Mailbox -ResultSize Unlimited) {Get-MailboxFolderPermission ($mbx.Name + “:\Calendar”) | Select Identity,User,AccessRights | ft -Wrap -AutoSize}