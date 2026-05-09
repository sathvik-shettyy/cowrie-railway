#!/bin/bash

set -e

echo "Starting Cowrie..."

export PATH=/opt/cowrie/venv/bin:$PATH

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

# IMPORTANT: use official entrypoint
./venv/bin/python -m cowrie start &

sleep 6

echo "Cowrie process check:"
ps aux || true

echo "Starting dashboard..."
cd /app
python dashboard.py
