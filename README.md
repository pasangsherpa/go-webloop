# go-webloop
Docker image of Ubuntu 14.04 with WebKitGTK+, Golang, godep and webloop

### Installation

1. Install [Docker](https://www.docker.com/)

2. Pull image from repo 

		$ docker pull pasangsherpa/go-webloop

3. Alternatively, you can build an image from Dockerfile: 
    
		$ git clone git@github.com:pasangsherpa/go-webloop.git
		$ cd go-webloop
		$ docker build -t=go-webloop .


### Usage
	$ docker run -it --rm -e APP=[GO_APP_NAME]	pasangsherpa/go-webloop

### Delete all untagged images
	$ docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
