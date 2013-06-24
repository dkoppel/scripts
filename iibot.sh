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

ii -s irc.freenode.net -n Dav3b0t -i /tmp/ &
sleep 1
echo '/j #buttsavage' > '/tmp/irc.freenode.net/in'
sleep 1
echo '-online-' > '/tmp/irc.freenode.net/#buttsavage/in'
tailf -n1 '/tmp/irc.freenode.net/#buttsavage/out' | \
    while read -r date time nick mesg; do
        case $mesg in
            '!ping')
                msg=$(echo ${nick}|sed -e 's/>//g' -e 's/<//g')": Pong!"
                ;;
            #'!pacman')# this script floods and drops ii.
            #    exec ~/scripts/pacman-short.sh > /tmp/irc.freenode.net/#buttsavage/in
            #    ;;
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
                [ $nick ==  "<kuroishi>" ] && { echo 'goodbye' > /tmp/irc.freenode.net/#buttsavage/in ; break; }
                ;;
        esac
    [[ -n $msg ]] && echo $msg ; msg=''
done > /tmp/irc.freenode.net/#buttsavage/in
killall ii
rm -rf /tmp/irc.freenode.net 

