#!/bin/bash

set -e

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

touch var/log/cowrie/cowrie.json

nohup /opt/cowrie/cowrie-env/bin/cowrie start > cowrie.log 2>&1 &

sleep 10

echo "Cowrie startup logs:"
cat cowrie.log || true

echo "Starting dashboard..."

cd /app

python3 dashboard.py
