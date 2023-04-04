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

#Vagrant Boxes
$debian = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
$debian5 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian5"
$ol9 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"
$bind = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Bind"
$http = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\HTTP"
$fs = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\FS"
$dhcp_ldap = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\DHCP_LDAP"
$mail = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\MAIL"
$security = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\SECURITY"

# Folder vagrant virtualbox machines artefacts
$virtualboxFolder = "E:\Servers\VirtualBox"
$vmFolders=@(
    "$virtualboxFolder\ol9-bind-master",
    "$virtualboxFolder\debian-bind-slave",
    "$virtualboxFolder\debian-apache-node01",
    "$virtualboxFolder\debian-apache-node02",
    "$virtualboxFolder\ol9-apache-ha",
    "$virtualboxFolder\ol9-nginx-ha",
    "$virtualboxFolder\debian-http-client",
    "$virtualboxFolder\ol9-server01",
    "$virtualboxFolder\ol9-server02",
    "$virtualboxFolder\debian-server01",
    "$virtualboxFolder\debian-client01"
)

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

#Destroy http stack
Set-Location $http
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy fs stack
Set-Location $fs
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy dhcp_ldap stack
Set-Location $dhcp_ldap
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy mail stack
Set-Location $mail
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

#Destroy security stack
Set-Location $security
Start-Process -Wait -WindowStyle Hidden  -FilePath "E:\Apps\Vagrant\bin\vagrant.exe" -ArgumentList "destroy -f"  -Verb RunAs

# Delete folder virtualbox machines artefacts
$vmFolders | ForEach-Object {
    If(Test-Path $_){
        If( (Get-ChildItem -Recurse $_).Count -lt 3 ){            
            Remove-Item $_ -Recurse -Force
        }        
    }
}