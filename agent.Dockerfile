FROM jenkins/ssh-agent

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/