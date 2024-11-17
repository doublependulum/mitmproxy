# Script to set mitmproxy as system-wide proxy

# Define the proxy address and port
$proxyAddress = "127.0.0.1"
$proxyPort = "8080"  # Default mitmproxy port

# Function to set proxy for Windows
function Set-WindowsProxy {
    $proxyServer = "$proxyAddress`:$proxyPort"
    
    # Set proxy server
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value $proxyServer
    
    # Enable proxy
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
    
    # Don't use proxy server for local intranet addresses
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyOverride -Value "<local>"
}

# Detect OS and set proxy accordingly
Set-WindowsProxy

Write-Host "mitmproxy has been set as the system-wide proxy on $proxyAddress`:$proxyPort"
Write-Host "Proxy is configured to bypass local intranet addresses."
Write-Host "To stop the proxy, close this window and reset your system proxy settings."
