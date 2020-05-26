
$user = "visharma"
$servers = @("trpcts1","trpcts2","trpcts3","trpcts4","trpcts5","trpcts6","trpcts7","trpcts8","trpcts9","trpcts10","trpcts12")

foreach ($server in $servers) { 
if (Test-Path \\$server\c$\users\$user\downloads) {
ii \\$server\c$\users\$user\downloads}
}
if (Test-Path \\trpcfs1\sdata\profiles$\$user.TRPCWEB.V2\Downloads) {
ii \\trpcfs1\sdata\profiles$\$user.TRPCWEB.V2\Downloads}


$Daysback = "-14"
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
$Path = "\\trpcfs1\sdata\profiles$\$user.TRPCWEB.V2\Downloads"
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item

foreach ($server in $servers) {
$Path = "\\$server\c$\users\$user\downloads"
if (Test-Path $Path) {
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item}
}
