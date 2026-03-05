#!/bin/bash
# 1. Update and install Docker
sudo dnf update -y
sudo dnf install -y docker

# 2. Create 2GB Swap file (Safety net for 1GB RAM)
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# 3. Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# 4. Run Memos in Docker
sudo mkdir -p /var/opt/memos
sudo docker run -d \
  --name memos \
  --restart unless-stopped \
  -p 5230:5230 \
  -v /var/opt/memos:/var/opt/memos \
  neosmemo/memos:stable
