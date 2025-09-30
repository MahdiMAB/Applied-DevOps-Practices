#!/bin/bash

PROJECT_DIR="01_API_Test_Pipeline"
cd "$PROJECT_DIR" || exit 

echo "Démarrage du pipeline de tests Docker Compose pour $PROJECT_DIR..."

docker build -t image_authentication_test -f tests/authentication/Dockerfile .
docker build -t image_authorization_test -f tests/authorization/Dockerfile .
docker build -t image_content_test -f tests/content/Dockerfile .

docker-compose up

echo "Fin du pipeline. Les logs sont disponibles dans $PROJECT_DIR/api_test.log"

cd ..

