```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$base = "https://raw.githubusercontent.com"
$repo = "developing-today/cli"
$ref = "main"
$prefix = "$base/$repo/$ref"
$file = "Initialize-CommandLineInterface.ps1"
$env:CLI_PREFIX = $prefix
Invoke-RestMethod "$prefix/$file" | Invoke-Expression
# all done
```
```
scoop bucket known | ForEach-Object { scoop bucket add $_ }
scoop update
# all done
```
```
scoop update
scoop update *
# all done
```
```
choco upgrade all -y --accept-eula
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
scoop update
scoop update *
scoop update -g *
pwsh -command @"
update-module * -AcceptLicense
Update-Script * -AcceptLicense
update-help * -ErrorAction SilentlyContinue
"@
powershell -command @"
update-module * -AcceptLicense
Update-Script * -AcceptLicense
update-help * -ErrorAction SilentlyContinue
"@
UsoClient ScanInstallWait
wuauclt /detectnow /updatenow
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll
control update
Start-Process -FilePath 'ms-settings:windowsupdate'
Add-WUServiceManager -MicrosoftUpdate -Confirm:$false
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
dism.exe /Online /Cleanup-image /Restorehealth
# all done
```
