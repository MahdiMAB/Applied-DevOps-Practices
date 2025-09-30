# 🐳 Pipeline de Tests d'API pour l'Analyse de Sentiment (Docker/Docker Compose)

## Introduction
Ce projet est un mini-pipeline de **CI/CD (Intégration et Déploiement Continus)** implémenté à l'aide de **Docker** et **Docker Compose**. L'objectif est de mettre en place une batterie de tests automatisés pour une **API d'analyse de sentiment** avant son déploiement.


## 💡 Problématique & Objectifs
Une équipe a développé une API de *sentiment analysis* (analyse de sentiment) et doit s'assurer que les nouvelles versions sont robustes avant toute mise en production.

Les objectifs principaux du projet :
1.  **Conteneuriser l'API** ainsi que les trois catégories de tests (Authentication, Authorization, Content).
2.  Orchestrer l'ensemble des services (API et Tests) en utilisant **Docker Compose**.
3.  Mettre en place un système de **logging centralisé** (`api_test.log`) via les volumes Docker pour consolider les résultats des différents conteneurs de test.
4.  Créer un script d'exécution simple pour automatiser la construction des images et le lancement du pipeline.

## 🛠️ Stack Technique
| Composant | Rôle |
| :--- | :--- |
| **Docker** | Conteneurisation de l'API et de chaque service de test. |
| **Docker Compose** | Orchestration multi-conteneurs, gestion du réseau (`api_network`) et des volumes. |
| **Python**  | Implémentation de la logique des tests pour interroger l'API. |
| **Bash** (`setup.sh`) | Script d'automatisation des commandes `docker build` et `docker-compose up`. |

## 📁 Architecture du Projet

<img width="237" height="294" alt="image" src="https://github.com/user-attachments/assets/dde5ffa2-fa9d-4167-a836-d8943833b1f3" />



## ⚙️ Exécution du Pipeline (Démarrage Rapide)
Pour exécuter le pipeline de tests, assurez-vous que Docker et Docker Compose sont installés sur votre machine.

1.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/MahdiMAB/Applied-DevOps-Practices.git
    cd docker-api-test-pipeline
    ```
2.  **Lancer le script de setup :**
    Le script `setup.sh` se charge de construire les images des tests et de lancer l'orchestration.
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```
3.  **Vérifier les résultats :**
    Une fois l'exécution terminée, le fichier `api_test.log` sera créé à la racine du projet et contiendra le rapport complet des tests.
    ```bash
    cat api_test.log
    ```
4.  **Nettoyage (Optionnel) :**
    Pour arrêter et supprimer les conteneurs et le réseau :
    ```bash
    docker-compose down
    ```

---

## 🔎 Détails Techniques Clés
### 1. Isolation et Dépendances
Chaque test est un conteneur séparé, garantissant l'**isolation**. Le `docker-compose.yml` utilise la clause `depends_on: - api` pour s'assurer que le service `api` est démarré avant de lancer les services de test.

### 2. Réseau (Networking)
Un réseau Docker défini, `api_network`, permet aux conteneurs de test de communiquer avec l'API en utilisant son nom de service (`http://api:8000`), ce qui est une pratique standard en microservices.

### 3. Persistance des Logs (Volumes)
Un **volume** est monté sur chaque conteneur de test (`./api_test.log:/test_api/api_test.log`). Cela permet aux trois conteneurs de test d'**écrire de manière cumulative** dans le même fichier log de la machine hôte.

### 4. Variables d'Environnement
La variable d'environnement `LOG=1` est passée aux conteneurs de test via `docker-compose` pour activer la fonction de log dans les scripts Python, démontrant l'utilisation des environnements dynamiques.

---

## Conclusion
Ce projet est une excellente démonstration pratique des fondamentaux de la conteneurisation pour les pipelines de tests.  

