#Clear Exchange 2016 logs older than $days & create log

#create log file with C drive usage 
echo "C Drive" >"C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log"
$getC = Get-WmiObject -Class Win32_logicaldisk -Filter "DeviceID = 'C:'" | 
Select-Object -Property @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}}, @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}}
Add-Content -Path "C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log" -Value $getC

#Log the output of the log clear
Start-Transcript -Path "C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log" -Append -IncludeInvocationHeader

Set-Executionpolicy RemoteSigned
$days=7
$IISLogPath="C:\inetpub\logs\LogFiles\"
$ExchangeLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"
$ETLLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\ETLTraces\"
$ETLLoggingPath2="C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs"

Function CleanLogfiles($TargetFolder)
{
  write-host -debug -ForegroundColor Yellow -BackgroundColor Cyan $TargetFolder

    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
    #   $Files = Get-ChildItem $TargetFolder -Include *.log,*.blg, *.etl -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
        $Files = Get-ChildItem $TargetFolder -Recurse | Where-Object {$_.Name -like "*.log" -or $_.Name -like "*.blg" -or $_.Name -like "*.etl"}  | where {$_.lastWriteTime -le "$lastwrite"} | Select-Object FullName  
        foreach ($File in $Files)
            {
               $FullFileName = $File.FullName  
               Write-Host "Deleting file $FullFileName" -ForegroundColor "yellow"; 
                Remove-Item $FullFileName -ErrorAction SilentlyContinue | out-null
            }
       }
Else {
    Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}
CleanLogfiles($IISLogPath)
CleanLogfiles($ExchangeLoggingPath)
CleanLogfiles($ETLLoggingPath)
CleanLogfiles($ETLLoggingPath2)

#Stop logging the output
Stop-Transcript

#Get C drive usage after log clear
Add-Content -Path "C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log" -Value 'C drive'
Add-Content -Path "C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log" -Value $getC

#Change log name to current date
$datetime = get-date -f MMddyy-hhmmtt
Rename-item -path "C:\Program Files\Microsoft\Exchange Server\V15\Logging\LogClear.log" -newname ("LogClear" + $datetime + ".log")
