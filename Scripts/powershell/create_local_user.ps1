if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process -Wait powershell -Verb runAs -ArgumentList $arguments
  Break
}
$Password = ConvertTo-SecureString "vagrant" -AsPlainText -Force
New-LocalUser "vagrant" -Password $Password -FullName "Vagrant user" -Description "Vagrant user for labs"
Add-LocalGroupMember -Group "Administrators" -Member "vagrant"
#Get-LocalGroupMember -Group "Administrators"