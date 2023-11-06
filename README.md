Run this as current user on a windows machine.
This will enable you have a few different tools.
In time, there may be other alternatives here,
such as AllUsers or using Winget/Choco?

```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$rawContentUrl = "https://raw.githubusercontent.com"
$thisRepo = "developing-today/cli"
$ref = "main"
$file = "Initialize-CommandLineInterface.ps1"
$initScript = "$rawContentUrl/$thisRepo/$ref/$file"
Invoke-RestMethod $initScript |
  Invoke-Expression
scoop --version
# all done
```

run this and you will have

- scoop
  - all known preset buckets
  - this scoop bucket
  - all packages in this scoop bucket
