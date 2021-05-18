#!/bin/bash

#Zyncbra is a Script for syncing to zimbra servers
#author Leon Ramos 2021 @fulvous

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.



#EDIT the following variables according to your servers ip
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
                echo "==============Working on ${user}=================="
                imapsync --host1 ${HOST1} --user1 ${user} --password1 ${password} --authmech1 PLAIN --ssl1 --host2 ${HOST2} --user2 ${user} --password2 ${password} --authmech2 PLAIN --ssl2
                if [ $? -eq 0 ] ; then
                        logger "imapsync ${user} CORRECT"
                else
                        logger "imapsync ${user} ERROR"
                fi
        done
        } < $ARCHIVO
}

time sync
