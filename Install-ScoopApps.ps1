$apps = @(
    "git"
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

Write-Verbose -Verbose "Installing $($apps.Count) scoop apps from scoop."

if ($apps.Count -eq 0) {
    return
}

scoop install $($apps -join " ")
CheckLastExitCode
