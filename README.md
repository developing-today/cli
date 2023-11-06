Run this as current user on a windows machine.
This will enable you have a few different tools.
In time, there may be other alternatives here,
such as AllUsers or using Winget/Choco?

```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$initScript = "https://raw.githubusercontent.com/developing-today/cli/main/Initialize-CommandLineInterface.ps1"
Invoke-RestMethod get.scoop.sh | Invoke-Expression
```

run this and you will have

- scoop
  - all known preset buckets
  - this scoop bucket
  - all packages in this scoop bucket
