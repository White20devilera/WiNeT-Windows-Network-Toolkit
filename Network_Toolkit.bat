@echo off
:: Admin Permissions Check
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%cd%"
    CD /D "%~dp0"

:: Start of your tool
title Network Troubleshoot Toolkit
:menu
cls
color 0b
echo ===========================================
echo        NETWORK TROUBLESHOOT TOOLKIT
echo ===========================================
echo 1. Show IP Configuration
echo 2. Flush DNS Cache
echo 3. Release IP Address
echo 4. Renew IP Address
echo 5. Reset Winsock
echo 6. Reset TCP/IP Stack
echo 7. Ping Google
echo 8. Network Statistics
echo 9. Open Network Connections
echo 10. Open Wi-Fi Settings
echo 11. Full Network Repair
echo 12. Exit
echo ===========================================
set /p opt="Select option: "

if "%opt%"=="1" goto showip
if "%opt%"=="2" goto flushdns
if "%opt%"=="3" goto release
if "%opt%"=="4" goto renew
if "%opt%"=="5" goto winsock
if "%opt%"=="6" goto tcpip
if "%opt%"=="7" goto ping
if "%opt%"=="8" goto netstat
if "%opt%"=="9" goto connections
if "%opt%"=="10" goto wifi
if "%opt%"=="11" goto repair
if "%opt%"=="12" exit
goto menu

:showip
ipconfig /all
pause
goto menu

:flushdns
ipconfig /flushdns
echo.
echo DNS Cache Flushed successfully!
pause
goto menu

:release
ipconfig /release
pause
goto menu

:renew
ipconfig /renew
pause
goto menu

:winsock
netsh winsock reset
echo.
echo Winsock reset. Please restart your computer later.
pause
goto menu

:tcpip
netsh int ip reset
echo.
echo TCP/IP Stack reset. Please restart your computer later.
pause
goto menu

:ping
ping google.com
pause
goto menu

:netstat
netstat -an
pause
goto menu

:connections
ncpa.cpl
goto menu

:wifi
start ms-settings:network-wifi
goto menu

:repair
echo Performing Full Network Repair...
ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset
echo.
echo Full Repair Complete! Recommended to Restart your PC.
pause
goto menu