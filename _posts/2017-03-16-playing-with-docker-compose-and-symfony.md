---
layout: post
locale: en
title:  "Playing with docker-compose and Symfony"
date:   2017-03-16 15:21:00
categories: docker symfony
excerpt: "After playing with docker and jekyll, I had to look at docker-compose to implement a PHP project using the latest Symfony version."
---

I created the repository [docker-compose and Symfony](https://github.com/FlorentMetz/docker-compose-symfony) to play around and I like it a lot!

Here is the `docker-composer.yml` I came up with:

{% highlight yml linenos %}
version: '3'
services:

  redis:
    image: redis:latest
    container_name: redis

  db:
    image: mysql:5.7
    container_name: db
    ports:
     - "3306:3306"
    environment:
      - MYSQL_ALLOW_EMPTY_PASSWORD=yes
      - MYSQL_USER=flotz
      - MYSQL_PASSWORD=password
      - MYSQL_DATABASE=sf_app

  php-fpm:
    image: php:7-fpm
    container_name: php
    volumes:
      - ./sf-app:/srv/sf-app
      - ./php/sf-app.ini:/usr/local/etc/php/conf.d/sf-app.ini

  composer:
    image: composer/composer:alpine
    container_name: composer
    working_dir: /srv/sf-app
    volumes:
      - ./sf-app:/srv/sf-app

  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "8080:80"
    volumes:
      - ./sf-app:/srv/sf-app
      - ./nginx/vhost.conf:/etc/nginx/conf.d/sf-app.conf
{% endhighlight %}

As you can see, I am mainly using official images and I didn't really want to create `Dockerfile` files.
Instead, I have a couple of configuration files (for nginx and php) so I can override default settings for my needs.

### MySQL container

The container is pretty straightforward, the only sensible line is the `environment` (line 13 above) where you can specify the settings for accessing your database.
By default, the mysql image will create a root user. I use `MYSQL_ALLOW_EMPTY_PASSWORD=yes` to allow root user with an empty user - **do NOT do that in production!!**

- `MYSQL_USER` to create a user.
- `MYSQL_PASSWORD` to give the above user a password.
- `MYSQL_DATABASE` to create a database. The above user WILL have access to that database.

I often ran into issues whilst playing around with the database container; mostly with the `MYSQL_*` flags and I found out I needed to stop the container, remove the volumes and restart it.
`docker-compose rm -v` does the trick.

### Nginx container

This container is also pretty straightforward to setup, the only gotcha I ran into was actually in the `vhost.conf`.
Usually, the setting fastcgi points to the php sock file: `fastcgi_pass unix:/var/run/php5-fpm.sock;`.
when using 2 different containers (one for nginx and one for php-fpm) then you need to point to the php container: `fastcgi_pass php:9000;`.

The port 9000 needs to be exposed from the php-fpm image - which is by default. Pretty handy.

Interesting tip: you can get the logs from `docker logs -f nginx` if you change the values of:

```
access_log /dev/stdout;
error_log  /dev/stdout debug;
````

### Composer container

Once I had nginx and php-fpm setup, the next step was to throw in the [standard Symfony](http://symfony.com/doc/current/setup.html) framework.
To do so, I used the [composer container](https://hub.docker.com/r/composer/composer/)!

Make sure you use the right path in the `working_dir` setting (pointing to the Symfony root path) and then, simply run

```
docker-compose run composer install
```

Which will install the Symfony vendor, clear cache and install assets.

Job done, ready to code now!


{:.image.fit}
![Symfony 3.2](/images/posts/symfony-32-with-docker-compose.png 'Symfony 3.2')
