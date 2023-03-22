#Stop vagrant process
Get-Process -Name *vagrant* | Stop-Process -Force
Get-Process -Name *ruby* | Stop-Process -Force

#Set enrironmentsscr
# VirtualBox home directory.
Start-Process -Wait -NoNewWindow -FilePath "E:\Apps\VirtualBox\VBoxManage.exe" `
    -ArgumentList  @("setproperty", "machinefolder", "E:\Servers\VirtualBox")
# Vagrant home directory for downloadad boxes.
setx VAGRANT_HOME "E:\Apps\Vagrant\vagrant.d" >$null

# Semafore for vagrant process
$scriptPath=$PSScriptRoot
$semafore="$scriptPath\vagrant-up.silvestrini"
New-Item -ItemType File -Path $semafore -Force >$null

#Vagrant Boxes
# $debian = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
# $debian5 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian5"
# $ol9 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"

#up ol8
# Set-Location $ol9
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-lpic2-202\virtualbox\private_key F:\Projetos\vagrant-pk\oracle-linux9

#up debian 11
# Set-Location $debian
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian_lpic2_202\virtualbox\private_key F:\Projetos\vagrant-pk\debian

#up debian 5
# Set-Location $debian5
# Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian5_lpic2_202\virtualbox\private_key F:\Projetos\vagrant-pk\debian5

#Server BIND
# $bind = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Bind"
# Set-Location $bind
# Start-Process -Wait -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-bind-master\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-master
# Copy-Item .\.vagrant\machines\debian-bind-slave\virtualbox\private_key F:\Projetos\vagrant-pk\debian-bind-slave
# Copy-Item .\.vagrant\machines\debian-bind-forwarding\virtualbox\private_key F:\Projetos\vagrant-pk\debian-bind-forwarding
# Copy-Item .\.vagrant\machines\ol9-bind-caching\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-caching
# Copy-Item .\.vagrant\machines\ol9-bind-client\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-client


#Servers HTTP
$http = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\HTTP"
Set-Location $http
Start-Process -Wait -WindowStyle Minimized -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "up"  -Verb RunAs
Copy-Item .\.vagrant\machines\ol9-bind-master\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-bind-master
Copy-Item .\.vagrant\machines\debian-bind-slave\virtualbox\private_key F:\Projetos\vagrant-pk\debian-bind-slave
Copy-Item .\.vagrant\machines\ol9-apache-ha\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-apache-ha
Copy-Item .\.vagrant\machines\ol9-nginx-ha\virtualbox\private_key F:\Projetos\vagrant-pk\ol9-nginx-ha
Copy-Item .\.vagrant\machines\debian-apache-node01\virtualbox\private_key F:\Projetos\vagrant-pk\debian-apache-node01
Copy-Item .\.vagrant\machines\debian-http-client\virtualbox\private_key F:\Projetos\vagrant-pk\debian-http-client

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#Remove Semafore
Remove-Item -Force $semafore