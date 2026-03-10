#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}======================================================"
echo -e "   INSTALLATEUR AUTOMATIQUE FIARAHANTSIKA"
echo -e "======================================================${NC}\n"

# --- VERIFICATION DES PREREQUIS ---
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}[ERREUR] $1 n'est pas installé.${NC}"
        echo -e "Veuillez installer $1 avant de relancer ce script."
        exit 1
    fi
}

check_tool "docker"
check_tool "git"
check_tool "docker-compose"

# --- CONFIGURATION ---
BASE_DIR=".."
REPOS=(
    "Frontend|https://github.com/Arinomena/Fiarahantsika_desktop.git|$BASE_DIR/Fiarahantsika_desktop"
    "Backend|https://github.com/Arinomena/Fiarahantsika_backend.git|$BASE_DIR/Fiarahantsika_backend"
    "ML|https://github.com/Arinomena/Fiarahantsika_ML.git|$BASE_DIR/Fiarahantsika_ML"
)

echo -e "${BLUE}=== ÉTAPE 1 : Synchronisation du code ===${NC}"
for row in "${REPOS[@]}"; do
    IFS="|" read -r name url path <<< "$row"
    if [ ! -d "$path" ]; then
        echo -e "${GREEN}[CLONE]${NC} $name..."
        git clone "$url" "$path"
    else
        echo -e "${GREEN}[UPDATE]${NC} $name..."
        cd "$path" && git pull && cd - > /dev/null
    fi
done

echo -e "\n${BLUE}=== ÉTAPE 2 : Lancement Docker ===${NC}"
docker-compose up -d --build --remove-orphans

echo -e "\n${GREEN}======================================================"
echo -e "   INSTALLATION TERMINEE !"
echo -e "   Dashboard : http://localhost:3000"
echo -e "======================================================${NC}\n"