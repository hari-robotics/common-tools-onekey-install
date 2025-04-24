#!/bin/bash
sudo apt update
sudo apt install python3 python3-pip -y
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
