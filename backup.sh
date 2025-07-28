#!/bin/bash

echo "🛡️ Starting FULL Joomla backup..."

# Automatically detect container names
DB_CONTAINER=$(docker ps --filter "name=db" --format "{{.Names}}" | head -n1)
WEB_CONTAINER=$(docker ps --filter "name=joomla" --format "{{.Names}}" | head -n1)

# Validate containers found
if [ -z "$DB_CONTAINER" ] || [ -z "$WEB_CONTAINER" ]; then
  echo "❌ Could not find Joomla or DB containers. Make sure they are running."
  exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p backup

# Backup MySQL database
echo "📦 Backing up MySQL database from container: $DB_CONTAINER..."
docker exec "$DB_CONTAINER" sh -c 'exec mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' | gzip > backup/my-joomla.backup.sql.gz

# Backup Joomla site files (volume)
echo "🗂️ Backing up Joomla site files from container: $WEB_CONTAINER..."
docker exec "$WEB_CONTAINER" tar czf - /var/www/html > backup/joomla-files.tar.gz

echo "✅ FULL BACKUP COMPLETED — files saved in ./backup"
