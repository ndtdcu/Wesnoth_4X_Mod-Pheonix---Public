@echo off
title Rusted Warfare Mod Installer

echo ============================================
echo     Rusted Warfare Mod Auto-Installer
echo ============================================
echo.

set "RW_PATH=C:\Program Files (x86)\Steam\steamapps\common\Rusted Warfare"
set "MODS_PATH=%RW_PATH%\mods\units"
set "MOD_OUTPUT_NAME=Wesnoth_4X_Mod-Pheonix"
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

echo Detecting extracted mod folder...

set "EXTRACTED_FOLDER="

rem --- Try exact folder names ---
for /d %%F in ("%TEMP_DIR%\*") do (
    if /i "%%~nxF"=="Wesnoth_4X_Mod-Pheonix" set "EXTRACTED_FOLDER=%TEMP_DIR%\%%~nxF"
    if /i "%%~nxF"=="Wesnoth_4X_Mod-Pheonix-main" set "EXTRACTED_FOLDER=%TEMP_DIR%\%%~nxF"
)

rem --- Fallback: find folder containing mod-info.txt ---
if not defined EXTRACTED_FOLDER (
    for /r "%TEMP_DIR%" %%F in (mod-info.txt) do (
        set "EXTRACTED_FOLDER=%%~dpF"
        goto found_mod_folder
    )
)

:found_mod_folder

echo Using extracted folder: %EXTRACTED_FOLDER%

echo Removing old TEST mod folder...
if exist "%MODS_PATH%\%MOD_OUTPUT_NAME%" rmdir /S /Q "%MODS_PATH%\%MOD_OUTPUT_NAME%"

echo Copying new TEST mod folder...
xcopy "%EXTRACTED_FOLDER%" "%MODS_PATH%\%MOD_OUTPUT_NAME%" /E /I /Y

echo Cleaning temp folder...
rmdir /S /Q "%TEMP_DIR%"

echo.
echo ============================================
echo        Installation Complete!
echo Installed to TEST folder:
echo "%MODS_PATH%\%MOD_OUTPUT_NAME%"
echo ============================================
echo.

pause
exit /b
