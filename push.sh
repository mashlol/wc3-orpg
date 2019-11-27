#!/bin/bash

set -e

if [ -z "$1" ]
then
    echo "MISSING DESCRIPTION, ABORTING"
    exit 1
else
    echo "Committing..."
    git add .
    git commit -m "$1"
    git pull --rebase
    git push
fi