#Vagrant Boxes
$debian = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
$ol9 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"

#up debian
Set-Location $debian
vagrant halt

#up centos
Set-Location $ol9
vagrant halt