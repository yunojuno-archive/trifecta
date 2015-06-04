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
