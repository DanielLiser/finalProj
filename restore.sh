#!/bin/bash

CONTAINER_NAME=my-mysql
BACKUP_FILE=$(ls -t joomla-*.sql.gz | head -n1)

if [ ! -f "$BACKUP_FILE" ]; then
  echo "❌ Backup file not found."
  exit 1
fi

echo "🔁 Restoring from $BACKUP_FILE..."

gunzip < "$BACKUP_FILE" | docker exec -i "$CONTAINER_NAME" sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"'

echo "✅ Restore complete."
