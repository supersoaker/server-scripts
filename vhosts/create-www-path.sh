#!/bin/bash

# ask for www-domain
echo "Please new www domain:"
read www_domain

# create directories
mkdir -p /var/www/${www_domain}/www/
mkdir -p /var/www/${www_domain}/log/

# ask for sftp user
echo "Please enter sftp user:"
read sftp_user

# add user to group sftp
usermod -g sftp $sftp_user

# set new home directory for sftp user
usermod -d /var/www/${www_domain} $sftp_user

# disable shell access for sftp user
usermod -s /bin/false $sftp_user

# set right directory owner
chown root:sftp /var/www/${www_domain}
chown ${sftp_user}:sftp /var/www/${www_domain}/www
chown ${sftp_user}:sftp /var/www/${www_domain}/log

# set right directory permissions
chmod 755 /var/www/${www_domain}

set_up_apache_vhost () 
{
	cp ./apache-vhost.conf /etc/apache2/sites-available/${1}.conf
	sed -i "s/##doc_root##/$1/g" /etc/apache2/sites-available/${1}.conf
	sed -i "s/##server_user##/$2/g" /etc/apache2/sites-available/${1}.conf
}

# ask to set up apache vhosts
while true; do
    read -p "Do you want to set up /etc/apache2/sites-available/${www_domain}.conf (y/n)?" yn
    case $yn in
        [Yy]* ) set_up_apache_vhost ${www_domain} ${sftp_user}; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
