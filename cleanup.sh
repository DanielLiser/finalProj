#!/bin/bash

echo "🧹 Stopping and removing containers..."
docker rm -f my-joomla my-mysql

echo "🗑️ Removing Docker network..."
docker network rm joomla-net

echo "✅ Cleanup completed."
