#!/bin/bash

set -e

git config user.name time
git config user.email time@allweretaken.xyz
git config commit.gpgsign false

if [ -e lock ]; then
    rm lock
fi

while true; do
    date=$(date +"%H %M")
    sed -i 's&<p can i put a marker here?.*$&<p can i put a marker here?>'"$date"'</p>&' index.html
    echo $date > time.txt
    git add index.html time.txt
    git commit -m "Can't you see I'm updating the time?"
    if ! [ -e lock ]; then
        (touch lock; \
         git pull --rebase origin master: \
         git push origin master; \
         rm lock)&
    fi
    sleep $((60 - $(date +%-S)))
done
