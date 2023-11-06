$apps = @(
)
if ($apps.Count -eq 0) {
    Write-Host "No apps to install"
    return
}
scoop install $($apps -join " ")
