# ☁️ 03 - Déploiement d'une Architecture Multi-Tier Haute Disponibilité (AWS + Terraform)

## Introduction
Ce projet représente le déploiement complet d'une **architecture multi-tier** (Web/Application et Base de données) sur **Amazon Web Services (AWS)** en utilisant **Terraform** pour l'**Infrastructure as Code (IaC)**.

L'objectif principal était d'automatiser la création d'une infrastructure **modulaire, sécurisée et résiliente** pour héberger une application dynamique (comme un serveur WordPress) et sa base de données relationnelle.

## 💡 Objectifs Clés
1.  **Modularité Terraform :** Structurer l'ensemble de l'infrastructure en **modules réutilisables** (`network`, `ec2`, `rds`, `ebs`).
2.  **Haute Disponibilité (HA) :** Déployer la base de données **RDS (MySQL)** et les composants réseau sur **deux Zones de Disponibilité (AZ)** (`eu-west-3a` et `eu-west-3b`) pour la résilience.
3.  **Sécurité Réseau :** Isoler les composants dans un **VPC dédié** et utiliser des **Security Groups (SG)** pour ne permettre que les flux nécessaires (e.g., EC2 vers RDS sur le port 3306).
4.  **Gestion des Données :** Utiliser un volume **EBS** dédié pour le stockage de l'instance EC2 (attaché via `aws_volume_attachment`).
5.  **Gestion des Secrets :** Utiliser des variables `sensitive = true` pour les identifiants de base de données, empêchant leur affichage dans les logs et le *plan*.

## 🛠️ Composants de l'Infrastructure AWS Déployée

| Module | Ressource Clé | Caractéristiques |
| :--- | :--- | :--- |
| **Network** | `aws_vpc`, `aws_subnet`, `aws_igw`, `aws_route_table` | Création d'un VPC (`10.0.0.0/16`) avec des subnets publics dans **2 AZ**. |
| **EC2** | `aws_instance`, `aws_security_group` | Déploiement d'un **serveur web** (`t2.micro`) dans la première AZ. Sécurité configurée pour SSH (22), HTTP (80) et HTTPS (443) ouverts à `0.0.0.0/0`. |
| **RDS** | `aws_db_instance`, `aws_db_subnet_group` | Déploiement d'une instance **MySQL 8.0** en mode **Multi-AZ** sur les deux subnets publics. |
| **EBS** | `aws_ebs_volume`, `aws_volume_attachment` | Création et attachement d'un volume de 10Gi à l'instance EC2 pour les données de l'application. |

## 📦 Organisation du Code (Modularisme)
L'approche modulaire permet de découpler la logique et de faciliter la réutilisation et la maintenance :

* **`main.tf` :** Le point d'entrée qui **appelle** les différents modules et connecte leurs sorties (e.g., l'adresse de la base de données de `module.rds.primary_db_address` est passée en entrée au `module.ec2`).
* **`modules/...` :** Chaque sous-dossier représente un composant isolé du cloud, définissant ses propres entrées (`variables.tf`) et ses ressources (`main.tf`).

### Extrait de `main.tf` montrant la dépendance de l'application (EC2) à la base de données (RDS) :

```hcl
# ... Module EC2 utilise l'adresse de la base de données fournie par le module RDS
module "ec2" {
  # ...
  db_host = module.rds.primary_db_address
}


📋 Exécution
L'infrastructure peut être provisionnée avec les commandes Terraform standards :

Initialiser les modules et le backend :

Bash

terraform init
Visualiser les changements :

Bash

terraform plan
Déployer l'infrastructure :

Bash

terraform apply
