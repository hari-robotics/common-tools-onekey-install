#!/bin/bash
source $HOME/.tmp_install/scripts/functions.sh

try_mkdir ~/lib
cd ~/lib
git clone https://github.com/acados/acados.git
cd acados
git submodule update --recursive --init

try_mkdir -p build
cd build
cmake -DACADOS_WITH_QPOASES=ON -DACADOS_WITH_OPENMP=ON ..
make -j$(nproc --all)
sudo make install

echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/home/$USER/lib/acados/lib"' >> ~/.bashrc
echo 'export ACADOS_SOURCE_DIR="/home/$USER/lib/acados"' >> ~/.bashrc

info "acados installed successfully."