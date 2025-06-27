@echo off
chcp 65001
color D
cls

:: ASCII Art for EchoSend
echo.
echo ███████╗ ██████╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗███████╗███╗   ██╗██████╗
echo ██╔════╝██╔════╝██║  ██║██║  ██║██╔═══██╗██╔════╝██╔════╝████╗  ██║██╔══██╗
echo █████╗  ██║     ███████║███████║██║   ██║███████╗█████╗  ██╔██╗ ██║██║  ██║
echo ██╔══╝  ██║     ██╔══██║██╔══██║██║   ██║╚════██║██╔══╝  ██║╚██╗██║██║  ██║
echo ███████╗╚██████╗██║  ██║██║  ██║╚██████╔╝███████║███████╗██║ ╚████║██████╔╝
echo ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝
echo.

:: --- Startup Option ---
:STARTUP_CHECK
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "BATCH_FILE_PATH=%~dpn0.bat"

if not exist "%STARTUP_FOLDER%\%~nx0" (
    echo.
    set /p AddStartup=Ar norite paleisti programa su Windows paleidimu? (yes/no) =
    if /i "%AddStartup%"=="yes" (
        copy "%BATCH_FILE_PATH%" "%STARTUP_FOLDER%" >nul
        echo Programa prideta prie Windows paleidimo.
        timeout /t 2 /NOBREAK >nul
    )
)

:: --- Main Program Launch Confirmation ---
set /p Paleisit=Paleisti pagrindine programa? (yes/no) =
if /i "%Paleisit%"=="yes" (
    timeout /t 1 /NOBREAK >nul
    cls
) else (
    echo Programa nepaleista. Iki!
    timeout /t 2 /NOBREAK >nul
    exit
)

color f
echo Paleidziama EchoSend.
timeout /t 1 /NOBREAK >nul
echo.

:: --- Update Check ---
echo Tikriname ar yra atnaujinimu...
echo.

:: --- Placeholder for actual update logic ---
:: In a real scenario, you would replace this with logic to:
:: 1. Download a version file from a server (e.g., via curl/wget if installed, or PowerShell).
:: 2. Compare the downloaded version with the current version (e.g., 0.0.1v BETA).
:: 3. If a new version is available, download the update files.
:: 4. (Optional) Backup current files before applying updates.
:: 5. Replace old files with new ones.

:: For demonstration, let's simulate an update check.
:: Create a dummy file named 'latest_version.txt' in the same directory as your batch file
:: and put a version number inside, e.g., "0.0.2".
:: You can change the current version here to simulate an update.
set "CURRENT_VERSION=0.0.1"
set "UPDATE_FILE=latest_version.txt"
set "UPDATE_DOWNLOAD_URL=https://example.com/latest_version.txt" :: Replace with your actual URL

if exist "%UPDATE_FILE%" (
    for /f "delims=" %%v in (%UPDATE_FILE%) do set "LATEST_VERSION=%%v"
    if "%LATEST_VERSION%" gtr "%CURRENT_VERSION%" (
        echo Yra naujas atnaujinimas! Dabartine versija: %CURRENT_VERSION%, Naujausia versija: %LATEST_VERSION%
        echo.
        set /p DownloadUpdate=Ar norite atsisiusti atnaujinima dabar? (yes/no) =
        if /i "%DownloadUpdate%"=="yes" (
            echo Pradedamas atnaujinimas...
            :: Here you would add commands to download and apply the update.
            :: For example, using PowerShell to download a file:
            :: powershell -command "(New-Object System.Net.WebClient).DownloadFile('%UPDATE_DOWNLOAD_URL%', 'new_update.zip')"
            :: Then, extract and replace files. This is complex for a simple batch file.
            :: A more robust solution would involve a separate updater program or a more advanced script.
            echo (Atnaujinimo atsisiuntimo ir instaliavimo logika butu cia.)
            timeout /t 5 /NOBREAK >nul
            echo Atnaujinimas baigtas (imitacija).
        ) else (
            echo Atnaujinimas praleistas.
        )
    ) else (
        echo Atnaujinimu nebuvo. Esate naujausios versijos: %CURRENT_VERSION%
    )
) else (
    echo Nepavyko patikrinti atnaujinimu (failas "%UPDATE_FILE%" nerastas arba problema su interneto rysiu).
    echo Prašome patikrinti ryši arba sukurti "%UPDATE_FILE%" su naujausia versija.
)

timeout /t 2 /NOBREAK >nul
echo.
echo EchoSend v%CURRENT_VERSION% BETA

:: --- Main Program Execution (Placeholder) ---
echo.
echo (Cia paleiskite pagrindine "EchoSend" programa, pvz: start EchoSend.exe)
:: For demonstration, we'll just pause.
pause