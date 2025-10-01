#  ☸️⚓02 - Déploiement d'Architecture Microservice sur Kubernetes (FastAPI & PostgreSQL)

## Introduction
Ce projet consiste à déployer une application de streaming composée de deux microservices — une API **FastAPI** et une base de données **PostgreSQL** — au sein d'un cluster **Kubernetes (K8s)**.

Il démontre la capacité à **modéliser une architecture multi-tier** en utilisant les objets Kubernetes standard et à garantir la résilience, l'évolutivité et la sécurité de l'application.

##  Problématique & Objectifs
L'objectif était de migrer une architecture Docker Compose vers Kubernetes en respectant les bonnes pratiques de production :

1.  **Orchestration :** Déployer les services d'application (FastAPI) et de base de données (PostgreSQL) avec les objets K8s appropriés (**Deployment** et **StatefulSet**).
2.  **Persistance :** Mettre en place un stockage persistant (**PV/PVC**) pour la base de données, permettant l'écriture multi-Pod.
3.  **Sécurité & Configuration :** Utiliser les **Secrets** et les **ConfigMaps** pour gérer les identifiants sensibles et les variables de configuration.
4.  **Exposition :** Exposer l'API FastAPI au monde extérieur via un objet **Ingress**.
5.  **Automatisation :** Créer des scripts d'automatisation pour le déploiement et la récupération des logs.

##  Stack Technique
| Composant | Rôle dans le Projet |
| :--- | :--- |
| **Kubernetes (K8s)** | Orchestration de l'ensemble de l'architecture. |
| **StatefulSet** | Déploiement de la base de données PostgreSQL pour garantir l'identité stable. |
| **Deployment** | Déploiement *stateless* de 3 réplicas de l'API FastAPI. |
| **PV / PVC** | Gestion du volume de 10Gi pour la persistance des données PostgreSQL. |
| **Secrets / ConfigMap** | Injection sécurisée des mots de passe (`POSTGRES_PASSWORD` encodé en Base64) et des configurations (User, DB). |
| **Ingress (Traefik)** | Exposition de l'API FastAPI via un nom de domaine spécifique. |

##  Architecture Déployée
L'architecture a été conçue pour garantir la communication interne et l'accès externe :
1.  Le **StatefulSet PostgreSQL** est exposé par un **Service (db)**.
2.  Le **Deployment FastAPI** (3 réplicas) est exposé par un **Service (fastapi-service)** et se connecte à la DB via `db:5432`.
3.  L'**Ingress** route le trafic entrant vers le `fastapi-service` sur le port 5000.



---

##  Exécution et Déploiement

### 1. Structure du Projet
Tous les manifestes Kubernetes se trouvent dans le dossier `yaml-manifests/`.

### 2. Déploiement de l'Application
Le script `deploy-StreamingApp.sh` est utilisé pour appliquer toutes les configurations dans l'ordre de dépendance (Secrets/ConfigMap $\rightarrow$ PV/PVC $\rightarrow$ StatefulSet $\rightarrow$ Deployment/Ingress).

```bash
# Exemple de commandes
chmod +x deploy-StreamingApp.sh
./deploy-StreamingApp.sh
  ```


### 3. Récupération des Logs
Le script get-logs.sh permet de consolider les logs des deux microservices pour le diagnostic.


```Bash

chmod +x get-logs.sh
./get-logs.sh
# Les logs sont enregistrés dans logs/fastapi-logs.txt et logs/postgres-logs.txt
 ```
