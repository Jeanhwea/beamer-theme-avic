@echo off
setlocal enabledelayedexpansion
rem =====================================================================
rem  install.bat -- Install the AVIC beamer theme into the local TeX tree
rem  (TEXMFHOME). Once installed, any document can use \usetheme{Avic}
rem  without setting TEXINPUTS or placing files next to the .tex.
rem
rem  Copies beamerthemeAvic.sty and the thm-* assets from avic\ into
rem  <TEXMFHOME>\tex\latex\beamer-theme-avic\. TEXMFHOME is queried via
rem  kpsewhich; if not found, falls back to %USERPROFILE%\texmf.
rem
rem  Usage:
rem    install.bat              Install (prompts if target exists)
rem    install.bat /force       Install, overwrite existing without prompt
rem    install.bat /uninstall   Uninstall
rem =====================================================================

rem Source directory: avic\ one level up from this script
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT_DIR=%%~fI"
set "SOURCE_DIR=%ROOT_DIR%\avic"
set "PACKAGE_NAME=beamer-theme-avic"

rem --- Parse arguments ---
set "DO_UNINSTALL="
set "DO_FORCE="
for %%A in (%*) do (
    if /i "%%~A"=="/uninstall" set "DO_UNINSTALL=1"
    if /i "%%~A"=="-uninstall" set "DO_UNINSTALL=1"
    if /i "%%~A"=="/force" set "DO_FORCE=1"
    if /i "%%~A"=="-force" set "DO_FORCE=1"
)

rem --- Locate TEXMFHOME ---
set "TEXMF_HOME="
where kpsewhich >nul 2>nul
if %errorlevel%==0 (
    for /f "usebackq delims=" %%H in (`kpsewhich -var-value^=TEXMFHOME 2^>nul`) do (
        if not defined TEXMF_HOME set "TEXMF_HOME=%%H"
    )
)
if not defined TEXMF_HOME (
    echo [WARN] kpsewhich not found, falling back to %%USERPROFILE%%\texmf. Make sure a TeX distribution is installed.
    set "TEXMF_HOME=%USERPROFILE%\texmf"
)

set "TARGET_DIR=%TEXMF_HOME%\tex\latex\%PACKAGE_NAME%"

rem --- Uninstall ---
if defined DO_UNINSTALL (
    if exist "%TARGET_DIR%" (
        rmdir /s /q "%TARGET_DIR%"
        echo Uninstalled: %TARGET_DIR%
    ) else (
        echo Nothing to uninstall: %TARGET_DIR%
    )
    goto :eof
)

rem --- Install ---
if not exist "%SOURCE_DIR%" (
    echo [ERROR] Source directory not found: %SOURCE_DIR%
    exit /b 1
)

if exist "%TARGET_DIR%" (
    if not defined DO_FORCE (
        set /p "ANSWER=Target exists, overwrite? [%TARGET_DIR%] (y/N) "
        if /i not "!ANSWER!"=="y" (
            echo Cancelled.
            goto :eof
        )
    )
)

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

rem Copy only the .sty and assets the theme needs, ignore everything else
set /a COPIED=0
for %%P in (sty png pdf) do (
    for %%F in ("%SOURCE_DIR%\*.%%P") do (
        if exist "%%~F" (
            copy /y "%%~F" "%TARGET_DIR%\" >nul
            set /a COPIED+=1
        )
    )
)

echo Installed !COPIED! file(s) to: %TARGET_DIR%

rem MiKTeX needs its filename database refreshed; TeX Live's TEXMFHOME does not need texhash
where initexmf >nul 2>nul
if %errorlevel%==0 (
    echo MiKTeX detected, refreshing filename database...
    initexmf --update-fndb >nul
)

echo.
echo Done. Any document can now use:
echo     \usetheme[color=blue]{Avic}

goto :eof
