#!/bin/bash

# Function to display the menu
display_menu() {
  clear
  echo "=============================="
  echo "          MENU OPTIONS         "
  echo "=============================="
  echo "1. Install Docker and Docker-compose"
  echo "2. Install Caddy Server + Portainer CE + Wireguard Server"
  echo "3. Option 3"
  echo "q. Quit"
  echo "=============================="
  echo
  echo "Enter your choice (1-3) or 'q' to quit:"
}

# Function to handle option 1
handle_option1() {
  echo "Installing Docker and Docker-compose..."
  sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt-cache policy docker-ce
  sudo apt install docker-ce -y
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo "Check if Docker & Docker-Compose is installed"
  sudo docker --version && docker-compose --version
  read -p "Installation complete. Press enter to leave"
}

# Function to handle option 2
handle_option2() {
  echo "Install Caddy Server + Portainer CE + Wireguard Server... "
  sudo docker volume create --name=caddy_data &&
    sudo mkdir ~/initial-ubuntu &&
    sudo mkdir ~/initial-ubuntu/caddy &&
    sudo mkdir ~/initial-ubuntu/portainer &&
    sudo mkdir ~/initial-ubuntu/wg &&
    sudo nano ~/initial-ubuntu/caddy/Caddyfile &&
    sudo wget https://raw.githubusercontent.com/hophamlam/initial-ubuntu/main/caddy/docker-compose.yml -P ~/initial-ubuntu/ &&
    sudo nano ~/initial-ubuntu/docker-compose.yml &&
    sudo docker compose -f ~/initial-ubuntu/docker-compose.yml up -d
  read -p "Press enter to continue"
}

# Function to handle option 3
handle_option3() {
  echo "Installing Option 3..."

  read -p "Press enter to continue"
}

# Main script logic
while true; do
  display_menu
  read -r choice

  case $choice in
  1)
    handle_option1
    ;;
  2)
    handle_option2
    ;;
  3)
    handle_option3
    ;;
  q | Q)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please try again."
    read -p "Press enter to continue"
    ;;
  esac
done