$buckets = @{
	"developing-today" = "https://github.com/developing-today/scoop-developing-today"
	"charmbracelet" = "https://github.com/developing-today-forks/scoop-charmbracelet"
}

Set-StrictMode -Version Latest
$PSNativeCommandUseErrorActionPreference = $true
if ($PSNativeCommandUseErrorActionPreference) {
    # always true, this is a linter workaround
    $ErrorActionPreference = "Stop"
    $PSDefaultParameterValues['*:ErrorAction'] = 'Stop'
}
function CheckLastExitCode {
    param ([int[]]$SuccessCodes = @(0))

    if (!$?) {
        Write-Host "Last CMD failed $LastExitCode" -ForegroundColor Red
        exit
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Host "EXE RETURNED EXIT CODE $LastExitCode" -ForegroundColor Red
        exit
    }
}

if (-not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
    $scoop = Invoke-RestMethod get.scoop.sh
    CheckLastExitCode
    Invoke-Expression $scoop
    CheckLastExitCode
} else {
    Write-Verbose -Verbose "Scoop already installed."
}

# causes ffpmeg errors # occurred 2023-11 try again after 2024-03
# scoop install aria2
# scoop config aria2-enabled true

$bucketList = scoop bucket list
CheckLastExitCode
$currentBuckets = $bucketList | ForEach-Object { $_.Name }
CheckLastExitCode

foreach ($bucket in $buckets.GetEnumerator()) {
    $name = $bucket.Key
    $url = $bucket.Value

    if ($currentBuckets -contains $name) {
        Write-Verbose -Verbose "Bucket $name already added. Removing..."
        scoop bucket rm $name
        CheckLastExitCode
    }
    Invoke-Expression "scoop bucket add $name $url"
    CheckLastExitCode
}

scoop update
CheckLastExitCode
scoop update *
CheckLastExitCode
scoop --version
CheckLastExitCode
scoop status
CheckLastExitCode
