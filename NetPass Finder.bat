@echo off
:: List saved Wi-Fi networks
echo Listing all saved Wi-Fi networks...

echo. 
   

setlocal enabledelayedexpansion

:: Initialize counter for saved networks
set i=0
for /f "tokens=1,2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    if not "%%b"=="" (
        set /a i+=1
        set ssid[!i!]=%%b
        echo !i!: %%b
    )
)

:: Add a decorative line
echo.
echo.

:: Prompt user to select a Wi-Fi network by entering its number
set /p index=Enter the number of the Wi-Fi network to show its password: 

:: Remove leading space from SSID
set ssid_name=!ssid[%index%]:~1!

:: Check if the SSID name exists and display password
if defined ssid_name (
    echo.
    echo Showing password for network: !ssid_name!
    netsh wlan show profile name="!ssid_name!" key=clear | findstr "Key Content"
) else (
    echo Invalid selection. Please run the script again and select a valid network number.
)

echo.
pause
