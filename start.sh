#!/bin/bash

set -e

echo "Starting Cowrie..."

export PATH=/app/venv/bin:$PATH

# Use ONLY writable filesystem on Railway
export COWRIE_LOG_DIR=/tmp/cowrie-logs
export COWRIE_VAR_DIR=/tmp/cowrie-var

mkdir -p /tmp/cowrie-logs
mkdir -p /tmp/cowrie-var

# start Cowrie (safe mode)
cowrie start &

sleep 5

echo "Cowrie status check:"
ps aux | grep cowrie || true

echo "Starting dashboard..."
python dashboard.py
