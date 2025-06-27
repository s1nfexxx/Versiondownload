@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ─── Nustatymai ────────────────────────────────────────────────────────────
set "RAW_BASE=https://raw.githubusercontent.com/s1nfexxx/Versiondownload/main"
set "REMOTE_VERSION_URL=%RAW_BASE%/Version.txt"
set "NEW_BAT_URL=%RAW_BASE%/EchoSendBat.bat"

set "SELF=%~f0"
set "FOLDER=%~dp0"
set "VERSION_FILE=%FOLDER%Version.txt"
set "TEMP_VERSION=%TEMP%\remote_version.txt"
set "NEW_BAT=%FOLDER%EchoSendBat.bat"

:: ─── Vietinio Version.txt sukūrimas, jei neegzistuoja ────────────────────────
if not exist "%VERSION_FILE%" (
    echo 0.0.0>"%VERSION_FILE%"
)

:: ─── Nuskaityti vietinę versiją ───────────────────────────────────────────────
set /p LOCAL_VERSION=<"%VERSION_FILE%"

:: ─── Atsisiųsti nuotolinę versiją ────────────────────────────────────────────
powershell -nologo -noprofile -Command ^
  "Invoke-WebRequest '%REMOTE_VERSION_URL%' -UseBasicParsing -OutFile '%TEMP_VERSION%'" >nul 2>&1
set /p REMOTE_VERSION=<"%TEMP_VERSION%"
del "%TEMP_VERSION%" >nul 2>&1

cls
color d

if "%LOCAL_VERSION%"=="%REMOTE_VERSION%" (
    echo.
    echo [=] Versija: %LOCAL_VERSION%
    echo [=] Naujinimų nėra. Failas liks toks koks yra.
) else (
    echo.
    echo [!] Naujinimas: %LOCAL_VERSION% → %REMOTE_VERSION%
    echo [>] Parsisiunčiama nauja EchoSendBat.bat...

    powershell -nologo -noprofile -Command ^
      "Invoke-WebRequest '%NEW_BAT_URL%' -UseBasicParsing -OutFile '%NEW_BAT%'" >nul 2>&1

    echo [✓] Atnaujinta versija į %REMOTE_VERSION%
    echo %REMOTE_VERSION%>"%VERSION_FILE%"

    :: ─── Ištrinti save background proc (be papildomo lango) ─────────────────
    start "" /b cmd /c "ping 127.0.0.1 -n 2 >nul && del \"%SELF%\""
)

timeout /2 /NOBREAK >nul
cls

echo.
echo   ███████╗ ██████╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗███████╗███╗   ██╗██████╗ 
echo   ██╔════╝██╔════╝██║  ██║██║  ██║██╔═══██╗██╔════╝██╔════╝████╗  ██║██╔══██╗
echo   █████╗  ██║     ███████║███████║██║   ██║███████╗█████╗  ██╔██╗ ██║██║  ██║
echo   ██╔══╝  ██║     ██╔══██║██╔══██║██║   ██║╚════██║██╔══╝  ██║╚██╗██║██║  ██║
echo   ███████╗╚██████╗██║  ██║██║  ██║╚██████╔╝███████║███████╗██║ ╚████║██████╔╝
echo   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ 
echo.

set /p pasirinkimas=Ar paleisti Programa? (yes/no) = 
if /i "%pasirinkimas%"=="yes" (
echo Perjungeme!
timeout /t 2 /NOBREAK >nul

pause

