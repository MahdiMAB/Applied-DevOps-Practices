#!/bin/bash

echo "Récupération des logs de FastAPI..."
kubectl logs -l app=fastapi > fastapi-logs.txt
echo "Logs de FastAPI enregistrés dans fastapi-logs.txt"

echo "Récupération des logs de PostgreSQL..."
kubectl logs -l app=postgres > postgres-logs.txt
echo "Logs de PostgreSQL enregistrés dans postgres-logs.txt"

