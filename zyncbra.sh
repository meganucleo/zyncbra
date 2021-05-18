#!/bin/bash

#Script for syncing to zimbra servers
#author Leon Ramos 2021 @fulvous

#Edit the following variables according to your servers ip
#HOST1 is the source server
#HOST2 is the destination server
HOST1="192.168.1.1"
HOST2="192.168.1.2"

if [ -z ${1} ] ; then
        echo "USAGE: ${0} textfile.csv"
        echo -e "\ttextfile.csv contains 'user,password', one line per mailbox"
        echo -e "\tEDIT SCRIPT FOR CHANGING SOURCE AND DESTINATION SERVERS"
        echo
        echo -e "\tEXAMPLE of textfile:"
        echo
        echo -e "\tuser_a,password_a"
        echo -e "\tuser_b,password_b"
        echo -e "\tuser_c,password_c"
        exit 1
fi

ARCHIVO="${1}"

function sync {
        { while IFS=',' read user password fake
        do
                echo "===================Sincronizando ${user}========================"
                imapsync --host1 ${HOST1} --user1 ${user} --password1 ${password} --authmech1 PLAIN --ssl1 --host2 ${HOST2} --user2 ${user} --password2 ${password} --authmech2 PLAIN --ssl2
                if [ $? -eq 0 ] ; then
                        logger "imapsync ${user} CORRECTO"
                else
                        logger "imapsync ${user} ERROR"
                fi
        done
        } < $ARCHIVO
}

time sync
