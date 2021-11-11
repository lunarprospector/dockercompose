#!/bin/sh

# Getting the parameters from 'env' to be able to create the mysql command.
host=$(env | grep ^DB_HOST | awk -F "=" '{print $2}')
port=$(env | grep ^DB_PORT | awk -F "=" '{print $2}')
pswd=$(env | grep ^DB_ROOT_PASSWORD | awk -F "=" '{print $2}')
user=$(env | grep ^DB_USER | awk -F "=" '{print $2}')


# Removing the newlines from 'db.sql' so that the DB and the table can be created in one mysql command.
command=$(tr -d '\n' < /tmp/db.sql)


# This 'until' loop runs until the command returns a 'true' exit status (can see the databases).
until mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "SHOW DATABASES;" >/dev/null 2>&1
do
  sleep 2
done

# After connection has been established, create the database and the table.
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "${command}"


# Verifying if database and the table have been created.
echo "Here are the databases:"
echo "======================="
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "SHOW DATABASES;"

echo

echo "Here are the tables in DB HEALTHCHECK"
echo "====================================="
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "USE HEALTHCHECK;SHOW TABLES;"
