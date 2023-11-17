Set-StrictMode -Version Latest
$PSNativeCommandUseErrorActionPreference = $true

if ($PSNativeCommandUseErrorActionPreference) { # always true, this is a linter workaround
    $ErrorActionPreference = "Stop"
    $PSDefaultParameterValues['*:ErrorAction'] = 'Stop'
}

function CheckLastExitCode {
    param ([int[]]$SuccessCodes = @(0))

    if (!$?) {
        if (-not (Test-Path variable://LastExitCode)) {
            $LastExitCode = 1
            Write-Verbose -Verbose "No LastExitCode found, setting to 1" -ForegroundColor Red
        }
        Write-Verbose -Verbose "Last CMD failed $LastExitCode" -ForegroundColor Red
        exit
    }

    if (-not (Test-Path variable://LastExitCode)) {
        Write-Verbose -Verbose "No LastExitCode found, setting to 0" -ForegroundColor Green
        $LastExitCode = 0
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Verbose -Verbose "EXE RETURNED EXIT CODE $LastExitCode" -ForegroundColor Red
        exit
    }
}

$prefix = "$($env:CLI_PREFIX)"

if ($prefix -eq "") {
    $prefix = "https://raw.githubusercontent.com/developing-today/cli/main"
    Write-Verbose -Verbose "Using default prefix $prefix"
} else {
    Write-Verbose -Verbose "Using custom prefix $prefix"
}

$scoop = Invoke-RestMethod "$prefix/Install-Scoop.ps1"
CheckLastExitCode
Invoke-Expression $scoop
CheckLastExitCode

$charmbraceletScoopApps = Invoke-RestMethod "$prefix/Install-CharmScoopApps.ps1"
CheckLastExitCode
Invoke-Expression $charmbraceletScoopApps
CheckLastExitCode

$developingTodayApps = Invoke-RestMethod "$prefix/Install-DevelopingTodayScoopApps.ps1"
CheckLastExitCode
Invoke-Expression $developingTodayScoopApps
CheckLastExitCode
