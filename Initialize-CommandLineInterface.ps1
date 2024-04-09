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
$process0 = Start-Process powershell.exe -ArgumentList "-Command `"wsl --install -d Ubuntu`"" -PassThru
$process0 | Wait-Process

winget update Microsoft.AppInstaller --accept-package-agreements --accept-source-agreements
winget update --all --include-unknown --accept-source-agreements --accept-package-agreements
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
Set-PSRepository PSGallery -InstallationPolicy Trusted
$process1 = Start-Process powershell.exe -ArgumentList "-Command `"Register-PSRepository -Default ; Set-PSRepository PSGallery -InstallationPolicy Trusted ; Update-Help -ErrorAction SilentlyContinue ; update-module * ; Update-Script *`"" -PassThru
$process2 = Start-Process pwsh.exe -ArgumentList "-Command `"Register-PSRepository -Default ; Set-PSRepository PSGallery -InstallationPolicy Trusted ; Update-Help -ErrorAction SilentlyContinue ; update-module *  -AcceptLicense ; Update-Script *  -AcceptLicense`"" -PassThru
$process3 = Start-Process powershell.exe -ArgumentList "-Command `"Register-PSRepository -Default ; Set-PSRepository PSGallery -InstallationPolicy Trusted ; Update-Help -ErrorAction SilentlyContinue ; update-module * ; Update-Script * `"" -Verb RunAs -PassThru
$process4 = Start-Process pwsh.exe -ArgumentList "-Command `"Register-PSRepository -Default ; Set-PSRepository PSGallery -InstallationPolicy Trusted ; Update-Help -ErrorAction SilentlyContinue ; update-module * -AcceptLicense ; Update-Script * -AcceptLicense`"" -Verb RunAs -PassThru
$process1,$process2,$process3,$process4 | Wait-Process

$adminScript = @'
winget update Microsoft.AppInstaller --accept-package-agreements --accept-source-agreements
winget update --all --include-unknown --accept-source-agreements --accept-package-agreements
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
choco upgrade all -y --accept-eula
scoop update *
scoop update -g *
Install-PackageProvider -Name "NuGet" -Force
Register-PSRepository -Default
Install-Module -Name PSWindowsUpdate -Force
UsoClient ScanInstallWait
wuauclt /detectnow /updatenow
Add-WUServiceManager -MicrosoftUpdate -Confirm:$false
dism.exe /Online /Cleanup-image /Restorehealth
Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot
Reboot-Computer
'@
$process5 = Start-Process powershell.exe -ArgumentList "-Command `"$adminScript`"" -Verb RunAs
$process5 | Wait-Process
