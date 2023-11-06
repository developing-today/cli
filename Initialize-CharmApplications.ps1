$apps = @(
    "charm",
    "confettysh",
    "glow",
    "gum",
    "melt",
    "mods",
    "pop",
    "skate",
    "soft-serve",
    "vhs",
    "wishlist"
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
        Write-Host "Last CMD failed $LastExitCode" -ForegroundColor Red
        exit
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Host "EXE RETURNED EXIT CODE $LastExitCode" -ForegroundColor Red
        exit
    }
}

Write-Verbose -Verbose "Installing $($apps.Count) charmbracelet apps from scoop."

if ($apps.Count -eq 0) {
    return
}

scoop install $($apps -join " ")
CheckLastExitCode
