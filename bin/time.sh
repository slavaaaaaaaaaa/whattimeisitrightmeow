#!/bin/bash

set -ex

git config user.name time
git config user.email time@allweretaken.xyz
git config commit.gpgsign false

if [ -e lock ]; then
    rm lock
fi

while true; do
    date=$(date +"%H %M %Z")
    commits=$(git shortlog | grep -E '^[^ ]' | grep time | sed -e 's/^.*(//g' -e 's/).*//g')
    sed -i'traaash' -e 's&<p can i put a marker here?.*$&<p can i put a marker here?>'"$date"'</p>&' index.html
    sed -i'traaash' -e 's&<p can i put another marker here?.*$&<p can i put another marker here?>'"$commits"' minutes committed</p>&' index.html
    echo $date > time.txt
    git add index.html time.txt
    git commit -m "Can't you see I'm updating the time?"
    if ! [ -e lock ]; then
        ( touch lock; \
	cmdpid=$BASHPID; \
	(sleep 30; kill $cmdpid && rm lock || rm lock) & \
	    (
            git pull --rebase origin master; \
            git push origin master; \
            );
	)&
    fi
    sleep $((60 - $(date +%-S)))
done
