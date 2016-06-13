# PHP-FPM & Nginx Docker Image

Lightwight Docker image for the (latest) PHP-FPM and Nginx based on [AlpineLinux](http://alpinelinux.org)

* Image size only ~100MB !
* Very new packages (alpine:latest) 2015-04-03:
  * [PHP 7]
  * [Nginx]
  
  
### Usage
```bash
sudo docker run -v /data:/DATA/htdocs -p 80:80 hobord/alpine-ngnix-php7-fpm-devenv
```

### Volume structure

* `htdocs`: Webroot
* `logs`: Nginx/PHP error logs
