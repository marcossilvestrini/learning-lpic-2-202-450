<#
.Synopsis
   Destroy lab for learning
.DESCRIPTION
   This script is used for destroy lab with vagrant.
   Destroy and delete all VM's in Vagrantfile
   Delete all folders with VM's in Vagrantfile
.EXAMPLE
   & vagrant_destroy_windows.ps1
#>

#Stop vagrant process
Get-Process -Name *vagrant* | Stop-Process -Force
Get-Process -Name *ruby* | Stop-Process -Force

#  define variables
switch ($(hostname)) {
    "silvestrini" {       
        $vagrant = "E:\Apps\Vagrant\bin\vagrant.exe"
        $baseVagrantfile = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant"
        $vagrantHome = "E:\Apps\Vagrant\vagrant.d"      
        $virtualboxFolder = "E:\Apps\VirtualBox"
        $virtualboxVMFolder = "E:\Servers\VirtualBox" 
    }
    "silvestrini2" {      
        # Variables
        $vagrant = "C:\Cloud\Vagrant\bin\vagrant.exe"       
        $baseVagrantfile = "C:\Users\marcos.silvestrini\OneDrive\Projetos\learning-lpic-2-202-450\Vagrant"
        $vagrantHome = "C:\Cloud\Vagrant\.vagrant.d"      
        $virtualboxFolder = "C:\Program Files\Oracle\VirtualBox"
        $virtualboxVMFolder = "C:\Cloud\VirtualBox"
    }
    Default { Write-Host "This hostname is not available for execution this script!!!"; exit 1 }
}

# VirtualBox home directory.
Start-Process -Wait -NoNewWindow -FilePath "$virtualboxFolder\VBoxManage.exe" `
    -ArgumentList  @("setproperty", "machinefolder", "$virtualboxVMFolder")

# Vagrant home directory for downloadad boxes.
setx VAGRANT_HOME $vagrantHome >$null

#Vagrant Boxes
$debian = "$baseVagrantfile\Debian"
$debian5 = "$baseVagrantfile\Debian5"
$ol9 = "$baseVagrantfile\OracleLinux"
$bind = "$baseVagrantfile\Bind"
$http = "$baseVagrantfile\HTTP"
$fs = "$baseVagrantfile\FS"
$dhcp_ldap = "$baseVagrantfile\DHCP_LDAP"
$mail = "$baseVagrantfile\MAIL"
$security = "$baseVagrantfile\SECURITY"

# Folder vagrant virtualbox machines artefacts
$vmFolders = @(
    "$virtualboxVMFolder\ol9-bind-master",
    "$virtualboxVMFolder\debian-bind-slave",
    "$virtualboxVMFolder\debian-apache-node01",
    "$virtualboxVMFolder\debian-apache-node02",
    "$virtualboxVMFolder\ol9-apache-ha",
    "$virtualboxVMFolder\ol9-nginx-ha",
    "$virtualboxVMFolder\debian-http-client",
    "$virtualboxVMFolder\ol9-server01",
    "$virtualboxVMFolder\ol9-server02",
    "$virtualboxVMFolder\debian-server01",
    "$virtualboxVMFolder\debian-client01"
)

#Destroy debian 11
Set-Location $debian
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy debian 5
Set-Location $debian5
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy centos
Set-Location $ol9
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy bind stack
Set-Location $bind
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy http stack
Set-Location $http
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy fs stack
Set-Location $fs
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy dhcp_ldap stack
Set-Location $dhcp_ldap
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy mail stack
Set-Location $mail
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

#Destroy security stack
Set-Location $security
Start-Process -Wait -WindowStyle Hidden  -FilePath $vagrant -ArgumentList "destroy -f"  -Verb RunAs

# Delete folder virtualbox machines artefacts
$vmFolders | ForEach-Object {
    If (Test-Path $_) {
        If ( (Get-ChildItem -Recurse $_).Count -lt 3 ) {            
            Remove-Item $_ -Recurse -Force
        }        
    }
}

# # Remove user vagrant with exist
# $myuser="vagrant"
# $op = Get-LocalUser | where-Object Name -eq $myuser | Measure
# if ($op.Count -eq 1) {
#     Remove-LocalUser -Name $myuser
# }
