#!/bin/bash

cleanup() {
    rm -rf "$HOME/.tmp_install"
    exit 1
}

trap cleanup SIGINT SIGTERM
trap cleanup EXIT

sudo apt update && sudo apt install git -y;
git clone https://github.com/hari-robotics/common-tools-onekey-install.git ~/.tmp_install;

echo "-------------------------------------"
echo "1) Install Acados"
echo "2) Install Casadi"
echo "3) Install CUDA 12.8"
echo "4) Install G2O"
echo "5) Install Pytorch"
echo "6) Install ROS Humble"
echo "q) Quit"
echo "-------------------------------------"

read -t 0.1 -n 10000 discard 2>/dev/null
read -p "Please choose a number to execute: " choice

case $choice in
    1)
        bash ~/.tmp_install/acados-install.sh
        ;;
    2)
        bash ~/.tmp_install/casadi-install.sh
        ;;
    3)
        bash ~/.tmp_install/cuda128-install.sh
        ;;
    4)
        bash ~/.tmp_install/g2o-install.sh
        ;;
    5)
        bash ~/.tmp_install/pytorch-install.sh
        ;;
    6)
        bash ~/.tmp_install/ros-humble-install.sh
        ;;
    q|Q)
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting..."
        ;;
esac