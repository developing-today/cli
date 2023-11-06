$buckets = @{
	"developing-today" = "https://github.com/developing-today/scoop-developing-today"
	"charmbracelet" = "https://github.com/developing-today-forks/scoop-charmbracelet"
}

Set-StrictMode -Version Latest

if (-not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Verbose -Verbose "Scoop already installed."
}

# causes ffpmeg errors
# scoop install aria2
# scoop config aria2-enabled true

$currentBuckets = scoop bucket list | ForEach-Object { $_.Name }

foreach ($bucket in $buckets.GetEnumerator()) {
    $name = $bucket.Key
    $url = $bucket.Value

    if ($currentBuckets -contains $name) {
        Write-Verbose -Verbose "Bucket $name already added. Removing..."
        scoop bucket rm $name
    }
    scoop bucket add $name $url
}

scoop update
scoop update *
scoop --version
scoop status
