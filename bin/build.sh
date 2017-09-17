#!/bin/bash

while true; do
    date +"%H %M" > time.txt
    cat time.txt
    git add . && git commit -m "Can't you see I'm updating the time?" && git push origin master
    sleep 60
done
