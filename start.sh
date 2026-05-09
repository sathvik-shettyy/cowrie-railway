#!/bin/bash

set -e

echo "Starting Cowrie (stable mode)..."

cd /opt/cowrie

export PYTHONPATH=/opt/cowrie

# IMPORTANT: run Cowrie via twistd application file
./venv/bin/twistd -n cowrie &

sleep 8

echo "Checking port 2222..."
netstat -tulpn || true

echo "Starting dashboard..."
cd /app
python dashboard.py
