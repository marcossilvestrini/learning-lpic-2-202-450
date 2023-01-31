#Vagrant Boxes
$debian = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian"
$debian5 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Debian5"
$ol9 = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\OracleLinux"
$bind = "F:\CERTIFICACAO\lpic-2-202-450\Vagrant\Bind"

#halt debian
Set-Location $debian
vagrant halt

#halt debian5
Set-Location $debian5
vagrant halt

#halt centos
Set-Location $ol9
vagrant halt


#halt bind
Set-Location $bind
vagrant halt
