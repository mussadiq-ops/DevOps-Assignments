#!/bin/bash

# Get the HTTP status code
# -s = silent, -o /dev/null = ignore body, -w = print only status code
code=$(curl -s -o /dev/null -w "%{http_code}" https://www.guvi.in)

echo "HTTP Status Code: $code"

# Check if code is 200 (OK)
if [ "$code" -eq 200 ]; then
    echo "Success: Website is reachable."
else
    echo "Failure: Website returned an error."
fi
