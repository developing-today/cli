Set-StrictMode -Version Latest

if (-not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Verbose -Verbose "Scoop already installed."
}

scoop install aria2

scoop config aria2-enabled true

scoop bucket known | ForEach-Object { scoop bucket add $_ }

$currentBuckets = scoop bucket list | ForEach-Object { $_.Name }

$buckets = Get-Content .\buckets.json | ConvertFrom-Json

foreach ($property in $buckets.PSObject.Properties) {
    $name = $property.Name
    $url = $property.Value

    if ($currentBuckets -contains $name) {
        Write-Verbose -Verbose "Bucket $name already added. Removing..."
        scoop bucket rm $name
    }
    scoop bucket add $name $url
}

scoop update
scoop --version
scoop status
