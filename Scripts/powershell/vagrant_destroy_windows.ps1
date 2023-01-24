#Stop vagrant process
Get-Process -Name *vagrant* | Stop-Process -Force
Get-Process -Name *ruby* | Stop-Process -Force

#Vagrant Boxes
$debian  = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
$debian5 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian5"
$ol9     = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"
$bind    = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Bind"

#Destroy debian 11
Set-Location $debian
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy debian 5
Set-Location $debian5
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy centos
Set-Location $ol9
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy bind stack
Set-Location $bind
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs