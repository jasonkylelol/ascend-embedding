#!/bin/bash

# Function to check if a value is a number and greater than zero
is_positive_number() {
    if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
        return 1
    fi
    return 0
}

# Checking if two parameters are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: run.sh [port] [workers]"
    exit 1
fi

PORT=$1
WORKERS=$2

# Check if PORT is a positive number
if ! is_positive_number "$PORT"; then
    echo "port should greater than 0"
    exit 1
fi

# Check if WORKERS is a positive number
if ! is_positive_number "$WORKERS"; then
    echo "worker should greater than 0"
    exit 1
fi

source /usr/local/Ascend/ascend-toolkit/set_env.sh

echo "------------------------------ env ------------------------------------"
env
echo "------------------------------ params ------------------------------------"
echo "port: $PORT workers: $WORKERS"
echo "------------------------------ server starting ------------------------------------"
uvicorn text_embedding:app --host 0.0.0.0 --port $PORT --workers $WORKERS
