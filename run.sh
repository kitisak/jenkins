WAR_PATH=/Users/somkiat/data/training/give-and-take/war
mkdir -p $WAR_PATH
#docker image rm -f my_jenkins
docker build -t my_jenkins .

CONTAINER_JENKINS=my_jenkins
docker stop $CONTAINER_JENKINS
docker rm $CONTAINER_JENKINS

docker run -d \
-e DOCKERHUB_ID=somkiat \
-e DOCKERHUB_EMAIL=somkiat.p@gmail.com \
-e GITHUB_ID=up1 \
-p 8080:8080 \
--restart always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $WAR_PATH:/opt/jenkins/data/www \
--name $CONTAINER_JENKINS my_jenkins

CONTAINER_TOMCAT=webserver
docker stop $CONTAINER_TOMCAT
docker rm $CONTAINER_TOMCAT

docker container run -d --name $CONTAINER_TOMCAT \
 -p 80:8080 \
 -v $WAR_PATH:/usr/local/tomcat/webapps \
 --link dbserver \
 tomcat:8.0.42-jre8-alpine

CONTAINER_MYSQL=dbserver
docker stop $CONTAINER_MYSQL
docker rm $CONTAINER_MYSQL

docker run  -d --name dbserver \
 -e MYSQL_ROOT_PASSWORD=123456 \
 -e MYSQL_USER=dev \
 -e MYSQL_PASSWORD=123456
 -e MYSQL_DATABASE=ewallet \
 mysql:5.7.17
