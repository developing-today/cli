Set-StrictMode -Version Latest

$prefix = "$($env:CLI_PREFIX)"

if ($prefix -eq "") {
    $prefix = "https://raw.githubusercontent.com/developing-today/cli/main"
}

Invoke-RestMethod "$prefix/Initialize-Scoop.ps1" | Invoke-Expression
Invoke-RestMethod "$prefix/Initialize-CharmApplication.ps1" | Invoke-Expression
Invoke-RestMethod "$prefix/Initialize-DevelopingTodayApplications.ps1" | Invoke-Expression
