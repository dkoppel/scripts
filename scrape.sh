#!/bin/bash

for CHAR in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
do
    echo $CHAR
    maxpage=$(curl -s http://www.urbandictionary.com/browse.php?character=${CHAR} | grep '<li class="next">' | grep -Eo 'page=[0-9]*' | sed 's/page=//g' | sort -V | tail -n 1)
    for x in $(seq 1 ${maxpage})
    do
        curl -s "http://www.urbandictionary.com/browse.php?character=${CHAR}&page=${x}" | grep 'term=' | sed -e 's/<li.*">//g' -e 's/<\/a.*//g'
    done
done > ~/tmp/udict.lst
