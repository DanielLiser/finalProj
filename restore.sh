#!/bin/bash

echo "♻️ Starting FULL Joomla restore..."

# Automatically detect container names
DB_CONTAINER=$(docker ps --filter "name=db" --format "{{.Names}}" | head -n1)
WEB_CONTAINER=$(docker ps --filter "name=joomla" --format "{{.Names}}" | head -n1)

# Validate containers
if [ -z "$DB_CONTAINER" ] || [ -z "$WEB_CONTAINER" ]; then
  echo "❌ Could not find Joomla or DB containers. Make sure they are running."
  exit 1
fi

# Validate backup files
if [ ! -f backup/my-joomla.backup.sql.gz ]; then
  echo "❌ Database backup file missing: backup/my-joomla.backup.sql.gz"
  exit 1
fi

if [ ! -f backup/joomla-files.tar.gz ]; then
  echo "❌ Joomla files backup missing: backup/joomla-files.tar.gz"
  exit 1
fi

# Restore site files
echo "🗂️ Restoring Joomla site files into container: $WEB_CONTAINER..."
docker exec -i "$WEB_CONTAINER" tar xzf - -C / < backup/joomla-files.tar.gz

# Restore MySQL database
echo "📦 Restoring MySQL database into container: $DB_CONTAINER..."
gunzip < backup/my-joomla.backup.sql.gz | docker exec -i "$DB_CONTAINER" sh -c 'exec mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"'

echo "✅ FULL RESTORE COMPLETED"
