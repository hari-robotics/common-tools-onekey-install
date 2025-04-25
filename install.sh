#!/bin/bash
try_install() {
    local package="$1"
    local display_name="${2:-$package}"

    echo -ne "Trying to install $display_name: "
    if command -v "$package" >/dev/null 2>&1; then
        echo "$display_name is already installed."
        return 0
    fi

    sudo apt install -y "$package" > /dev/null 2>&1 &
    local pid=$!

    local spin='/-\|'
    while kill -0 "$pid" 2>/dev/null; do
        for (( i=0; i<${#spin}; i++ )); do
            echo -ne "\rInstalling $display_name ${spin:$i:1}"
            sleep 0.1
        done
    done

    wait "$pid"  # 等待安装进程完成

    if [ $? -eq 0 ]; then
        echo -e " Installed"
    else
        echo -e " Failed"
        error "Installation failed. Please install $display_name manually."
        exit 1
    fi
}

try_update_apt() {
    if sudo apt update > /dev/null 2>&1 & PID=$!
        while kill -0 $PID 2>/dev/null; do
            for c in / - \\ \|; do
                echo -ne "\rupdating apt source $c"
                sleep 0.1
            done
        done
    then
        echo " Done"
    else
        echo " Failed"
        error "apt source updating failed, please check your internet connection and try again."
        echo "Exiting..."
        exit 1
    fi
}

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

export SCRIPTS_DIR="$HOME/.tmp_install/install"
source $HOME/.tmp_install/scripts/functions.sh

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
            source $SCRIPTS_DIR/acados-install.sh
            ;;
        2)
            source $SCRIPTS_DIR/casadi-install.sh
            ;;
        3)
            source $SCRIPTS_DIR/cuda128-install.sh
            ;;
        4)
            source $SCRIPTS_DIR/g2o-install.sh
            ;;
        5)
            source $SCRIPTS_DIR/pytorch-install.sh
            ;;
        6)
            source $SCRIPTS_DIR/ros-humble-install.sh
            ;;
        q|Q)
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
