#!/bin/bash

set -e

echo "Starting Cowrie (diagnostic mode)..."

cd /opt/cowrie || cd /app || exit 1

# show structure so we know what exists
ls -la

# run Cowrie using direct twisted application file (MOST STABLE PATH)
if [ -f cowrie.tac ]; then
    echo "Found cowrie.tac, starting..."
    twistd -n -y cowrie.tac
else
    echo "cowrie.tac NOT FOUND - Cowrie not installed correctly"
    sleep 3600
fi
