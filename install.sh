#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear
echo -e "${BLUE}======================================================"
echo -e "    INSTALLATEUR AUTOMATIQUE FIARAHANTSIKA"
echo -e "======================================================${NC}\n"

# --- VERIFICATION DES PREREQUIS ---
check_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}[ERREUR] $1 n'est pas installé.${NC}"
        echo -e "Veuillez installer $1 avant de relancer ce script."
        exit 1
    fi
}

check_tool "docker"
check_tool "git"

# --- CONFIGURATION ---
BASE_DIR=".."
# On utilise une liste simple pour éviter les erreurs de parsing IFS complexes
REPOS=(
    "Frontend|https://github.com/Arinomena/Fiarahantsika_desktop.git|$BASE_DIR/Fiarahantsika_desktop"
    "Backend|https://github.com/Arinomena/Fiarahantsika_backend.git|$BASE_DIR/Fiarahantsika_backend"
    "ML|https://github.com/Arinomena/Fiarahantsika_ML.git|$BASE_DIR/Fiarahantsika_ML"
)

echo -e "${BLUE}=== ÉTAPE 1 : Synchronisation du code ===${NC}"
for row in "${REPOS[@]}"; do
    IFS="|" read -r name url path <<< "$row"
    if [ ! -d "$path" ]; then
        echo -e "${GREEN}[CLONE]${NC} $name en cours..."
        git clone "$url" "$path"
    else
        echo -e "${GREEN}[UPDATE]${NC} $name en cours..."
        # Utilisation d'un sous-shell ( ) pour ne pas perdre le répertoire courant si le pull échoue
        (cd "$path" && git pull)
    fi
done

echo -e "\n${BLUE}=== ÉTAPE 2 : Lancement Docker (Patientez...) ===${NC}"
# On s'assure de nettoyer les instances précédentes
docker-compose down
docker-compose up -d --build --remove-orphans

echo -e "\n${YELLOW}Attente du démarrage des services (20s)...${NC}"
sleep 20

echo -e "\n${GREEN}======================================================"
echo -e "    INSTALLATION TERMINÉE !"
echo -e "    Lancement automatique du Dashboard..."
echo -e "======================================================${NC}\n"

# --- OUVERTURE AUTOMATIQUE DU NAVIGATEUR ---
URL="http://localhost:3000"

if command -v xdg-open &> /dev/null; then
    xdg-open "$URL"        # Linux
elif command -v open &> /dev/null; then
    open "$URL"            # macOS
else
    echo -e "Veuillez ouvrir votre navigateur à l'adresse : ${BLUE}$URL${NC}"
fi