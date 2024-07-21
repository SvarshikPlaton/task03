#/bin/bash

# encryption in transit
mkdir /etc/my.cnf.d/certificates
cd /etc/my.cnf.d/certificates

openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 365000 \
    -key ca-key.pem -out ca.pem \
    -subj "/C=UA/ST=Kharkiv/L=Kharkiv/O=SoftServe/CN=SS CA/emailAddress=m.r.nemov@student.csn.khai.edu"

# generate server key
openssl req -newkey rsa:2048 -days 365000 \
    -nodes -keyout server-key.pem -out server-req.pem \
    -subj "/C=UA/ST=Kharkiv/L=Kharkiv/O=SoftServe/CN=localhost/emailAddress=m.r.nemov@student.csn.khai.edu"
openssl rsa -in server-key.pem -out server-key.pem -traditional
openssl x509 -req -in server-req.pem -days 365000 \
    -CA ca.pem -CAkey ca-key.pem -set_serial 01 \
    -out server-cert.pem

# generate client key
openssl req -newkey rsa:2048 -days 365000 \
    -nodes -keyout client-key.pem -out client-req.pem \
    -subj "/C=UA/ST=Kharkiv/L=Kharkiv/O=SoftServe/CN=localhost/emailAddress=m.r.nemov@student.csn.khai.edu"
openssl rsa -in client-key.pem -out client-key.pem -traditional
openssl x509 -req -in client-req.pem -days 365000 \
    -CA ca.pem -CAkey ca-key.pem -set_serial 01 \
    -out client-cert.pem

# set permissions
chown -R mysql:  .
chmod 500 .
chmod 400 ./*