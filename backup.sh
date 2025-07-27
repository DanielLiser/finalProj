#!/bin/bash

CONTAINER_NAME=my-mysql
BACKUP_FILE=joomla-$(date +%F-%H-%M).sql.gz

echo "🔄 Starting backup of MySQL..."

docker exec "$CONTAINER_NAME" sh -c 'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" --all-databases' | gzip > "$BACKUP_FILE"

echo "✅ Backup saved to $BACKUP_FILE"
