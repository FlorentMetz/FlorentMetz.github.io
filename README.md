### Install docker

	sudo apt-get install docker.io

### Build Image

	sudo docker build -t jekyll-blog .

### Run Docker Image

	sudo docker run -itd -p 1234:4000 -v "$(pwd):/jekyll-blog" --name blog jekyll-blog

### Docker bits and pieces

	# restart your container
	sudo docker restart blog

	# tail your container's logs
	sudo docker logs -f blog

	# remove all containers
	sudo docker rm $(docker ps -qa)

	# remove all images
	sudo docker rmi $(docker images -q)

### Access the blog

Once the Docker container is running, go to [localhost:1234](http://127.0.0.1:1234/)
