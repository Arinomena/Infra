$ErrorActionPreference = "Stop"

$frontendRepo = "https://github.com/Arinomena/Fiarahantsika_desktop.git"
$backendRepo  = "https://github.com/Arinomena/Fiarahantsika_backend.git"
$mlRepo       = "https://github.com/Arinomena/Fiarahantsika_ML.git"

function Clone-Repo($url, $path) {
    if (-Not (Test-Path $path)) {
        git clone $url $path
    }
}

Clone-Repo $frontendRepo "../Fiarahantsika_desktop"
Clone-Repo $backendRepo "../Fiarahantsika_backend"
Clone-Repo $mlRepo "../Fiarahantsika_ML"

docker-compose pull
docker-compose build
docker-compose up -d
