#!/bin/bash

# -----Update the packages-----

sudo apt update -y

# -----Install Docker and Add user to the group-----

sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# -----Add user ubuntu to group docker-----

sudo usermod -aG docker ubuntu

# -----Install minikube-----

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 
chmod +x minikube
sudo mv minikube /usr/local/bin/

# -----Install Kubectl-----

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/