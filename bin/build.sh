#!/bin/bash

set -e

git config user.name time
git config user.email time@allweretaken.xyz
git config commit.gpgsign false

while true; do
    sed -i 's&<p can i put a marker here?.*$&<p can i put a marker here?>'"$(date +"%H %M")"'</p>&' index.html
    git add index.html
    echo $(date +"%H %M") > time.txt
    git add time.txt
    git commit -m "Can't you see I'm updating the time?"
    git pull --rebase origin master
    git push origin master
    sleep $((60 - $(date +%-S)))
done
