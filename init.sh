#!/bin/sh

sleep 10 
ping -c 5 MariaDB

# Getting the parameters from 'env' to be able to create the mysql command.
host=$(env | grep ^DB_HOST | awk -F "=" '{print $2}')
port=$(env | grep ^DB_PORT | awk -F "=" '{print $2}')
pswd=$(env | grep ^DB_ROOT_PASSWORD | awk -F "=" '{print $2}')
user=$(env | grep ^DB_USER | awk -F "=" '{print $2}')

# Removing the newlines from 'db.sql' so that the DB and the table can be created in one mysql command.
command=$(tr -d '\n' < /tmp/db.sql)

echo
echo "Creating the database."
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "${command}"

echo
echo "Checking if the database exists."
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "SHOW DATABASES;"
