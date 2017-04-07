FROM openjdk:8u121-jdk
MAINTAINER SCK Team somkiat@scrum123.com
RUN apt-get update -qq
RUN apt-get install -qqy ca-certificates curl git-core

RUN mkdir -p /opt/jenkins/data/plugins
RUN curl -sf -o /opt/jenkins/jenkins.war -L http://mirrors.jenkins.io/war-stable/1.651.3/jenkins.war
RUN curl -sf -o /opt/jenkins/data/plugins/ssh-credentials.hpi -L http://mirrors.jenkins-ci.org/plugins/ssh-credentials/latest/ssh-credentials.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/structs.hpi -L http://mirrors.jenkins-ci.org/plugins/structs/latest/structs.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/git-client/latest/git-client.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/scm-api.hpi -L http://mirrors.jenkins-ci.org/plugins/scm-api/latest/scm-api.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/mailer.hpi -L http://mirrors.jenkins-ci.org/plugins/mailer/latest/mailer.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/matrix-project.hpi -L http://mirrors.jenkins-ci.org/plugins/matrix-project/latest/matrix-project.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/workflow-step-api.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-step-api/latest/workflow-step-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/workflow-scm-step.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-scm-step/latest/workflow-scm-step.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/credentials.hpi -L http://mirrors.jenkins-ci.org/plugins/credentials/latest/credentials.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/icon-shim.hpi -L http://mirrors.jenkins-ci.org/plugins/icon-shim/latest/icon-shim.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/authentication-tokens.hpi -L http://mirrors.jenkins-ci.org/plugins/authentication-tokens/latest/authentication-tokens.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/docker-commons.hpi -L http://mirrors.jenkins-ci.org/plugins/docker-commons/latest/docker-commons.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/docker-build-publish.hpi -L http://mirrors.jenkins-ci.org/plugins/docker-build-publish/latest/docker-build-publish.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/token-macro.hpi -L http://mirrors.jenkins-ci.org/plugins/token-macro/latest/token-macro.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/junit.hpi -L http://mirrors.jenkins-ci.org/plugins/junit/latest/junit.hpi

ADD jenkins/com.cloudbees.dockerpublish.DockerBuilder.xml /opt/jenkins/data/com.cloudbees.dockerpublish.DockerBuilder.xml
ADD jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml /opt/jenkins/data/com.cloudbees.jenkins.GitHubPushTrigger.xml

ADD jenkins/jobs/ /opt/jenkins/data/jobs/

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz && tar --strip-components=1 -xvzf docker-17.04.0-ce.tgz -C /usr/local/bin
ADD runjenkins.sh /usr/local/bin/runjenkins

RUN chmod 0755 /usr/local/bin/docker /usr/local/bin/runjenkins

ENV JENKINS_HOME /opt/jenkins/data
EXPOSE 8080
CMD ["/usr/local/bin/runjenkins"]
