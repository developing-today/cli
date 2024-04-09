```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
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
