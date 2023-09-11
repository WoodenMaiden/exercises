#!/bin/bash

if [ -z "$MONGO_URI" ]; then 
    echo "MONGO_URI is not set"
    exit 1
fi

# execute the command passed to the docker run
exec "$@"