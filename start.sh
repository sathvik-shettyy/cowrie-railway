#!/bin/bash

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

touch var/log/cowrie/cowrie.json

. cowrie-env/bin/activate

bin/cowrie start

echo "Cowrie started"

cd /app

echo "Starting dashboard..."

python dashboard.py
