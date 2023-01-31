#Stop vagrant process
Get-Process -Name *vagrant* | Stop-Process -Force
Get-Process -Name *ruby* | Stop-Process -Force

#Set enrironmentsscr
# VirtualBox home directory.
Start-Process -Wait -NoNewWindow -FilePath "E:\Apps\VirtualBox\VBoxManage.exe" `
    -ArgumentList  @("setproperty", "machinefolder", "E:\Servers\VirtualBox")
# Vagrant home directory for downloadad boxes.
setx VAGRANT_HOME "E:\Apps\Vagrant\vagrant.d"

#Vagrant Boxes
$debian = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
$debian5 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian5"
$ol9= "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"

#up ol8
Set-Location $ol9
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-lpic2-202\virtualbox\private_key F:\Projetos\vagrant-pk\oracle-linux9

#up debian 11
Set-Location $debian
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian_lpic2_202\virtualbox\private_key F:\Projetos\vagrant-pk\debian

#up debian 5
Set-Location $debian5
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian5_lpic2_202\virtualbox\private_key F:\Projetos\vagrant-pk\debian5

#Server BIND
$bind = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Bind"
Set-Location $bind
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
Copy-Item .\.vagrant\machines\ol9-bind-master\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-master
Copy-Item .\.vagrant\machines\debian-bind-slave\virtualbox\private_key F:\Projetos\vagrant-pk\debian-bind-slave
Copy-Item .\.vagrant\machines\ol9-bind-caching\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-caching

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0