Write-Host -ForegroundColor yellow "#######################################################"
""
#########################
"-------------------"
Write-Host -ForegroundColor Green "SECTION 1: Getting the list of users"
"-------------------"
# Write Information to the screen
Write-Host -ForegroundColor yellow "Exporting the list of users to c:\users\%username%\users.csv"
# List the users in c:\users and export to the local profile for calling later
dir C:\Users | select Name | Export-Csv -Path C:\users\$env:USERNAME\users.csv -NoTypeInformation
$list=Test-Path C:\users\$env:USERNAME\users.csv
""
#########################
"-------------------"
Write-Host -ForegroundColor Green "SECTION 2: Beginning Script..."
"-------------------"
##Files/folders not not needed in User folder loop

#Defunct folders and programs
Remove-Item -path "C:\ProgramData\SquirrelTemp" -Recurse -Force -EA SilentlyContinue -Verbose
Remove-Item -path "C:\ProgramData\WebEx" -Recurse -Force -EA SilentlyContinue -Verbose
Remove-Item -path "C:\ProgramData\Dropbox" -Recurse -Force -EA SilentlyContinue -Verbose

#Temp files
Remove-Item -path "C:\Windows\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose
Remove-Item -path "C:\`$recycle.bin\" -Recurse -Force -EA SilentlyContinue -Verbose

#Temp files with time delay
Get-ChildItem -path "C:\Temp\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
Get-ChildItem -path "C:\Windows\ServiceProfiles\LocalService\AppData\Local\~FontCache*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
Get-ChildItem -path "C:\Windows\ServiceProfiles\LocalService\AppData\Local\FontCache*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose

#Parallels logs - 6 months delayed
Get-ChildItem -path "C:\ProgramData\Parallels\RASLogs\univprn_*.log" -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-180))} | Remove-Item -Force -EA SilentlyContinue -Verbose


if ($list) {
<#
    "-------------------"
    #Clear Mozilla Firefox Cache
    Write-Host -ForegroundColor Green "SECTION 3: Clearing Mozilla Firefox Caches"
    "-------------------"
    Write-Host -ForegroundColor yellow "Clearing Mozilla caches"
    Write-Host -ForegroundColor cyan
    Import-CSV -Path C:\users\$env:USERNAME\users.csv -Header Name | foreach {
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\*.* -Recurse -Force -EA SilentlyContinue -Verbose
	        Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache2\entries\*.* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\thumbnails\* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cookies.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\webappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\chromeappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            }
    Write-Host -ForegroundColor yellow "Clearing Mozilla caches"
    Write-Host -ForegroundColor yellow "Done..."
    ""
#>
    "-------------------"
    # Clear Google Chrome 
    Write-Host -ForegroundColor Green "SECTION 4: Clearing Google Chrome Caches"
    "-------------------"
    Write-Host -ForegroundColor yellow "Clearing Google caches"
    Write-Host -ForegroundColor cyan
    Import-CSV -Path C:\users\$env:USERNAME\users.csv -Header Name | foreach {
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Service Worker\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\PepperFlash" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\SwReporter" -Recurse -Force -EA SilentlyContinue -Verbose

        # Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\ChromeDWriteFontCache" -Recurse -Force -EA SilentlyContinue -Verbose
            }

    Write-Host -ForegroundColor yellow "Done..."
    ""
    "-------------------"
    # Clear Internet Explorer, Windows Temp, and Recycle Bin
    Write-Host -ForegroundColor Green "SECTION 5: Clearing other caches and folders"
     "-------------------"
    Write-Host -ForegroundColor yellow "Clearing other caches and folders"
    Write-Host -ForegroundColor cyan
    Import-CSV -Path C:\users\$env:USERNAME\users.csv | foreach { 

        #Defunct folders and programs
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Teams" -Recurse -Force -EA SilentlyContinue -Verbose
	    Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\TeamsMeetingAddin" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\TeamsPresenceAddin" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\SquirrelTemp" -Recurse -Force -EA SilentlyContinue -Verbose
	    Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Cisco" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Webex" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows Mail" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows Media" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\eght-meet-electron" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\GoToMeeting" -Recurse -Force -EA SilentlyContinue -Verbose
       
        #Temp files
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WebCache\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose
        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Force -EA SilentlyContinue -Verbose
        
        #Temp files with time delay
        Get-ChildItem -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Internet Explorer\Recovery\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
	    Get-ChildItem -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Terminal Server Client\Cache\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-2))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
        Get-ChildItem -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Internet Explorer\Indexed DB\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose        
        Get-ChildItem -path "C:\Users\$($_.Name)\AppData\Local\\Microsoft\Windows\INetCache\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
        Get-ChildItem -path "C:\Users\$($_.Name)\AppData\LocalLow\Microsoft\CryptnetUrlCache\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
                      
        #Downloads older than 5 days
        Get-ChildItem "C:\Users\$($_.Name)\Downloads\*" -Recurse -EA SilentlyContinue | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-5))} | Remove-Item -Recurse -Force -EA SilentlyContinue -Verbose
            
            }
    Write-Host -ForegroundColor yellow "Done..."
    ""
    Write-Host -ForegroundColor Green "All Tasks Done!"
    } else {
	Write-Host -ForegroundColor Yellow "Session Cancelled"	
	Read-Host -Prompt "Press Enter to exit"
	}
