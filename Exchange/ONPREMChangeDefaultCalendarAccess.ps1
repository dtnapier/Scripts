foreach ($Mailbox in (Get-Mailbox -ResultSize Unlimited)) { Set-MailboxFolderPermission -identity "$($Mailbox.Name):\Calendar" -AccessRights Reviewer -User Default }
