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
            Write-Verbose -Verbose "No LastExitCode found, setting to 1"
        }
        Write-Verbose -Verbose "Last CMD failed $LastExitCode"
        exit
    }

    if (-not (Test-Path variable://LastExitCode)) {
        # Write-Verbose -Verbose "No LastExitCode found, setting to 0"
        $LastExitCode = 0
    }

    if ($SuccessCodes -notcontains $LastExitCode) {
        Write-Verbose -Verbose "EXE RETURNED EXIT CODE $LastExitCode"
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

$scoopApps = Invoke-RestMethod "$prefix/Install-ScoopApps.ps1"
CheckLastExitCode
Invoke-Expression $scoopApps
CheckLastExitCode

$charmScoopApps = Invoke-RestMethod "$prefix/Install-CharmScoopApps.ps1"
CheckLastExitCode
Invoke-Expression $charmScoopApps
CheckLastExitCode

$developingTodayScoopApps = Invoke-RestMethod "$prefix/Install-DevelopingTodayScoopApps.ps1"
CheckLastExitCode
Invoke-Expression $developingTodayScoopApps
CheckLastExitCode

wsl --install -d Ubuntu

winget update Microsoft.AppInstaller --accept-package-agreements --accept-source-agreements
winget update --accept-package-agreements --accept-source-agreements --all

Update-Help

$adminScript = @'
Update-Help
Install-PackageProvider -Name "NuGet" -Force
Register-PSRepository -Default
Install-Module -Name PSWindowsUpdate -Force
Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot
Reboot-Computer
'@
Start-Process powershell.exe -ArgumentList "-Command `"$adminScript`"" -Verb RunAs
