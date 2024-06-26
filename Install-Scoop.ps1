$buckets = @{
	"developing-today" = "https://github.com/developing-today/scoop-developing-today"
	"charmbracelet" = "https://github.com/developing-today-forks/scoop-charmbracelet"
	"charm" = "https://github.com/charmbracelet/scoop-bucket"
	"extras" = ""
	"versions" = ""
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
        if (-not (Test-Path variable://LastExitCode)) {
            $LastExitCode = 1
            Write-Verbose -Verbose "No LastExitCode found, setting to 1" 
        }
        Write-Verbose -Verbose "Last CMD failed $LastExitCode"
        exit
    }

    if (-not (Test-Path variable://LastExitCode)) {
        Write-Verbose -Verbose "No LastExitCode found, setting to 0"
        $LastExitCode = 0
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Verbose -Verbose "EXE RETURNED EXIT CODE $LastExitCode"
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
scoop install git
scoop update git
powershell.exe -Command "scoop install pwsh" # https://github.com/ScoopInstaller/Main/issues/3572#issuecomment-1292873053
powershell.exe -Command "scoop update pwsh" # https://github.com/ScoopInstaller/Main/issues/3572#issuecomment-1292873053
reg import (Join-Path (Get-Item (scoop which pwsh)).Directory.FullName install-explorer-context.reg)
reg import (Join-Path (Get-Item (scoop which pwsh)).Directory.FullName install-file-context.reg)

Write-Verbose -Verbose "Getting current scoop bucket list. If you see errors here, try removing the given bucket and running this script again. `scoop bucket rm <bucket>``"

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
