# Jenkins with agent using docker-in-docker

In this repository you will find the required files to deploy a jenkins master along with an agent supporting docker builds by the means of docker-in-docker.
This is useful in a scenario where you want to have an easy to deploy CI/CD with limited resources.

# Dockerfiles

Both the jenkins and agent docker files are simple, they use the regular jenkins and ssh-agent images with a command to copy the docker folder from the docker-in-docker image, which will contain the docker-cli required to run docker instructions against it.

# Architecture

Using docker-compose we deploy jenkins master, jenkins agent and docker-in-docker containers, along with a network for communication between them.

## Docker-in-docker

As it is not be safest thing to share access to the docker running in your host machine with your builds, we make use of docker-in-docker to allow builds to use docker. This will have its own cli, socket connection and deamon running on top of your host machine docker as a container.

## Jenkins master

This will be accessible at port 8080 of your host, it has been configured to have access to docker-in-docker by the environment variables passed through and by having read access to the docker certificates folder.

```yaml
environment:
    - DOCKER_TLS_VERIFY=1 # Tells the docker client to use certificates on communications
    - DOCKER_CERT_PATH=/certs/client # Tells the docker client where are the certificates to be used in communications
    - DOCKER_HOST=tcp://docker:2376 # Tells the docker client where to connect to the daemon, in this case the dind through the jenkins network using an alias
volumes:
    - ./jenkins-docker-certs:/certs/client:ro # Docker client certs.
```
