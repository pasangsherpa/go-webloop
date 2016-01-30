# go-webloop
Docker image of Ubuntu 14.04 with WebKitGTK+, Golang, godep and webloop


	$ docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")