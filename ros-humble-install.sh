#!/bin/bash
# update locales
sudo apt update && sudo apt upgrade -y
sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# add ROS 2 repository
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ROS 2 Humble
sudo apt update
sudo apt install ros-dev-tools ros-humble-desktop python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y

echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc

sudo rosdep init
rosdep update