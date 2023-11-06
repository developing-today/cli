$apps = @(
)
if ($apps.Count -eq 0) {
    Write-Verbose -Verbose "No apps to install"
    return
}
scoop install $($apps -join " ")
