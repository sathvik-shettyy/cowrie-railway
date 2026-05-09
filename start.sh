#!/bin/bash

set -e

echo "Starting Cowrie..."

cd /opt/cowrie

mkdir -p var/lib/cowrie
mkdir -p var/log/cowrie

export COWRIE_HOME=/opt/cowrie

# activate venv properly
source /opt/cowrie/cowrie-env/bin/activate

# start cowrie correctly using bin wrapper (it exists after install .)
/opt/cowrie/cowrie-env/bin/cowrie start

sleep 5

echo "Cowrie should now be running"

echo "Starting dashboard..."
cd /app
python3 dashboard.py
