#!/bin/bash

# var
BLOG_1="non-stop-a.internal.internal"
BLOG_2="non-stop-a.internal.internal"
BLOG_1_IMG_NAME="blog-1-img"
BLOG_2_IMG_NAME="blog-2-img"

#rm&rmi
figlet flush container & Images
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi -f $(sudo docker images -q)

#BUILD    
figlet BUILD
sudo docker build -t $BLOG_1_IMG_NAME -f cron-1/Dockerfile cron-1
sudo docker build -t $BLOG_2_IMG_NAME -f cron-2/Dockerfile cron-2
sudo docker build -t blog-lb -f lb/Dockerfile lb


#DOCKER NETWORK
figlet NETWORK
figlet create network
sudo docker network create -d bridge blog-net



#RUN
figlet RUN
sudo docker run -d --name $BLOG_1 -p 8001:80 --network blog-net $BLOG_1_IMG_NAME
sudo docker run -d --name $BLOG_2 -p 8002:80 --network blog-net $BLOG_2_IMG_NAME
sudo docker run -d --name blog-lb-1 -p 8003:80 blog-lb


figlet PS
sudo docker ps

sl -alF
