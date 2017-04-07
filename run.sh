docker image rm -f my_ci
docker build -t my_ci .

docker rm -f my_ci

docker run -d \
-e DOCKERHUB_ID=somkiat \
-e DOCKERHUB_EMAIL=somkiat.p@gmail.com \
-e GITHUB_ID=up1 \
-p 8080:8080 \
--name my_ci my_ci
