@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0\run.ps1" mitmdump -p 8080 --set block_global=false
