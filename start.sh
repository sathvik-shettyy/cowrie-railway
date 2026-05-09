#!/bin/bash

set -e

echo "Starting Cowrie stable runtime..."

cd /opt/cowrie

export PYTHONPATH=/opt/cowrie

# DO NOT use cowrie CLI at all
# directly run twisted application
./venv/bin/twistd -n -y cowrie.tac &

sleep 10

echo "Checking listening ports..."
ss -tuln || netstat -tuln || true

echo "Starting dashboard..."
cd /app
python dashboard.py
