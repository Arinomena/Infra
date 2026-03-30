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
set "FRONT_R=https://github.com/Arinomena/Fiarahantsika_desktop.git"
set "BACK_R=https://github.com/Arinomena/Fiarahantsika_backend.git"
set "ML_R=https://github.com/Arinomena/Fiarahantsika_ML.git"

set "FRONT_D=..\Fiarahantsika_desktop"
set "BACK_D=..\Fiarahantsika_backend"
set "ML_D=..\Fiarahantsika_ML"

echo.
echo === ETAPE 1 : Synchronisation du code source ===

:: Boucle corrigée avec virgules comme délimiteurs
for %%I in ("Frontend,%FRONT_R%,%FRONT_D%" "Backend,%BACK_R%,%BACK_D%" "ML,%ML_R%,%ML_D%") do (
    for /f "tokens=1,2,3 delims=," %%a in (%%I) do (
        if not exist "%%c" (
            echo [CLONE] %%a en cours...
            git clone %%b %%c
        ) else (
            echo [UPDATE] %%a en cours...
            pushd "%%c" && git pull && popd
        )
    )
)

echo.
echo === ETAPE 2 : Lancement des services (Patientez...) ===
:: Nettoyage des anciens conteneurs pour eviter les conflits de ports
docker-compose down
docker-compose up -d --build --remove-orphans

echo.
echo ======================================================
echo    INSTALLATION TERMINEE !
echo    Attente du demarrage des services (20s)...
echo ======================================================
echo.

:: --- PAUSE TECHNIQUE ---
:: Laisse le temps au serveur React/Vite de demarrer reellement
timeout /t 20 /nobreak >nul

echo Lancement automatique du Dashboard...
start http://localhost:3000

pause