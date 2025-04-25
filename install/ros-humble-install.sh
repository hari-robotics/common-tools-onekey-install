#!/bin/bash
# update locales
source $HOME/.tmp_install/scripts/functions.sh

try_install locales

if sudo locale-gen en_US en_US.UTF-8 > /dev/null 2>&1 & PID=$!
    while kill -0 $PID 2>/dev/null; do
        for c in / - \\ \|; do
            echo -ne "\rgenerating locales $c"
            sleep 0.1
        done
    done
then
    echo " Done"
else
    echo " Failed"
    error "locale-gen failed, please check your internet connection and try again."
    echo "Exiting..."
    exit 1
fi

if sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 > /dev/null 2>&1 & PID=$!
    while kill -0 $PID 2>/dev/null; do
        for c in / - \\ \|; do
            echo -ne "\rupdating locales $c"
            sleep 0.1
        done
    done
then
    echo " Done"
else
    echo " Failed"
    error "update-locale failed, please check your internet connection and try again."
    echo "Exiting..."
    exit 1
fi

export LANG=en_US.UTF-8

# add ROS 2 repository
try_install software-properties-common
try_add_apt_repository universe

try_update_apt
try_install curl

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ROS 2 Humble
try_update_apt
try_install ros-humble-desktop
try_install ros-dev-tools 
try_install python3-rosdep
try_install python3-rosinstall
try_install python3-rosinstall-generator
try_install python3-wstool
try_install build-essential

if sudo rosdep init > /dev/null 2>&1 & PID=$!
    while kill -0 $PID 2>/dev/null; do
        for c in / - \\ \|; do
            echo -ne "\rInitializing rosdep $c"
            sleep 0.1
        done
    done
then
    echo " Done"
else
    echo " Failed"
    error "rosdep init failed, please check your internet connection and try again."
    echo "Exiting..."
    exit 1
fi

if rosdep update > /dev/null 2>&1 & PID=$!
    while kill -0 $PID 2>/dev/null; do
        for c in / - \\ \|; do
            echo -ne "\rUpdating rosdep $c"
            sleep 0.1
        done
    done
then
    echo " Done"
else
    echo " Failed"
    error "rosdep updating failed, please check your internet connection and try again."
    echo "Exiting..."
    exit 1
fi

echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
info "ROS Humble Installation Complete"