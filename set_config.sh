#/bin/bash

echo "[mysqld]
## File Key Management
plugin_load_add = file_key_management
file_key_management_filename = /etc/my.cnf.d/encryption/keys.enc
file_key_management_filekey = FILE:/etc/my.cnf.d/encryption/password_file
file_key_management_encryption_algorithm = aes_cbc

## InnoDB/XtraDB Encryption Setup
innodb_default_encryption_key_id = 1
innodb_encrypt_tables = ON
innodb_encrypt_log = ON
innodb_encryption_threads = 4

## Aria Encryption Setup
aria_encrypt_tables = ON

## Temp & Log Encryption
encrypt-tmp-disk-tables = 1
encrypt-tmp-files = 1
encrypt_binlog = ON

ssl_cert = /etc/my.cnf.d/certificates/server-cert.pem
ssl_key = /etc/my.cnf.d/certificates/server-key.pem
ssl_ca = /etc/my.cnf.d/certificates/ca.pem" > /etc/my.cnf.d/enc.cnf

service mariadb restart