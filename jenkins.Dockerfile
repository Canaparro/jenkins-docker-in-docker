FROM jenkins/jenkins:lts

USER root

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

USER jenkins

RUN jenkins-plugin-cli --plugins blueocean:1.24.3