#/bin/bash

# install mariadb
yum update -y --exclude='kernel*'
yum install mariadb-server -y
systemctl enable mariadb
     
mkdir /db
chown mysql:root /db

yum install -y policycoreutils-python-utils setroubleshoot-server selinux-policy-doc
semanage fcontext -a -t mysqld_db_t "/db(/.*)?"
restorecon -Rv /db

semanage port -a -t mysqld_port_t -p tcp 3300
firewall-cmd --permanent --add-port=3300/tcp
firewall-cmd --reload

echo "
[mysqld]
port = 3300
datadir = /db" >> /etc/my.cnf

systemctl start mariadb