$url = "https://releases.hashicorp.com/vagrant"
$web = Invoke-WebRequest $url
$html = (($web.tostring() -split "[`r`n]" | select-string "vagrant_") -split ":")[0].Trim()
$html -match '\d\.\d\.\d' > $null
$version = $Matches.0
$download = "$url/$version/vagrant_$($version)_windows_amd64.msi"
#Invoke-WebRequest -Uri $download -OutFile "$HOME\Downloads"

