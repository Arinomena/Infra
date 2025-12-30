#!/bin/bash
set -e

FRONTEND_REPO="https://github.com/Arinomena/Fiarahantsika_desktop.git"
BACKEND_REPO="https://github.com/Arinomena/Fiarahantsika_backend.git"
ML_REPO="https://github.com/Arinomena/Fiarahantsika_ML.git"

if [ ! -d "../Fiarahantsika_desktop" ]; then
  git clone $FRONTEND_REPO ../Fiarahantsika_desktop
fi

if [ ! -d "../Fiarahantsika_backend" ]; then
  git clone $BACKEND_REPO ../Fiarahantsika_backend
fi

if [ ! -d "../Fiarahantsika_ML" ]; then
  git clone $ML_REPO ../Fiarahantsika_ML
fi

docker-compose pull
docker-compose build
docker-compose up -d
