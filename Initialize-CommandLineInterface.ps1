Set-StrictMode -Version Latest
$PSNativeCommandUseErrorActionPreference = $true

if ($PSNativeCommandUseErrorActionPreference) { # always true, this is a linter workaround
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

$prefix = "$($env:CLI_PREFIX)"

if ($prefix -eq "") {
    $prefix = "https://raw.githubusercontent.com/developing-today/cli/main"
}

$scoop = Invoke-RestMethod "$prefix/Initialize-Scoop.ps1"
CheckLastExitCode
Invoke-Expression $scoop
CheckLastExitCode

$charmApplication = Invoke-RestMethod "$prefix/Initialize-CharmApplications.ps1"
CheckLastExitCode
Invoke-Expression $charmApplication
CheckLastExitCode

$developingTodayApplications = Invoke-RestMethod "$prefix/Initialize-DevelopingTodayApplications.ps1"
CheckLastExitCode
Invoke-Expression $developingTodayApplications
CheckLastExitCode
