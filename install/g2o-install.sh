#!/bin/bash
source $HOME/.tmp_install/scripts/functions.sh

try_install libeigen3-dev
try_install libspdlog-dev
try_install libsuitesparse-dev
try_install qtdeclarative5-dev
try_install qt5-qmake
try_install libqglviewer-dev-qt5

try_mkdir ~/lib
cd ~/lib
git clone https://github.com/RainerKuemmerle/g2o.git g2o
cd g2o
try_mkdir build
cd build
cmake ../
make -j$(nproc --all)
sudo make install

info "g2o installed successfully."