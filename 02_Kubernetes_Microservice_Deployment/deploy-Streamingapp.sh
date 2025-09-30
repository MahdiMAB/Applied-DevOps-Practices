#!/bin/bash

# Appliquer les fichiers de configuration
echo "Déploiement de configmap.yaml..."
kubectl apply -f configmap.yaml

echo "Déploiement de secrets.yaml..."
kubectl apply -f secrets.yaml

echo "Déploiement de ingress.yaml..."
kubectl apply -f ingress.yaml

echo "Déploiement de postgres-pvc.yaml..."
kubectl apply -f postgres-pvc.yaml

echo "Déploiement de postgres-pv.yaml..."
kubectl apply -f postgres-pv.yaml


echo "Déploiement de postgres-StatefulSet.yaml..."
kubectl apply -f postgres-StatefulSet.yaml

echo "Déploiement de streamingApp-deployment.yaml..."
kubectl apply -f streamingApp-deployment.yaml

echo "Déploiement terminé !"

