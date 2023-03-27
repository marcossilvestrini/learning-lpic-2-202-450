<#
.Synopsis
   Share a folder
.DESCRIPTION
   This script share a folder with vagrant user
   This script is executed as Administrator
.EXAMPLE
   & create_share.ps1
#>

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process -Wait powershell -WindowStyle Hidden -Verb runAs -ArgumentList $arguments
  Break
}

# Share folder
#New-SmbShare -Name "Vagrant Shared Folder" -Path "F:\Projetos" -FullAccess "silvestrini\vagrant"
$FolderName = 'F:\Projetos'
$UserId = 'silvestrini\vagrant'
Remove-SmbShare -Name "Projetos" -Force
New-SmbShare -Path $FolderName -Name "Projetos" -FullAccess $UserId
$Acl = Get-Acl $FolderName
$NewAccessRule = New-Object system.security.accesscontrol.filesystemaccessrule($UserId,"FullControl", "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")
$Acl.SetAccessRule($NewAccessRule)
Set-Acl $FolderName $Acl
