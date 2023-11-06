Set-StrictMode -Version Latest

if (-not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Verbose -Verbose "Scoop already installed."
}
scoop install aria2
scoop bucket known | ForEach-Object { scoop bucket add $_ }
scoop update
scoop --version
