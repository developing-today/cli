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
        }
        Write-Host "Last CMD failed $LastExitCode" -ForegroundColor Red
        exit
    }

    if (-not (Test-Path variable://LastExitCode)) {
        $LastExitCode = 0
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Host "EXE RETURNED EXIT CODE $LastExitCode" -ForegroundColor Red
        exit
    }
}

$prefix = "$($env:CLI_PREFIX)"

if ($prefix -eq "") {
    $prefix = "https://raw.githubusercontent.com/developing-today/cli/main"
} else {
    Write-Verbose -Verbose "Using custom prefix $prefix"
}

$scoop = Invoke-RestMethod "$prefix/Install-Scoop.ps1"
CheckLastExitCode
Invoke-Expression $scoop
CheckLastExitCode

$charmApplication = Invoke-RestMethod "$prefix/Install-CharmApplications.ps1"
CheckLastExitCode
Invoke-Expression $charmApplication
CheckLastExitCode

$developingTodayApplications = Invoke-RestMethod "$prefix/Install-DevelopingTodayApplications.ps1"
CheckLastExitCode
Invoke-Expression $developingTodayApplications
CheckLastExitCode
