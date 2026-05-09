#!/bin/bash

set -e

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

export COWRIE_HOME=/opt/cowrie

source /opt/cowrie/cowrie-env/bin/activate

# START USING COWRIE BINARY (this is correct after pip install .)
bin/cowrie start

sleep 5

echo "Cowrie process check:"
ps aux | grep cowrie || true

echo "Starting dashboard..."
cd /app

python3 dashboard.py
