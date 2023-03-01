# Script for executin pipeline for build ant test
New-Item -ItemType File -Name workflow.txt -Force >$null
Add-Content -Path workflow.txt -Value "Start Trigger Pipelines..."
$start = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path workflow.txt -Value $start
git add .
git commit -m "Start Pepilines"
git push origin main
