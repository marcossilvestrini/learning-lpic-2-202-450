<#
.Synopsis
   Create local user as Administrator
.DESCRIPTION
   This script create a local user vagrant and add in local group Administrator
   This script is executed as Administrator
.EXAMPLE
   & create_local_user.ps1
#>

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process -Wait powershell -Verb runAs -WindowStyle Hidden -ArgumentList $arguments
  Break
}

# Create user
$Password = ConvertTo-SecureString "vagrant" -AsPlainText -Force
New-LocalUser "vagrant" -Password $Password -FullName "Vagrant user" -Description "Vagrant user for labs"
Add-LocalGroupMember -Group "Administrators" -Member "vagrant"
#Get-LocalGroupMember -Group "Administrators"
