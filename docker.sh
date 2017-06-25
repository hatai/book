#!/bin/bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common ;
curl -fsSL https://get.docker.com/ | sh;
sudo usermod -aG docker $USER ;

sudo docker build -t bookmanager/elixir . && \
sudo docker run -p 80:80 bookmanager/elixir ;
