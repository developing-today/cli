$apps = @(
)

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

Write-Verbose -Verbose "Installing $($apps.Count) developing-today apps from scoop."

if ($apps.Count -eq 0) {
    return
}
scoop install $($apps -join " ")
CheckLastExitCode
