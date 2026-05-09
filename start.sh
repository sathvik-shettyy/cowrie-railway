#!/bin/bash

set -e

echo "Starting Cowrie (Railway stable mode)..."

cd /opt/cowrie

# IMPORTANT: run Cowrie using module, NOT broken binary path
python3 -m cowrie start &

sleep 6

echo "Cowrie started"

cd /app

# Flask must bind to Railway PORT
python3 dashboard.py
