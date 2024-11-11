@echo off

:: Set variables

s
set "proxy_port=8080"
set "mitm_binary=%install_dir%\mitmproxy.exe"
set "ps_script_path=D:\Projects\mitmproxy-install\bin\run.ps1"
set "powershell_binary=C:\windows\System32\WindowsPowerShell\v1.0\powershell.exe"


:: Set the system proxy for WinHTTP and Windows with local bypass using PowerShell
echo Setting system proxy to mitmproxy on port %proxy_port%...
%powershell_binary% -WindowStyle Hidden -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value '127.0.0.1:%proxy_port%' -Force"
%powershell_binary% -WindowStyle Hidden -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 1 -Force"
%powershell_binary% -WindowStyle Hidden -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyOverride -Value '<local>' -Force"

:: Configure WinHTTP proxy settings using netsh without prompting
echo Configuring WinHTTP proxy settings...
%powershell_binary% -WindowStyle Hidden -Command "Start-Process -FilePath 'C:\Windows\System32\netsh.exe' -ArgumentList 'winhttp set proxy proxy-server=http://127.0.0.1:%proxy_port%;https://127.0.0.1:%proxy_port% bypass-list=<local>' -Verb runAs"

:: Start mitmproxy via PowerShell script if available
echo Running mitmproxy via PowerShell script...
start "" "%powershell_binary%" -WindowStyle Hidden -ExecutionPolicy Bypass -File "%ps_script_path%" mitmdump -p 8080 "

echo mitmproxy setup and startup script completed.
