#!/bin/bash
set -euo pipefail

: "${BACKUP_REMOTE:?BACKUP_REMOTE is required}"

BACKUP_RETENTION="${BACKUP_RETENTION:-3}"
BACKUP_EXCLUDES="${BACKUP_EXCLUDES:-}"

EXCLUDE_ARGS=""
if [[ -n "$BACKUP_EXCLUDES" ]]; then
  EXCLUDE_ARGS=$(echo "$BACKUP_EXCLUDES" | sed 's/,/ --exclude=/g' | sed 's/^/--exclude=/')
fi

exec curl -sL https://raw.githubusercontent.com/zulkarnen-force/bash-scripting/main/backup/folder.py \
  | python3 - \
      --folder /data \
      --remote "$BACKUP_REMOTE" \
      --retention "$BACKUP_RETENTION" \
      $EXCLUDE_ARGS
