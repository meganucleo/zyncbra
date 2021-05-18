# zyncbra
Script for syncing zimbra mailboxes using imapsync and a text file for bulk process

## Usage
Usage: zyncbra.sh filename.txt

filename.txt could be any text file in a comma separated value

## Change servers
In order to edit source and destination zimbra servers, edit the script and change the following variables:

HOST1="source server ip address"

HOST2="destination server ip address"

## CSV file structure

The script expects to receive the following text file structure

username_a,password_a
username_b,password_b
username_c,password_c
...
username_z,password_z

Since we are migrating the same accounts from one zimbra instance to another, the username and password for the imapsync command will be exactly the same for username1 and username2 and password1 and password2.

## Miscelaneous

Additionaly, if the scripts receives an imapsync error, it uses logger to send it to the /var/log/messages or /var/log/syslog (depending on your system), so you can check if the command ran correctly.

