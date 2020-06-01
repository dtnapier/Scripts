import-module webadministration
 
	function CheckAP($appPool) 
{
	#get-command -module webadministration will show all the IIS stuff
	$appPoolName = $appPool
	
	$dt = get-date
	$ComputerName = $env:computername
	If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
	{
		write-host "Failure detected, attempting to start it"
		start-webAppPool -name $appPoolName
		start-sleep -s 5
		
		If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
		{
			write-host "Tried to restart, but it didn't work!"
			#sendmail "AppPoolRestart Failed" "App Pool $appPoolName restart on $ComputerName failed - this will effect search `n $dt"
			#log to event log
		}
		else
		{
			write-host "Looks like the app pool restarted ok"
			$subjectString = "AppPool $appPoolName on $computerName was restarted"
			$body = "A routine check of the App Pool $appPoolName on $ComputerName found that it was not running, it has been started. `n $dt"
			sendmail $subjectString $body
		}
	}
	else
	 {
	 write-host "app pool $appPoolName is running"
	 }
 } #end CheckAP function
 
    function sendmail($subject, $body)
 {
    
    write-host "in Sendmail with subject: $subject, and body: $body"
	
	$EmailFrom = "App_pools@trpcweb.com"
	$EmailTo = "techadmin@trpcweb.com"
	$EmailBody = $body
	$EmailSubject = $subject
	$SMTPServer = "192.168.0.15"
 
	Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $subject -body $EmailBody -SmtpServer $SMTPServer
	"$subject on $dt to $EmailTo" | out-file -filepath "\\webapps8\e$\logs\apppools\AppPool_Check.log" -append 
 }

 #call main function
CheckAP "Bencor"
CheckAP "ReliusWeb"
CheckAP "ReliusWebAPI - RPRG"
CheckAP "RPRGONLINE"
CheckAP "Touchstone"
CheckAP "Printers"
