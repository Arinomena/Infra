@echo off
set FRONTEND_REPO=https://github.com/Arinomena/Fiarahantsika_desktop.git
set BACKEND_REPO=https://github.com/Arinomena/Fiarahantsika_backend.git
set ML_REPO=https://github.com/Arinomena/Fiarahantsika_ML.git

if not exist "..\Fiarahantsika_desktop" (
    git clone %FRONTEND_REPO% ..\Fiarahantsika_desktop
)

if not exist "..\Fiarahantsika_backend" (
    git clone %BACKEND_REPO% ..\Fiarahantsika_backend
)

if not exist "..\Fiarahantsika_ML" (
    git clone %ML_REPO% ..\Fiarahantsika_ML
)

docker-compose pull
docker-compose build
docker-compose up -d
