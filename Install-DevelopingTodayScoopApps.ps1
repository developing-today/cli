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

Write-Verbose -Verbose "Installing $($apps.Count) developing-today apps from scoop."

if ($apps.Count -eq 0) {
    return
}
scoop install $($apps -join " ")
CheckLastExitCode
