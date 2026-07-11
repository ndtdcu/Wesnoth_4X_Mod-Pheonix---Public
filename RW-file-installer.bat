@echo off
title Rusted Warfare Mod Installer

echo ============================================
echo     Rusted Warfare Mod Auto-Installer
echo ============================================
echo.

set "RW_PATH=C:\Program Files (x86)\Steam\steamapps\common\Rusted Warfare"
set "MODS_PATH=%RW_PATH%\mods\units"
set "ZIP_NAME=Wesnoth_4X_Mod-Pheonix.zip"
set "TEMP_DIR=temp_extract"

echo Checking for Rusted Warfare installation...
if not exist "%RW_PATH%" (
    echo ERROR: Rusted Warfare not found.
    pause
    exit /b
)

echo Rusted Warfare found!
echo.

if not exist "%ZIP_NAME%" (
    echo ERROR: ZIP "%ZIP_NAME%" not found.
    pause
    exit /b
)

echo Cleaning old temp folder...
if exist "%TEMP_DIR%" rmdir /S /Q "%TEMP_DIR%"

echo Extracting ZIP...
powershell -command "Expand-Archive -Path '%ZIP_NAME%' -DestinationPath '%TEMP_DIR%' -Force"

echo Removing old mod folder...
if exist "%MODS_PATH%\Wesnoth_4X_Mod-Pheonix" rmdir /S /Q "%MODS_PATH%\Wesnoth_4X_Mod-Pheonix"

echo Copying new mod folder...
xcopy "%TEMP_DIR%\Wesnoth_4X_Mod-Pheonix" "%MODS_PATH%\Wesnoth_4X_Mod-Pheonix" /E /I /Y

echo Cleaning temp folder...
rmdir /S /Q "%TEMP_DIR%"

echo.
echo ============================================
echo        Installation Complete!
echo ============================================
echo.

pause
exit /b
