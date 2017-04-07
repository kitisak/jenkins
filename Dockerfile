FROM openjdk:8u121-jdk
MAINTAINER SCK Team somkiat@scrum123.com
RUN apt-get update -qq
RUN apt-get install -qqy ca-certificates curl git-core maven

RUN mkdir -p /opt/jenkins/data/plugins
RUN curl -sf -o /opt/jenkins/jenkins.war -L http://mirrors.jenkins.io/war-stable/1.651.3/jenkins.war
RUN curl -sf -o /opt/jenkins/data/plugins/ssh-credentials.hpi -L http://mirrors.jenkins-ci.org/plugins/ssh-credentials/latest/ssh-credentials.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/structs.hpi -L http://mirrors.jenkins-ci.org/plugins/structs/latest/structs.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/bouncycastle-api.hpi -L http://mirrors.jenkins-ci.org/plugins/bouncycastle-api/latest/bouncycastle-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/ssh-agent.hpi -L http://mirrors.jenkins-ci.org/plugins/ssh-agent/latest/ssh-agent.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/credentials.hpi -L http://mirrors.jenkins-ci.org/plugins/credentials/latest/credentials.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/git-client/latest/git-client.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/scm-api.hpi -L http://mirrors.jenkins-ci.org/plugins/scm-api/latest/scm-api.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/mailer.hpi -L http://mirrors.jenkins-ci.org/plugins/mailer/latest/mailer.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/matrix-project.hpi -L http://mirrors.jenkins-ci.org/plugins/matrix-project/latest/matrix-project.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/workflow-step-api.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-step-api/latest/workflow-step-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/workflow-scm-step.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-scm-step/latest/workflow-scm-step.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/icon-shim.hpi -L http://mirrors.jenkins-ci.org/plugins/icon-shim/latest/icon-shim.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/authentication-tokens.hpi -L http://mirrors.jenkins-ci.org/plugins/authentication-tokens/latest/authentication-tokens.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/token-macro.hpi -L http://mirrors.jenkins-ci.org/plugins/token-macro/latest/token-macro.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/junit.hpi -L http://mirrors.jenkins-ci.org/plugins/junit/latest/junit.hpi

RUN curl -sf -o /opt/jenkins/data/plugins/claim.hpi -L http://mirrors.jenkins-ci.org/plugins/claim/latest/claim.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/view-job-filters.hpi -L http://mirrors.jenkins-ci.org/plugins/view-job-filters/latest/view-job-filters.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/cloudbees-folder.hpi -L http://mirrors.jenkins-ci.org/plugins/cloudbees-folder/latest/cloudbees-folder.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/groovy-postbuild.hpi -L http://mirrors.jenkins-ci.org/plugins/groovy-postbuild/latest/groovy-postbuild.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/build-failure-analyzer.hpi -L http://mirrors.jenkins-ci.org/plugins/build-failure-analyzer/latest/build-failure-analyzer.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/build-monitor-plugin.hpi -L http://mirrors.jenkins-ci.org/plugins/build-monitor-plugin/latest/build-monitor-plugin.hpi

ADD jenkins/config.xml /opt/jenkins/data/config.xml
ADD jenkins/jobs/ /opt/jenkins/data/jobs/
ADD runjenkins.sh /usr/local/bin/runjenkins

RUN chmod 0755 /usr/local/bin/runjenkins
RUN mkdir -p /opt/jenkins/data/www

ENV JENKINS_HOME /opt/jenkins/data
EXPOSE 8080
CMD ["/usr/local/bin/runjenkins"]
