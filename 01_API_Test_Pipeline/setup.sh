#!/bin/bash

docker build -t image_authentication_test -f tests/authentication/Dockerfile .
docker build -t image_authorization_test -f tests/authorization/Dockerfile .
docker build -t image_content_test -f tests/content/Dockerfile .

docker-compose up

