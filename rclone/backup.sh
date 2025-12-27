#!/bin/bash
set -euo pipefail

# Go to compose directory
cd  /home/zulkarnen/Developments/Personal/docker-compose-collection/rclone

# Optional: simple lock to prevent overlapping runs
LOCKFILE="/tmp/backup.lock"
exec 9>"$LOCKFILE"
flock -n 9 || exit 0

# Run backup
docker compose run --rm -T backup
