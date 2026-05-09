#!/bin/bash

set -e

echo "Starting Cowrie (Twisted correct mode)..."

cd /opt/cowrie

# THIS is the ONLY reliable launcher in your setup
./venv/bin/twistd -n cowrie &

sleep 5

echo "Cowrie started"

cd /app

python3 dashboard.py
