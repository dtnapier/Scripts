#Test for TPM enabled. This will show in PDQ output log on the Deploy package
Try {(Get-WmiObject win32_tpm -Namespace root\cimv2\Security\MicrosoftTPM).isenabled() | Select-Object -ExpandProperty IsEnabled}
Catch{Return "TPM not enabled or not present"}

#Creating 3 variables to test for before encryption
$TPM = Get-WmiObject win32_tpm -Namespace root\cimv2\security\microsofttpm | where {$_.IsEnabled().Isenabled -eq 'True'} -ErrorAction SilentlyContinue
$WindowsVer = Get-WmiObject -Query 'select * from Win32_OperatingSystem where (Version like "6.2%" or Version like "6.3%" or Version like "10.0%") and ProductType = "1"' -ErrorAction SilentlyContinue
$BitLockerReadyDrive = Get-BitLockerVolume -MountPoint D: -ErrorAction SilentlyContinue

#Test variables and run encryption  
if ($WindowsVer -and $TPM -and $BitLockerReadyDrive) {
Add-BitLockerKeyProtector -MountPoint D: -RecoveryPasswordProtector
#adding autounlock - if removed a recovery password is needed to unlock
Enable-BitLockerAutoUnlock -MountPoint D:
sleep -Seconds 15 
Start-Process 'manage-bde.exe' -ArgumentList " -on D: -em aes256" -Verb runas -Wait
$RecoveryKeyGUID = (Get-BitLockerVolume -MountPoint D:).keyprotector | where {$_.Keyprotectortype -eq 'RecoveryPassword'} | Select-Object -ExpandProperty KeyProtectorID
manage-bde.exe  -protectors D: -adbackup -id $RecoveryKeyGUID
(Get-BitLockerVolume -MountPoint D:).KeyProtector.recoverypassword > "\\trpcweb.com\sdata\technology\InfoTechnology\BitLocker\Bitlocker Recovery Key $env:computername D Drive $RecoveryKeyGUID.txt"
#Restart-Computer - not needed since it's not a system drive
}
