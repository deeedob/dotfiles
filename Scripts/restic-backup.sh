#!/bin/bash

if [[ -n $(pgrep 'restic' | grep 'restic backup') ]]; then
  echo 'restic is already running...' 1>&2
  exit 0
fi

set -e
set -v

export RESTIC_REPOSITORY='/backups'
export RESTIC_PASSWORD_COMMAND='get-restic-password'
export RESTIC_COMPRESSION='auto'
export RESTIC_CACHE_DIR=~/.cache/restic

mkdir -p "${RESTIC_CACHE_DIR}"

restic unlock
restic backup / --exclude-file=/etc/restic/excludes.txt --tag scheduled
restic check --with-cache --read-data-subset=5G
restic forget --prune --keep-hourly 24 --keep-daily 30 --keep-monthly 6 --keep-weekly 4 --keep-yearly 3
