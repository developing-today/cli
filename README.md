```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$rawContentUrl = "https://raw.githubusercontent.com"
$repo = "developing-today/cli"
$ref = "main"
$file = "Initialize-CommandLineInterface.ps1"
$scriptUrl = "$rawContentUrl/$repo/$ref/$file"
Invoke-RestMethod $scriptUrl | Invoke-Expression
# all done
```
- Run this as current user on a windows machine.
  - scoop
    - all known preset buckets
    - this scoop bucket
    - all packages in this scoop bucket
