#!/bin/bash
source $HOME/.tmp_install/scripts/functions.sh

$SCRIPTS_DIR=$HOME/.tmp_install/install

sudo -v

try_update_apt
try_install git

if git clone https://github.com/hari-robotics/common-tools-onekey-install.git ~/.tmp_install > /dev/null 2>&1 & CLONE_PID=$!
    while kill -0 $CLONE_PID 2>/dev/null; do
        for c in / - \\ \|; do
            echo -ne "\rPulling installation scripts $c"
            sleep 0.1
        done
    done
then
    echo " Done"
else
    echo "Failed"
    error "Please check your internet connection and try again."
    echo "Exiting..."
    exit 1
fi

while true; do
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
            bash $SCRIPTS_DIR/install/acados-install.sh
            break
            ;;
        2)
            bash $SCRIPTS_DIR/install/casadi-install.sh
            break
            ;;
        3)
            bash $SCRIPTS_DIR/install/cuda128-install.sh
            break
            ;;
        4)
            bash $SCRIPTS_DIR/install/g2o-install.sh
            break
            ;;
        5)
            bash $SCRIPTS_DIR/install/pytorch-install.sh
            break
            ;;
        6)
            bash $SCRIPTS_DIR/install/ros-humble-install.sh
            break
            ;;
        q|Q)
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            break
            ;;
    esac
done
