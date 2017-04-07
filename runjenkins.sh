#!/bin/bash
if [[ -z $GITHUB_ID ]] ; then
	echo "ERROR: GITHUB_ID environment variables must be set."
	exit 1
fi

find /opt/jenkins/data -type f | xargs sed -i -e "s/@@GHUSER@@/${GITHUB_ID}/g"
java -jar /opt/jenkins/jenkins.war
