# Nginx certs directory

This directory is mounted into the Nginx container, and available
to Nginx through the `ssl_certificate` and `ssl_certificate_key`
properties:

```
server {
    listen 443;
    server_name example.com;

    ssl on;
    ssl_protocols       SSLv3 TLSv1;
    ssl_ciphers         HIGH:!ADH:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_certificate     /etc/nginx/certs/self_signed.crt;
    ssl_certificate_key /etc/nginx/certs/self_signed.key;
    ...
}
```

The following bash script will create a self-signed certificate:

```bash
# create a new self-signed certificate for *.example.com
CERT_FILE_PATH="/vagrant/etc/nginx/self_signed"
echo "->  Creating SSL certificate files"
if [ ! -f $CERT_FILE_PATH.key ];
then
    openssl req \
        -new \
        -newkey rsa:2048 \
        -days 365 \
        -nodes \
        -x509 \
        -subj "/C=GB/ST=England/L=London/CN=*.example.com" \
        -keyout $CERT_FILE_PATH.key \
        -out $CERT_FILE_PATH.crt
    echo "<-  Certificate files created"
else
    echo "<-  Certificate files already exist"
fi
```
