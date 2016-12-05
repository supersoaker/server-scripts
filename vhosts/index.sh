#!/bin/bash

# ask for new sftp user
echo "Please enter sftp user name:"
read sftp_user

# check if user already exists
userIsSet=false
getent passwd $sftp_user >/dev/null 2>&1 && userIsSet=true

if $userIsSet; then
    echo "User $sftp_user already exists" && exit;
fi

# add user to group sftp
useradd $sftp_user -g sftp

echo "Please enter a password for user $sftp_user:"
read user_pw

echo -e "$user_pw" | passwd $sftp_user