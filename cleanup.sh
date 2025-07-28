#!/bin/bash

echo "Stopping and removing containers..."
docker-compose down

echo "Removing volumes..."
docker volume rm finalproj_db_data

echo "Cleanup done."
