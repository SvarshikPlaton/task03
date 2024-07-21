#/bin/bash

# encryption at rest
mkdir /etc/my.cnf.d/encryption
cd /etc/my.cnf.d/encryption

echo "1;$(openssl rand -hex 32)" | sudo tee keys > /dev/null
sudo openssl rand -hex 128 | sudo tee password_file > /dev/null
openssl enc -aes-256-cbc -md sha1 \
    -pass file:password_file -in keys -out keys.enc
mv /etc/my.cnf.d/encryption/keys ~/keys

# set permissions
chown -R mysql:root  .
chmod 500 .
chmod 400 ./*