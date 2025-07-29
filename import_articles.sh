#!/bin/bash

echo "📥 Importing full list of Joomla articles..."

docker exec -i finalproj-db-1 \
  mysql -uroot -pmy-secret-pw joomla \
  < articles_full.sql

echo "✅ All articles imported successfully!"
