$WebsiteName = "google.com","bencor.rprgonline.com","abghouston.rprgonline.com","effortlessira.rprgonline.com","printers401k.rprgonline.com","touchstone.rprgonline.com","www.trpc401k.com" 
 
foreach ($website in $WebsiteName) { 
     
    $test = (Test-Connection -ComputerName $website -Count 3  | measure-Object -Property ResponseTime -Average).average 
    $response = ($test -as [int] ) 

    #This will display a pop-up if latency is higher than 250, equal to 0 (no response), or test-connection fails
    if ( ($response -gt 250) -OR ($response -eq 0) -OR ($test -eq $null) ) {    
    $wshell = New-Object -ComObject Wscript.Shell 
    $Output = $wshell.Popup("$website has a $response response time")}
	else {}
    
    #This just displays avg latency in a powershell window 
    #write-Host "The Average response time for" -ForegroundColor Green -NoNewline;write-Host " `"$website`" is " -ForegroundColor Red -NoNewline;;Write-Host "$response ms" -ForegroundColor Black -BackgroundColor white 
       
} 



#More Notification Types

<#Windows Banner
Add-Type -AssemblyName System.Windows.Forms 
$global:balloon = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
$balloon.BalloonTipText = 'What do you think of this balloon tip?'
$balloon.BalloonTipTitle = "Attention $Env:USERNAME" 
$balloon.Visible = $true 
$balloon.ShowBalloonTip(5000)
#>

<#Email
Send-MailMessage -From Alert@domain.com -To helpdesk@trpcweb.com -SmtpServer EX01 -Subject "[Auto] $Website is down" -Body "$website has a $response response time. It probably has a stuck process or is down."
#>
