#!/bin/bash

#rm&rmi
figlet flush container & Images
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi -f $(sudo docker images -q)

#BUILD    
figlet BUILD
sudo docker build -t blog-a -f cron-1/Dockerfile cron-1
sudo docker build -t blog-b -f cron-2/Dockerfile cron-2
sudo docker build -t blog-lb -f lb/Dockerfile lb

#RUN
figlet RUN
sudo docker run -d --name blog-a-1 -p 8001:80 blog-a
sudo docker run -d --name blog-b-1 -p 8002:80 blog-a
sudo docker run -d --name blog-lb-1 -p 8003:80 blog-lb

#DOCKER NETWORK
figlet NETWORK
sudo docker network rm blog-123
sudo docker network create blog-123
sudo docker network connect blog-123 blog-a-1
sudo docker network connect blog-123 blog-b-1
sudo docker network connect blog-123 blog-lb-1

sudo docker start blog-lb-1
sudo docker network inspect blog-123


figlet PS
sudo docker ps

sl -alF
