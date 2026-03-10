# 🚀 Système de Gestion Fiarahantsika

Bienvenue dans l'installateur automatique de la solution **Fiarahantsika**. 
Ce projet regroupe un **Frontend** (Interface Vision UI), un **Backend** (API Spring Boot) et un module de **Machine Learning** (Prédictions).

Ce guide permet d'installer l'intégralité de l'écosystème sur une machine locale, tout en restant connecté à la base de données sécurisée sur le Cloud.

---

## 📋 Pré-requis (À installer une seule fois)

Avant de commencer, assurez-vous que les deux logiciels suivants sont installés sur votre ordinateur :

1. **Docker Desktop** : [Télécharger ici](https://www.docker.com/products/docker-desktop)
   * *Note : Une fois installé, lancez l'application et attendez que l'icône de la baleine soit verte.*
2. **Git** : [Télécharger ici](https://git-scm.com/downloads)

---

## ⚙️ Installation et Lancement Rapide

Plus besoin de lignes de commande complexes. Suivez simplement ces étapes :

### 1. Préparation
Placez les fichiers suivants dans un dossier vide sur votre machine :
* `docker-compose.yml`
* `setup.bat` (pour Windows)
* `setup.sh` (pour Mac/Linux)

### 2. Lancement automatique
* **Sur Windows** : Double-cliquez sur `setup.bat`.
* **Sur Mac / Linux** : Ouvrez un terminal dans le dossier et tapez `./setup.sh`.

Le script va automatiquement :
1. Télécharger (cloner) les codes sources depuis GitHub.
2. Vérifier les mises à jour si le code existe déjà.
3. Construire les serveurs (Frontend, Backend, ML).
4. Lancer l'application en arrière-plan.

### 3. Accès à l'application
Une fois que le script affiche **"INSTALLATION TERMINÉE"**, ouvrez votre navigateur et allez à l'adresse :

👉 **[http://localhost:3000](http://localhost:3000)**

---

## 📁 Architecture du Déploiement

Une fois le script lancé, votre dossier ressemblera à ceci :
```text
/MonProjet
├── setup.bat              # Script de lancement Windows
├── setup.sh               # Script de lancement Linux/Mac
├── docker-compose.yml     # Configuration des services
├── Fiarahantsika_desktop  # Code source Frontend (auto-généré)
├── Fiarahantsika_backend  # Code source Backend (auto-généré)
└── Fiarahantsika_ML       # Code source Machine Learning (auto-généré)