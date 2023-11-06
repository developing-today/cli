```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$baseUrl = "https://raw.githubusercontent.com"
$repo = "developing-today/cli"
$ref = "main"
$file = "Initialize-CommandLineInterface.ps1"
$scriptUrl = "$baseUrl/$repo/$ref/$file"
Invoke-RestMethod $scriptUrl | Invoke-Expression
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
