Set-StrictMode -Version Latest

if (-not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Verbose -Verbose "Scoop already installed."
}

scoop install aria2

scoop bucket known | ForEach-Object { scoop bucket add $_ }

$buckets = Get-Content .\buckets.json | ConvertFrom-Json

foreach ($property in $buckets.PSObject.Properties) {
    $name = $property.Name
    $url = $property.Value

    scoop bucket add $name $url
}

scoop update

scoop --version
