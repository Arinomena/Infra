@echo off
setlocal enabledelayedexpansion
title Installateur Fiarahantsika - Configuration Automatique

echo ======================================================
echo     INSTALLATEUR AUTOMATIQUE FIARAHANTSIKA
echo ======================================================
echo.

:: --- VERIFICATION DES PREREQUIS ---
echo [CHECK] Verification de Docker...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Docker Desktop n'est pas lance !
    echo Veuillez ouvrir 'Docker Desktop' et attendre que le voyant soit VERT.
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

:: --- CORRECTIF DE SECURITE GIT ---
:: Evite l'erreur "dubious ownership" sur la machine du client
echo [CONFIG] Configuration de la securite Git...
git config --global --add safe.directory "*"

:: --- CONFIGURATION DES DEPOTS ---
set "FRONT_R=https://github.com/Arinomena/Fiarahantsika_desktop.git"
set "BACK_R=https://github.com/Arinomena/Fiarahantsika_backend.git"
set "ML_R=https://github.com/Arinomena/Fiarahantsika_ML.git"

:: Utilisation de %~dp0 pour garantir que les dossiers sont crees au bon endroit par rapport au script
set "FRONT_D=%~dp0..\Fiarahantsika_desktop"
set "BACK_D=%~dp0..\Fiarahantsika_backend"
set "ML_D=%~dp0..\Fiarahantsika_ML"

echo.
echo === ETAPE 1 : Synchronisation du code source ===

:: Boucle sur les depots
for %%I in ("Frontend,%FRONT_R%,%FRONT_D%" "Backend,%BACK_R%,%BACK_D%" "ML,%ML_R%,%ML_D%") do (
    for /f "tokens=1,2,3 delims=," %%a in (%%I) do (
        if not exist "%%c" (
            echo [CLONE] %%a en cours...
            git clone %%b "%%c"
        ) else (
            echo [UPDATE] %%a en cours...
            pushd "%%c" && git pull && popd
        )
    )
)

echo.
echo === ETAPE 2 : Lancement des services (Patientez...) ===
:: Utilisation de -f "%~dp0docker-compose.yml" pour eviter l'erreur "file not found"
docker-compose -f "%~dp0docker-compose.yml" down
docker-compose -f "%~dp0docker-compose.yml" up -d --build --remove-orphans

echo.
echo ======================================================
echo     INSTALLATION TERMINEE !
echo     Attente du demarrage des services (20s)...
echo ======================================================
echo.

:: --- PAUSE TECHNIQUE ---
timeout /t 20 /nobreak >nul

echo Lancement automatique du Dashboard...
start http://localhost:3000

pause