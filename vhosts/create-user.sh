#!/bin/bash

# ask for new sftp user
echo "Please enter sftp user name:"
read sftp_user

# create user
useradd $sftp_user

# add user to group sftp
useradd $sftp_user -g sftp

# define password for user
passwd $sftp_user