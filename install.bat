@echo off
setlocal enabledelayedexpansion
title Installateur Fiarahantsika - Configuration Automatique

echo ======================================================
echo    INSTALLATEUR AUTOMATIQUE FIARAHANTSIKA
echo ======================================================
echo.

:: --- VERIFICATION DES PREREQUIS ---
echo [CHECK] Verification de Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Docker n'est pas installe !
    echo Veuillez installer 'Docker Desktop' depuis : https://www.docker.com/products/docker-desktop
    pause
    exit
)

echo [CHECK] Verification de Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Git n'est pas installe !
    echo Veuillez installer Git depuis : https://git-scm.com/downloads
    pause
    exit
)

:: --- CONFIGURATION DES DEPOTS ---
set FRONTEND_REPO=https://github.com/Arinomena/Fiarahantsika_desktop.git
set BACKEND_REPO=https://github.com/Arinomena/Fiarahantsika_backend.git
set ML_REPO=https://github.com/Arinomena/Fiarahantsika_ML.git

set FRONTEND_DIR=..\Fiarahantsika_desktop
set BACKEND_DIR=..\Fiarahantsika_backend
set ML_DIR=..\Fiarahantsika_ML

echo.
echo === ETAPE 1 : Synchronisation du code source ===

for %%i in ("Frontend!%FRONTEND_REPO%!%FRONTEND_DIR%" "Backend!%BACKEND_REPO%!%BACKEND_DIR%" "ML!%ML_REPO%!%ML_DIR%") do (
    for /f "tokens=1,2,3 delims=!" %%a in (%%i) do (
        if not exist "%%c" (
            echo [CLONE] %%a...
            git clone %%b %%c
        ) else (
            echo [UPDATE] %%a...
            cd /d %%c && git pull && cd /d %~dp0
        )
    )
)

echo.
echo === ETAPE 2 : Lancement des services (Patientez...) ===
docker-compose pull
docker-compose up -d --build --remove-orphans

echo.
echo ======================================================
echo    INSTALLATION TERMINEE !
echo    Dashboard : http://localhost:3000
echo ======================================================
echo.
pause