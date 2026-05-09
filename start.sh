#!/bin/bash

set -e

echo "Starting Cowrie + Dashboard..."

cd /opt/cowrie

# Start Cowrie in background
./venv/bin/cowrie start &

sleep 5

echo "Cowrie launched"

# Start Flask (THIS keeps Railway alive)
cd /app
python dashboard.py
