#!/bin/bash

set -e

while true; do
    date +"%H %M" > time.txt
    cat time.txt
    git add time.txt
    git commit -m "Can't you see I'm updating the time?"
    git pull upstream master --rebase
    git push origin master
    sleep 60
done
