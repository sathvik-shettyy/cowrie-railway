#!/bin/bash

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

touch var/log/cowrie/cowrie.json

/opt/cowrie/cowrie-env/bin/python -m cowrie start

echo "Cowrie started"

cd /app

echo "Starting dashboard..."

python3 dashboard.py
