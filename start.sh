#!/bin/bash

set -e

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

export COWRIE_HOME=/opt/cowrie

source /opt/cowrie/cowrie-env/bin/activate

# IMPORTANT: use twisted runner (correct Cowrie runtime)
twistd -n cowrie &

sleep 5

echo "Cowrie status:"
ps aux | grep cowrie || true

echo "Starting dashboard..."

cd /app
python3 dashboard.py
