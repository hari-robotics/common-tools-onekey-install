#!/bin/bash
source $HOME/.tmp_install/scripts/functions.sh

sudo apt install libeigen3-dev libspdlog-dev libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5 -y
mkdir ~/lib
cd ~/lib
git clone https://github.com/RainerKuemmerle/g2o.git g2o
cd g2o
mkdir build
cd build
cmake ../
make -j$(nproc --all)
sudo make install
