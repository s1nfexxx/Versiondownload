@echo off
chcp 65001
color d
echo.
echo ███████╗ ██████╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗███████╗███╗   ██╗██████╗
echo ██╔════╝██╔════╝██║  ██║██║  ██║██╔═══██╗██╔════╝██╔════╝████╗  ██║██╔══██╗
echo █████╗  ██║     ███████║███████║██║   ██║███████╗█████╗  ██╔██╗ ██║██║  ██║
echo ██╔══╝  ██║     ██╔══██║██╔══██║██║   ██║╚════██║██╔══╝  ██║╚██╗██║██║  ██║
echo ███████╗╚██████╗██║  ██║██║  ██║╚██████╔╝███████║███████╗██║ ╚████║██████╔╝
echo ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝
echo.
set /p pasirinkimas= Ar atidarome Echhsend (yes/no) = 
if /i "%pasirinkimas%"=="yes" (
:: --- Atnaujinimu tikrinimo logika ---

set "CURRENT_VERSION=0.0.1"
set "VERSION_CHECK_URL=https://raw.githubusercontent.com/s1nfexxx/Versiondownload/main/Version.txt"
set "LOCAL_VERSION_FILE=Version_Remote.txt"

echo Tikriname ar yra atnaujinimu...
echo.

:: Atsisiunciame nuotolines versijos faila
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%VERSION_CHECK_URL%', '%LOCAL_VERSION_FILE%')" >nul 2>&1

:: Patikriname, ar versijos failas buvo sėkmingai atsisiųstas
if not exist "%LOCAL_VERSION_FILE%" (
    echo Klaida: Nepavyko atsisiusti versijos informacijos. Patikrinkite interneta.
    echo.
    echo Vykdoma dabartine versija: %CURRENT_VERSION%v BETA
    goto :END_UPDATE_CHECK
)

:: Nuskaitome naujausią versiją iš atsisiųsto failo
for /f "delims=" %%v in (%LOCAL_VERSION_FILE%) do set "LATEST_VERSION=%%v"

:: Ištriname laikiną versijos failą iškart po nuskaitymo
del "%LOCAL_VERSION_FILE%" >nul 2>&1

:: Palyginame versijas
if "%LATEST_VERSION%" gtr "%CURRENT_VERSION%" (
    echo Yra naujas atnaujinimas!
    echo Dabartine versija: %CURRENT_VERSION%v BETA, Naujausia versija: %LATEST_VERSION%
    echo.
    echo (Cia butu logika, skirta atsisiusti ir instaliuoti atnaujinima)
) else (
    echo Atnaujinimu nebuvo. Esate naujausios versijos: %CURRENT_VERSION%v BETA
)

:END_UPDATE_CHECK
echo.
timeout /t 2 /NOBREAK >nul
echo Atnaujinimu tikrinimas baigtas.
echo.
pause
