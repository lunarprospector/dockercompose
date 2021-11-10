#!/bin/sh

# Getting the parameters from 'env' to be able to create the mysql command.
host=$(env | grep ^DB_HOST | awk -F "=" '{print $2}')
port=$(env | grep ^DB_PORT | awk -F "=" '{print $2}')
pswd=$(env | grep ^DB_ROOT_PASSWORD | awk -F "=" '{print $2}')
user=$(env | grep ^DB_USER | awk -F "=" '{print $2}')


# Removing the newlines from 'db.sql' so that the DB and the table can be created in one mysql command.
command=$(tr -d '\n' < /tmp/db.sql)


# This 'until' loop is running as long as the veryfing if MariaDB has been initialized.
echo "Checking if MariaDB is available.."
until mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "SHOW DATABASES;" >/dev/null 2>&1
do
  echo $?
  sleep 2
done

# After connection has been established, create the database and the table.
echo "Connection has finally been established!"
echo "Creating the database..."
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "${command}"

# Verifying is database and the table have been created.
sleep 15
echo
mysql -u"${user}" -p"${pswd}" -h "${host}" -P"${port}" -e "SHOW DATABASES;"
