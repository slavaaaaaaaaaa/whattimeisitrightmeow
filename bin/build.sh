#!/bin/bash

set -e

while true; do
    sed -i 's&<p can i put a marker here?.*$&<p can i put a marker here?>'"$(date +"%H %M")"'</p>&' index.html
    git add index.html
    git commit -m "Can't you see I'm updating the time?"
    git pull --rebase origin master
    git push origin master
    sleep $((60 - $(date +%S)))
done
