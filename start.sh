#!/bin/bash

set -e

echo "Starting Cowrie (correct mode)..."

cd /opt/cowrie

# THIS IS THE ONLY VALID WAY
./bin/cowrie start &

sleep 5

echo "Cowrie started"

cd /app

python3 dashboard.py
