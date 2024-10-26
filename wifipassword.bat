@echo off
title Wi-Fi Password Viewer & Discord Invite
color 0a

REM Set your Discord invite link
set DISCORD_LINK=https://discord.gg/Xmu6SRRBYu
:main
cls
echo ===========================================================
echo                      WIFI PASSWORD RETRIEVER
echo ===========================================================
echo.
echo             [1] View Saved Wi-Fi Passwords
echo             [2] Join Our Discord Server
echo             [3] Exit
echo.
echo ===========================================================
set /p choice="Choose an option (1-3): "

if "%choice%"=="1" goto view_passwords
if "%choice%"=="2" goto discord_invite
if "%choice%"=="3" goto exit
goto main

:view_passwords
cls
echo ===========================================================
echo                      YOUR SAVED WIFI PASSWORDS
echo ===========================================================
echo.
for /f "tokens=1,2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set "ssid=%%b"
    call :get_password "!ssid:~1!"
)
echo.
pause
goto main

:get_password
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile name^="%1" key^=clear ^| findstr "Key Content"') do (
    echo SSID: %1
    echo Password: %%a
    echo -------------------------------------------------------
)
endlocal
exit /b

:discord_invite
start "" "%DISCORD_LINK%"
goto main

:exit
echo Exiting... Have a great day!
timeout /t 2 >nul
exit
