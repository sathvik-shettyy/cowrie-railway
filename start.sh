#!/bin/bash

set -e

echo "Starting Cowrie..."

export PATH=/app/venv/bin:$PATH

# FORCE ALL RUNTIME PATHS TO /tmp (CRITICAL FIX)
export COWRIE_HOME=/tmp/cowrie
export COWRIE_VAR=/tmp/cowrie/var
export COWRIE_LOG=/tmp/cowrie/log
export PYTHONPATH=/app/venv/lib/python3.11/site-packages

mkdir -p /tmp/cowrie/var
mkdir -p /tmp/cowrie/log

# start Cowrie
cowrie start &

sleep 8

echo "Cowrie process check:"
ps aux | grep cowrie || true

echo "Starting dashboard..."
python dashboard.py
