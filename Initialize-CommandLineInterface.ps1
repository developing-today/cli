Set-StrictMode -Version Latest
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install aria2
scoop bucket known | % { scoop bucket add $_ }
scoop --version
