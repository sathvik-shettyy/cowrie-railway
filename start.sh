#!/bin/bash

set -e

echo "Starting Cowrie (corrected)..."

cd /opt/cowrie

# VERIFY venv exists
ls -la venv/bin || echo "VENV MISSING"

# START COWRIE PROPERLY
./venv/bin/cowrie start &

sleep 8

echo "Checking if Cowrie is running..."
ps aux || true

echo "Starting dashboard..."
cd /app
python dashboard.py
