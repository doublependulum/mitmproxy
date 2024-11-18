$tool = $args[0]
$toolargs = $args[1]
Write-Host "tool: $tool"
Write-Host "toolargs: $toolargs"
if (Get-Command wt -ErrorAction SilentlyContinue) {
	Start-Process wt -ArgumentList "powershell.exe -ExecutionPolicy Bypass","-Command","& $PSScriptRoot\$tool.exe $toolargs"
} else { 
	Start-Process powershell -ExecutionPolicy Bypass -ArgumentList "-Command","& $PSScriptRoot\$tool.exe $toolargs"
}
