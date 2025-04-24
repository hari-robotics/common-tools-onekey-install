#!/bin/bash

chmod +x ./acados-install.sh ./casadi-install.sh ./cuda128-install.sh ./g2o-install.sh ./pytorch-install.sh ./ros-humble-install.sh

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
        ./acados-install.sh
        break
        ;;
    2)
        ./casadi-install.sh
        break
        ;;
    3)
        ./cuda128-install.sh
        break
        ;;
    4)
        ./g2o-install.sh
        break
        ;;
    5)
        ./pytorch-install.sh
        break
        ;;
    6)
        ./ros-humble-install.sh
        break
        ;;
    q|Q)
        exit 0
        ;;
    *)
        echo "Invalid choice. Please try again."
        ;;
esac