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
if ($apps.Count -eq 0) {
    Write-Host "No apps to install"
    return
}
scoop install $($apps -join " ")
