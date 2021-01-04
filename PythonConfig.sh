#!/bin/sh
pip3 install jedi flake8 autopep8 matplotlib testresources imutils dlib
pip3 install --upgrade tensorflow

#sudo apt install -y libcudart10.1 libcublas10 libcublaslt10 libcufft10 libcurand10 libcusolver10 libcusparse10
sudo apt install nvidia-cuda-toolkit
