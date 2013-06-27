#!/bin/bash
#           _ ._  _ , _ ._
#         (_ ' ( `  )_  .__)
#       ( (  (    )   `)  ) _)
#      (__ (_   (_ . _) _) ,__)
#          `~~`\ ' . /`~~`
#          ,::: ;   ; :::,
#         ':::::::::::::::'
# _____________/_ __ \____________
#|                                |
#| iibot - an irc bot based on II |
#| http://tools.suckless.org/ii/  |
#|                                |
#|________________________________|

SERVER="irc.freenode.net"
CHANNEL="#buttsavage"
NICK="dav3bot"

( 
flock -n -e 200 || exit 1
ii -s ${SERVER} -n ${NICK} -i /tmp/& 
echo $! > /tmp/iibot.pid
trap 'kill `cat /tmp/iibot.pid`;rm /tmp/iibot.pid' EXIT 
sleep 1
echo "/j ${CHANNEL}" > /tmp/${SERVER}/in
sleep 1
echo "-online-" > /tmp/${SERVER}/${CHANNEL}/in
tailf -n1 /tmp/${SERVER}/${CHANNEL}/out | \
    while read -r date time nick mesg; do
        case $mesg in
            '!ping')
                msg=$(echo ${nick}|sed -e 's/>//g' -e 's/<//g')": Pong!"
                ;;
            '!commit')
                msg=$(curl -s whatthecommit.com/index.txt)
                ;;
            '!fortune')
                msg=$(fortune)
                ;;
            '!echo'*)
                msg="$date $time $nick $mesg" 
                ;;
            '!dns'*)
                msg=$(host `echo $mesg | awk '{print $NF}'`)
                ;;
            '!suicide')
                [ $nick ==  "<kuroishi>" ] && { echo 'goodbye' > /tmp/${SERVER}/${CHANNEL}/in ; break; }
                ;;
        esac
    [[ -n $msg ]] && echo $msg ; msg=''
done > /tmp/${SERVER}/${CHANNEL}/in
kill `cat /tmp/iibot.pid` ; rm /tmp/iibot.pid
) 200>/var/lock/.ii.lock
rm -rf /tmp/${SERVER} 
