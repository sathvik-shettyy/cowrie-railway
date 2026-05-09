#!/bin/bash

set -e

echo "Starting Cowrie correctly..."

cd /opt/cowrie

# IMPORTANT: use correct venv binary
./venv/bin/twistd -n cowrie &

sleep 8

echo "Checking if port 2222 is open..."
ss -tuln || netstat -tuln || true

echo "Starting dashboard..."
cd /app
python dashboard.py
