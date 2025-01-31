# change all values before execution
mkdir -p ../secrets
echo "projectname_db" > ../secrets/mariadb_database.txt
echo "projectname_dbuser" > ../secrets/mariadb_user.txt
echo "userpassword" > ../secrets/mariadb_user_password.txt
echo "rootpassword" > ../secrets/mariadb_root_password.txt
