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
sleep 1
tailf -n1 '/tmp/irc.freenode.net/#buttsavage/out' | \
    while read -r date time nick mesg; do
        case $mesg in
            '!ping')
                msg=${nick}": Pong!"
                ;;
            '!suicide')
                msg='goodbye';
                break
                ;;
        esac
    echo $msg
    msg=''
    echo -ne > /tmp/irc.freenode.net/#buttsavage/out
done > /tmp/irc.freenode.net/#buttsavage/in
killall ii
rm -rf /tmp/irc.freenode.net 

