#!/bin/bash

echo "Creating Docker network..."
docker network create joomla-net

echo "Starting MySQL container..."
docker run -d \
  --name my-mysql \
  --network joomla-net \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=joomla_db \
  -v joomla-mysql-data:/var/lib/mysql \
  mysql:5.7

echo "Starting Joomla container..."
docker run -d \
  --name my-joomla \
  --network joomla-net \
  -p 8080:80 \
  -e JOOMLA_DB_HOST=my-mysql \
  -e JOOMLA_DB_PASSWORD=my-secret-pw \
  -e JOOMLA_DB_NAME=joomla_db \
  -v joomla-html-data:/var/www/html \
  joomla

echo "Done! Joomla should be accessible at http://localhost:8080"
