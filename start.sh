#!/bin/bash

set -e

echo "Starting services..."

cd /opt/cowrie

# START COWRIE ON 2222 (SSH)
./venv/bin/cowrie start &

sleep 5

echo "Cowrie should now be running on 2222"

# START DASHBOARD ON 8080 (NOT 2222)
cd /app

python dashboard.py --port 8080
