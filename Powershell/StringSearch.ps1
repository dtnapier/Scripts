#use this command to search for accounts in this folder
#replace "username" with whatever you want to search for

Get-ChildItem -Path '\\trpcweb.com\sdata\Technology\InfoTechnology\Procedures\User Accounts\Domain' -recurse | Select-String -pattern "username" 
