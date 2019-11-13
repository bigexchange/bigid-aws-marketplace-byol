#!/bin/bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
if yum -h &>/dev/null; then
    sudo yum -y update &&\
    sudo yum -y install docker &&\
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&\
    sudo chmod +x /usr/local/bin/docker-compose &&\
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose >/dev/null
else
    sudo apt -y update &&\
    sudo apt -y install apt-transport-https ca-certificates curl software-properties-common &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&\
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&\    
    sudo apt -y update &&\
    sudo apt -y install docker-ce &&\
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&\
    sudo chmod +x /usr/local/bin/docker-compose &&\
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose >/dev/null
fi
sudo usermod -aG docker $(whoami)
sudo service docker restart >/dev/null
