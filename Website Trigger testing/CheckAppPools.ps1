2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
import-module webadministration
 
	function main{
	#get-command -module webadministration will show all the IIS stuff
	$appPoolName = "SharePoint - www.mysite.com443"
	
	$dt = get-date
	$ComputerName = $env:computername
	If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
	{
		write-host "Failure detected, attempting to start it"
		start-webAppPool -name $appPoolName
		start-sleep -s 60
		
		If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
		{
			write-host "Tried to restart, but it didn't work!"
			sendmail "AppPoolRestart Failed" "App Pool $appPoolName restart on $ComputerName failed - this will effect search `n $dt"
			#log to event log
		}
		else
		{
			write-host "Looks like the app pool restarted ok"
			$subjectString = "AppPool Restart was needed"
			$body = "A routine check of the App Pool $appPoolName on $ComputerName found that it was not running, it has been started. `n $dt"
			sendmail $subjectString $body
			#log to event log?
		}
	}
	else
	 {
	 write-host "app pool $appPoolName is running"
	 }
 } #end main function
 
 function sendmail($subject, $body)
 {
    
    write-host "in Sendmail with subject: $subject, and body: $body"
	
	$EmailFrom = "WEBMONITOR@mydomain.com"
	$EmailTo = "jack@mydomain.com"
	$EmailBody = $body
	$EmailSubject = $subject
	$SMTPServer = "DNS.name.of.your.internal.smtp.server.com"
 
	Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $subject -body $EmailBody -SmtpServer $SMTPServer
	"Emailed $subject on $dt to $EmailTo" | out-file -filepath "CheckSearchAppPools.log" -append 
 }
 
 #call main function
 main