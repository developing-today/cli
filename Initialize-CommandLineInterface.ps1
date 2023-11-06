Set-StrictMode -Version Latest

$prefix = "$($env:CLI_PREFIX)"

if ($prefix -eq "") {
    $prefix = "https://raw.githubusercontent.com/developing-today/cli/main"
}

$scoop = Invoke-RestMethod "$prefix/Initialize-Scoop.ps1"
Invoke-Expression $scoop

$charmApplication = Invoke-RestMethod "$prefix/Initialize-CharmApplications.ps1"
Invoke-Expression $charmApplication

$developingTodayApplications = Invoke-RestMethod "$prefix/Initialize-DevelopingTodayApplications.ps1"
Invoke-Expression $developingTodayApplications
