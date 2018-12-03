# Check input
username=$(echo "$1" | tr -d "[:space:]")
if [ -z "${username}" ]; then
    echo -e "ERROR!\nPlease input username to grant perrmission!"
    exit 1
fi

# Check root permission
if [ `whoami` != "root" ]; then
    echo -e "ERROR\nPermission denied! you must be root user"
    exit 2
fi

# Check exist user
cat /etc/passwd | cut -d: -f1   | grep -q -x ${username}
if [ $? -ne 0 ]; then
    echo "User '"${username}"' does not exist, please check and try again!"
    exit 3
fi

setfacl -m u:${username}:rw /etc/hosts