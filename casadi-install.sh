sudo apt install gcc g++ gfortran git cmake liblapack-dev pkg-config --install-recommends -y
sudo apt install patch wget libmetis-dev -y
sudo apt install ipython3 python3-dev python3-numpy python3-scipy python3-matplotlib --install-recommends -y
sudo apt install swig --install-recommends -y

mkdir ~/lib
cd ~/lib
git clone https://github.com/coin-or/Ipopt.git
cd Ipopt
echo 'export IPOPTDIR="/home/$USER/lib/Ipopt"' >> ~/.bashrc
export IPOPTDIR="/home/$USER/lib/Ipopt"
mkdir $IPOPTDIR/build
cd $IPOPTDIR/build
$IPOPTDIR/configure
make -j$(nproc --all)
sudo make install

cd ~/lib
git clone https://github.com/casadi/casadi.git -b main casadi
cd casadi
mkdir build
cd build
cmake -DWITH_PYTHON=ON -DWITH_IPOPT=ON -DWITH_OPENMP=ON -DWITH_THREAD=ON ..
make -j$(nproc --all)
sudo make install