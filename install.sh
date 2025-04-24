#!/bin/bash

sudo apt update && sudo apt install git -y
git clone https://github.com/hari-robotics/common-tools-onekey-install.git ~/.tmp_install

echo "-------------------------------------"
echo "1) Install Acados"
echo "2) Install Casadi"
echo "3) Install CUDA 12.8"
echo "4) Install G2O"
echo "5) Install Pytorch"
echo "6) Install ROS Humble"
echo "q) Quit"
echo "-------------------------------------"

read -p "Please choose a number to execute: " choice

case $choice in
    1)
        bash ./.tmp_install/acados-install.sh
        break
        ;;
    2)
        bash ./.tmp_install/casadi-install.sh
        break
        ;;
    3)
        bash ./.tmp_install/cuda128-install.sh
        break
        ;;
    4)
        bash ./.tmp_install/g2o-install.sh
        break
        ;;
    5)
        bash ./.tmp_install/pytorch-install.sh
        break
        ;;
    6)
        bash ./.tmp_install/ros-humble-install.sh
        break
        ;;
    q|Q)
        exit 0
        ;;
    *)
        echo "Invalid choice. Please try again."
        ;;
esac