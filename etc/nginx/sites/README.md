# Nginx site configuration directory

Any .conf files that you put into this directory will
be mounted into the Nginx container

Below is an example configuration file:

```
    # Nginx host configuration for sample app

    # app is served by Gunicorn, running under port 5000
    upstream app {
        server 127.0.0.1:5000 fail_timeout=0;
    }

    server {
        listen 80;
        server_name app.example.dev;

        rewrite ^ https://$http_host$request_uri? permanent;

        # See http://abitwiser.wordpress.com/2011/02/24/virtualbox-hates-sendfile/
        sendfile off;
    }

    server {
        listen 443;
        server_name example.com;

        # See http://abitwiser.wordpress.com/2011/02/24/virtualbox-hates-sendfile/
        sendfile off;

        ssl on;
        ssl_protocols       SSLv3 TLSv1;
        ssl_ciphers         HIGH:!ADH:!MD5;
        ssl_prefer_server_ciphers on;
        ssl_certificate     /etc/nginx/certs/self_signed.crt;
        ssl_certificate_key /etc/nginx/certs/self_signed.key;

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        location /static/ {
            alias /app/static/;
        }
        location / {
            # once SSL termination is complete, redirect everything
            # to non-SSL endpoint
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            # this is set to ensure that django is_secure returns True
            # http://www.micahcarrick.com/using-ssl-behind-reverse-proxy-in-django.html
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $http_host;
            proxy_pass http://app;
        }
    }
```
