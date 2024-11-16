$shortcutPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup\Start MITM Proxy.lnk")
$targetPath = "${installdir}\bin\start_mitm.bat"
$workingDirectory = "${installdir}\bin"

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $targetPath
$shortcut.WorkingDirectory = $workingDirectory
$shortcut.Description = "Starts the MITM Proxy on system startup"
$shortcut.Save()

$shortcutPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup\Start MITM Proxy.lnk")
if (Test-Path $shortcutPath) {
    Write-Host "Shortcut created successfully at: $shortcutPath"
} else {
    Write-Host "Failed to create shortcut at: $shortcutPath"
}

if (Test-Path $shortcutPath) {
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    Write-Host "Shortcut target: $($shortcut.TargetPath)"
    Write-Host "Shortcut working directory: $($shortcut.WorkingDirectory)"
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell) | Out-Null
}
