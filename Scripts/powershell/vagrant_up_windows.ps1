<#
.Synopsis
   Up lab for learning
.DESCRIPTION
   Set folder of virtualbox VM's
   Create a semafore for vagrant up
   Copy public key for vagrant shared folder
   This script is used for create a new lab with vagrant.
   Create all VM's in Vagrantfile  
   Copy all private key of VM's for F:\Projetos\vagrant_pk folder   
.EXAMPLE
   & vagrant_up_windows.ps1
#>

# Clear screen
Clear-Host

#Stop vagrant process
Get-Process -Name *vagrant* | Stop-Process -Force
Get-Process -Name *ruby* | Stop-Process -Force

# Semafore for vagrant process
$scriptPath=$PSScriptRoot
$semafore="$scriptPath\vagrant-up.silvestrini"
New-Item -ItemType File -Path $semafore -Force >$null

# SSH
$ssh_path="$(($scriptPath | Split-Path -Parent)| Split-Path -Parent)\Security"
Copy-Item -Force "$env:USERPROFILE\.ssh\id_ecdsa.pub" -Destination $ssh_path

switch ($(hostname)) {
   "silvestrini" {
      # Variables
      $vagrant="E:\Apps\Vagrant\bin\vagrant.exe"
      $vagrantHome = "E:\Apps\Vagrant\vagrant.d" 
      $vagrantPK="$vagrantPK\"
      $baseVagrantfile="F:\CERTIFICACAO\lpic-2-202-450\Vagrant"
      $virtualboxFolder = "E:\Apps\VirtualBox"
      $virtualboxVMFolder = "E:\Servers\VirtualBox"

      # VirtualBox home directory.
      Start-Process -Wait -NoNewWindow -FilePath "$virtualboxFolder\VBoxManage.exe" `
      -ArgumentList  @("setproperty", "machinefolder", "$virtualboxVMFolder")
      # Vagrant home directory for downloadad boxes.
      setx VAGRANT_HOME "$vagrantHome" >$null
   }
   "silvestrini2" {      
      # Variables
      $vagrant="C:\Cloud\Vagrant\bin\vagrant.exe"
      $vagrantHome = "C:\Cloud\Vagrant\.vagrant.d" 
      $vagrantPK="C:\Cloud\Vagrant\vagrant-pk"
      $baseVagrantfile="C:\Users\marcos.silvestrini\OneDrive\Projetos\learning-lpic-2-202-450\Vagrant"
      $virtualboxFolder = "C:\Program Files\Oracle\VirtualBox"
      $virtualboxVMFolder = "C:\Cloud\VirtualBox"

      # VirtualBox home directory.
      Start-Process -Wait -NoNewWindow -FilePath "$virtualboxFolder\VBoxManage.exe" `
      -ArgumentList  @("setproperty", "machinefolder", "$virtualboxVMFolder")
      # Vagrant home directory for downloadad boxes.
      setx VAGRANT_HOME "$vagrantHome" >$null
   }
   Default {Write-Host "This hostname is not available for execution this script!!!";exit 1}
}

#Vagrant Boxes
# $debian = "$baseVagrantfile\Debian"
# $debian5 = "$baseVagrantfile\Debian5"
# $ol9 = "$baseVagrantfile\OracleLinux"

#up ol8
# Set-Location $ol9
# Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-lpic2-202\virtualbox\private_key $vagrantPK\oracle-linux9

#up debian 11
# Set-Location $debian
# Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian_lpic2_202\virtualbox\private_key $vagrantPK\debian

#up debian 5
# Set-Location $debian5
# Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\debian5_lpic2_202\virtualbox\private_key $vagrantPK\debian5

#Up Servers BIND
# $bind = "$baseVagrantfile\Bind"
# Set-Location $bind
# Start-Process -Wait -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-bind-master\virtualbox\private_key $vagrantPK\ol9-bind-master
# Copy-Item .\.vagrant\machines\debian-bind-slave\virtualbox\private_key $vagrantPK\debian-bind-slave
# Copy-Item .\.vagrant\machines\debian-bind-forwarding\virtualbox\private_key $vagrantPK\debian-bind-forwarding
# Copy-Item .\.vagrant\machines\ol9-bind-caching\virtualbox\private_key $vagrantPK\ol9-bind-caching
# Copy-Item .\.vagrant\machines\ol9-bind-client\virtualbox\private_key $vagrantPK\ol9-bind-client


#Up Servers HTTP
# $http = "$baseVagrantfile\HTTP"
# Set-Location $http
# Start-Process -Wait -WindowStyle Minimized -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-bind-master\virtualbox\private_key $vagrantPK\ol9-bind-master
# Copy-Item .\.vagrant\machines\debian-bind-slave\virtualbox\private_key $vagrantPK\debian-bind-slave
# Copy-Item .\.vagrant\machines\ol9-apache-ha\virtualbox\private_key $vagrantPK\ol9-apache-ha
# Copy-Item .\.vagrant\machines\ol9-nginx-ha\virtualbox\private_key $vagrantPK\ol9-nginx-ha
# Copy-Item .\.vagrant\machines\debian-apache-node01\virtualbox\private_key $vagrantPK\debian-apache-node01
# Copy-Item .\.vagrant\machines\debian-apache-node02\virtualbox\private_key $vagrantPK\debian-apache-node02
# Copy-Item .\.vagrant\machines\debian-http-client\virtualbox\private_key $vagrantPK\debian-http-client

# Up Servers FILE SHARING
# $fs = "$baseVagrantfile\FS"
# Set-Location $fs
# Start-Process -Wait -WindowStyle Minimized -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-server01\virtualbox\private_key $vagrantPK\ol9-server01
# Copy-Item .\.vagrant\machines\debian-server01\virtualbox\private_key $vagrantPK\debian-server01
# Copy-Item .\.vagrant\machines\debian-client01\virtualbox\private_key $vagrantPK\debian-client01

# Up Servers DHCP,PAM, LDAP
# $dhcp_ldap = "$baseVagrantfile\DHCP_LDAP"
# Set-Location $dhcp_ldap
# Start-Process -Wait -WindowStyle Minimized -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-server01\virtualbox\private_key $vagrantPK\ol9-server01
# Copy-Item .\.vagrant\machines\debian-server01\virtualbox\private_key $vagrantPK\debian-server01
# Copy-Item .\.vagrant\machines\debian-client01\virtualbox\private_key $vagrantPK\debian-client01


# Up Servers Mail
# $mail = "$baseVagrantfile\MAIL"
# Set-Location $mail
# Start-Process -Wait -WindowStyle Minimized -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
# Copy-Item .\.vagrant\machines\ol9-server01\virtualbox\private_key $vagrantPK\ol9-server01
# Copy-Item .\.vagrant\machines\debian-server01\virtualbox\private_key $vagrantPK\debian-server01
# Copy-Item .\.vagrant\machines\debian-client01\virtualbox\private_key $vagrantPK\debian-client01


$security = "$baseVagrantfile\SECURITY"
Set-Location $security
Start-Process -Wait -WindowStyle Minimized -FilePath $vagrant -ArgumentList "up"  -Verb RunAs
Copy-Item .\.vagrant\machines\ol9-server01\virtualbox\private_key $vagrantPK\ol9-server01
Copy-Item .\.vagrant\machines\ol9-server02\virtualbox\private_key $vagrantPK\ol9-server02
Copy-Item .\.vagrant\machines\debian-server01\virtualbox\private_key $vagrantPK\debian-server01
Copy-Item .\.vagrant\machines\debian-client01\virtualbox\private_key $vagrantPK\debian-client01

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#Remove Semafore
Remove-Item -Force $semafore