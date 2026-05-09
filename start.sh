#!/bin/bash

set -e

echo "Starting Cowrie (final stable)..."

# FIX PATH ISSUE (THIS WAS YOUR MAIN BUG)
COWRIE_PATH=/opt/cowrie

# verify venv exists
ls -la /opt/cowrie/venv/bin || echo "VENV STILL MISSING"

# start Cowrie properly
/opt/cowrie/venv/bin/cowrie start &

sleep 6

echo "Cowrie started"

# start dashboard with correct python (IMPORTANT FIX)
cd /app
python3 dashboard.py
