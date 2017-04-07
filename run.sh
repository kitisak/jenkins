docker build -t test1 .

docker rm -f test

docker run -d \
-e DOCKERHUB_ID=somkiat \
-e DOCKERHUB_EMAIL=somkiat.p@gmail.com \
-e GITHUB_ID=up1 \
-p 80:8080 \
--name test test1
