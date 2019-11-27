#!/bin/bash

set -e

if [ -z "$1" ]
then
    echo "MISSING DESCRIPTION, ABORTING"
    exit 1
else
    COMMITS=$(git log --pretty=%s)

    if [[ $COMMITS =~ "$1" ]]
    then
        echo "There's already a commit with that message, aborting"
        exit 1
    fi

    echo "Committing and pushing with message:"
    echo "---"
    echo "$1"
    echo "---"
    echo "Does that look right? (y/N)"
    read result

    if [ $result ==  "y" ]; then
        echo "Okay, committing..."

        git add .
        git commit -m "$1"
        git pull --rebase
        git push

        exit 0
    fi

    echo "Aborted"

    exit 1
fi