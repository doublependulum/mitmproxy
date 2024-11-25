@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0\run.ps1" mitmdump "-s D:\swiftsecurity\mitmproxy\bin\proxy_mitm.py --mode local:ChatGPT.exe,Code.exe" --set block_global=false
