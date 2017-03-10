---
layout: post
locale: en
title:  "Playing with Docker and Jekyll"
date:   2017-03-08 10:34:00
categories: docker jekyll
excerpt: "Almost 2 years since the last post so let's be proactive and have a look at Docker with Jekyll!"
---

While giving this blog a fresh new look (with a modified version of the jekyll template Strata), I used [Docker](https://www.docker.com/) for the development phase.
I have been using docker at work within a vagrant machine, running 5 to 6 docker containers but I never really played with it so I decided to install jekyll and serve this blog with Docker.

# 1 - Install Docker

Right, so the first thing to do is [installing docker](https://www.docker.com/community-edition#/download), which works on Mac, Linux and Windows!

# 2 - Create a Dockerfile

The Dockerfile is to docker what wheels are to a car: you won't go far without it. The Dockerfile defines what your Docker image will contain and do.

Here is the one I came up with, and I'll explain what it does.

{% highlight bash linenos %}
FROM ruby:2.3

COPY . /jekyll-blog
WORKDIR /jekyll-blog

EXPOSE 4000

RUN bundler install
ENTRYPOINT jekyll serve -w -H 0.0.0.0 -P 4000
{% endhighlight %}

- Line 1: `FROM {image}` specifies that our image will be built from another image (here ruby, version 2.3) so we don't really start from scratch.
- Line 3: `COPY {source} {destination}` will copy the content of our current folder into the docker image.
- Line 4: `WORKDIR {path}` to set the default working directory for docker next commands/processes.
- Line 6: `EXPOSE {port}` will forward ports to open within your docker container - here jekyll needs the port 4000.
- Line 8: `RUN {command}` to run commands (you don't say?) - I want to install Jekyll dependencies for the Gemfile.
- Line 9: `ENTRYPOINT {process}` is the processus that will run by default - I am serving jekyll with a couple of parameters.

# 4 - Create your Docker Image

So you now have your Dockerfile, let's build the image from it now using the command `build [parameters] [dockerfile_source]`:

```
docker build -t jekyll-blog .
```

I use `-t` to name my image `jekyll-blog` so it is easier to find it when running `docker images`.

Building the Jekyll docker image will take a couple of minutes since it will download the ruby image needed, run your commands from the dockerfile and finally create the image.

# 5 - Run your Docker container

The image should have been created successfully and appear in your list of local images with `docker images` so now, let's use it to run the jekyll-blog container.

```
docker run -itd -p 1234:4000 -v "$(pwd):/jekyll-blog" --name blog jekyll-blog
```

I used a bunch of parameters which are:

- `-i` will keep STDIN open even if not attached (interactive).
- `-t` will allocate a pseudo-TTY.
- `-d` to run container in background and print container ID (detaching).
- `-p` to deal with ports.
- `-v` to mount volumes which is usefull while developing.
- `--name` will give your new container a nice name.

`jekyll-blog` is the name of the image we previously created.

# Profit

If your container is running correctly, you should be able to access your jekyll blog using [localhost:1234](http://127.0.0.1:1234) (or whatever port you set while running your docker container).

You can get some logs from docker with the `docker logs` command:

```
docker logs -f blog
```

You can also bash into your container if you need more information using the `docker exec` command:

```
docker exec -it blog bash
```

# Stopping and Removing all traces

While playing with Docker, I found it helpful to cleanup all my test containers and images.

The proper way to remove a container would be to stop it and then remove it.

```
docker stop [container_name_or_id]
docker rm [container_name_or_id]

# I can be lazy so I also used
docker rm -f [container_name_or_id]
```

To remove an image, you will have to stop any container which is currently using it.

```
docker rmi [image_id]

# or just force delete it
docker rmi -f [image_id]
```

At some point I just had too many containers/images to remove so I simply used:

```
docker rm $(docker ps -qa)
docker rmi $(docker images -q)
```

which will remove all existing container and images. Run the above command only if you absolutely want to clean up everything!

If you want to play more, have a look at the [list of existing docker images](https://hub.docker.com/explore/) and have fun!
