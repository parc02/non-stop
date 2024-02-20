#!/bin/bash

sudo docker build -t blog-a -f cron-1/Dockerfile cron-1
sudo docker run -d --name blog-a-1 -p 8001:80 blog-a

sl

sudo docker ps
