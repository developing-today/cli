```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$baseUrl = "https://raw.githubusercontent.com"
$repo = "developing-today/cli"
$ref = "main"
$prefix = "$baseUrl/$repo/$ref"
$env:CLI_PREFIX = $prefix
$file = "Initialize-CommandLineInterface.ps1"
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
