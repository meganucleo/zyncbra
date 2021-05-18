#!/bin/bash

#Script para sincronizar buzones de 2 zimbras en delti
#author Leon Ramos 2021 @fulvous

if [ -z ${1} ] ; then
        echo "USAGE: ${0} textfile.csv"
        echo -e "\ttextfile.csv contains 'user,password', one line per mailbox"
        echo
        echo -e "\tEXAMPLE:"
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
                imapsync --host1 10.1.3.66 --user1 ${user} --password1 ${password} --authmech1 PLAIN --ssl1 --host2 10.1.3.4 --user2 ${user} --password2 ${password} --authmech2 PLAIN --ssl2
                if [ $? -eq 0 ] ; then
                        logger "imapsync ${user} CORRECTO"
                else
                        logger "imapsync ${user} ERROR"
                fi
        done
        } < $ARCHIVO
}

time sync
