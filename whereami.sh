#!/bin/bash

echo "user: $(whoami)"
echo "host: $(hostname)"
echo "folder: $(pwd)"
echo "os:   $(source /etc/os-release && echo "$PRETTY_NAME")"
echo "docker: $(docker --version 2>/dev/null || echo not installed)"
echo "python: $(python3 --version 2>/dev/null || echo not installed)"
