#!/bin/bash

set -e

echo "Starting Cowrie..."

export PATH=/app/venv/bin:$PATH

mkdir -p /app/logs

# start cowrie directly (THIS IS THE FIX)
cowrie start &

sleep 5

echo "Checking Cowrie process..."
ps aux | grep cowrie || true

echo "Starting dashboard..."
python dashboard.py
