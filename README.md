```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$rawContentUrl = "https://raw.githubusercontent.com"
$thisRepo = "developing-today/cli"
$ref = "main"
$file = "Initialize-CommandLineInterface.ps1"
$initScript = "$rawContentUrl/$thisRepo/$ref/$file"
Invoke-RestMethod $initScript | Invoke-Expression
# all done
```
- Run this as current user on a windows machine.
  - scoop
    - all known preset buckets
    - this scoop bucket
    - all packages in this scoop bucket
