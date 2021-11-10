#!/bin/bash

# Verifying if MariaDB is ready.
# 'docker logs mariadb' prints to standard error, therefore, I first send stderr to stdout to grep it.
isdbready=$(docker logs mariadb 2>&1 | grep "mysqld: ready for connections.")

if [ ! -z "$isdbready" ]
then

echo "looks like DB is started! Now filling it.."

# Removing newlines, so I can send the sql instructions in one single command.
command=$(tr -d '\n' <db.sql)

# creating the database and the table.
docker exec mariadb mysql -uroot -ppassword -e "$command"

# getting the result back.
docker exec mariadb mysql -uroot -ppassword -e "USE HEALTHCHECK;SHOW TABLES;"

fi
