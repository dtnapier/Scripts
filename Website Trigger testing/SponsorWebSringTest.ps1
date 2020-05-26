$webClient = new-object System.Net.WebClient

#Google control
$output = ""
$sitestring = $webClient.DownloadString("http://google.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("Google is unresponsive") }



#trpc401k
$output = ""
$sitestring = $webClient.DownloadString("http://www.trpc401k.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("TRPC401K is unresponsive") }



#Bencor
$output = ""
$sitestring = $webClient.DownloadString("https://bencor.rprgonline.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("Bencor is unresponsive") }



#Touchstone
$output = ""
$sitestring = $webClient.DownloadString("https://touchstone.rprgonline.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("Touchstone is unresponsive") }



#Printers
$output = ""
$sitestring = $webClient.DownloadString("https://printers401k.rprgonline.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("Printers is unresponsive") }



#NorthStar
$output = ""
$sitestring = $webClient.DownloadString("https://nsag.rprgonline.com")

   if ($sitestring -like "*Login*") {}
      else {
      $wshell = New-Object -ComObject Wscript.Shell
      $Output = $wshell.Popup("NorthStar is unresponsive") }
