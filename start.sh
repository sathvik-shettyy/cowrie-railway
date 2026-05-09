#!/bin/bash

set -e

echo "Starting Cowrie (safe mode)..."

cd /opt/cowrie

# IMPORTANT: use direct python entry (NOT twistd, NOT CLI)
python3 src/cowrie start &

sleep 10

echo "Checking processes..."
ps aux || true

echo "Starting dashboard..."
cd /app
python3 dashboard.py
