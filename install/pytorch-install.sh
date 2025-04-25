#!/bin/bash
source $HOME/.tmp_install/scripts/functions.sh

try_update_apt
try_install python3 
try_install python3-pip
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

info "PyTorch installed successfully."
info "Cuda Support: $(python3 -c 'import torch; print(torch.cuda.is_available())')"
