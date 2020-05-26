If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$Trmsvrs = "TRPCTS1", "TRPCTS2", "TRPCTS3", "TRPCTS4", "TRPCTS5", "TRPCTS6", "TRPCTS7", "TRPCTS8", "TRPCTS9", "TRPCTS10"

foreach ($trmsvr in $trmsvrs) {

$owners = gwmi win32_process -ComputerName $Trmsvr -Filter "Name='teams.exe'" | select name, @{n='owner';e={$_.getowner().user}}
$ownerlist = $owners.owner
Write-Host "$Trmsvr $ownerlist" -ForegroundColor "yellow"}


Write-host "Would you like to kill Teams on all Terminal Servers?" -ForegroundColor Yellow 
    $Readhost = Read-Host " ( y / n ) " 
    Switch ($ReadHost) 
     { 
       Y {Write-host "Yes, Killing Teams"
           foreach ($trmsvr in $trmsvrs) {Invoke-Command -ComputerName $Trmsvr {Stop-Process -name "teams"}}
         }     
       N {Write-Host "No. Not killing Teams"}
      
       Default {Write-Host "No input. Not Killing Teams"} 
      } 

Read-Host -Prompt "Press Enter to exit"