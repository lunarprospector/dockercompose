#!/bin/sh

# Getting the parameters from 'env' to be able to create the mysql command.
#host=$(env | grep ^DB_HOST | awk -F "=" '{print $2}')
#port=$(env | grep ^DB_PORT | awk -F "=" '{print $2}')
#pswd=$(env | grep ^DB_ROOT_PASSWORD | awk -F "=" '{print $2}')
#user=$(env | grep ^DB_USER | awk -F "=" '{print $2}')


# Removing the newlines from 'db.sql' so that the DB and the table can be created in one mysql command.
#command=$(tr -d '\n' < /tmp/db.sql)

command=$(tr -d '\n' < db.sql)

until mysql -uroot -psecret -h 127.0.0.1 -P13306 -e "SHOW DATABASES;" >/dev/null 2>&1
do
  echo $?
  sleep 2
done

echo "Connection has finally been established!"
echo
echo "Creating the database..."
#mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "${command}"
mysql -uroot -psecret -h 127.0.0.1 -P13306 -e "${command}"
