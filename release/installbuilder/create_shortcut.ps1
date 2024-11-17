$shortcutPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup\Start MITM Proxy.lnk")
$targetPath = "$PSScriptRoot\start_mitm.bat"
$workingDirectory = $PSScriptRoot

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $targetPath
$shortcut.WorkingDirectory = $workingDirectory
$shortcut.Description = "Starts the MITM Proxy on system startup"
$shortcut.Save()

if (Test-Path $shortcutPath) {
    Write-Host "Shortcut created successfully at: $shortcutPath"
    Write-Host "Shortcut target: $($shortcut.TargetPath)"
    Write-Host "Shortcut working directory: $($shortcut.WorkingDirectory)"
} else {
    Write-Host "Failed to create shortcut at: $shortcutPath"
}

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
