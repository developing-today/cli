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
scoop update
scoop update *
choco upgrade all -y --accept-eula
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
pwsh
update-module
update-help
powershell
update-module
update-help -uiculture en-us
# all done
```
