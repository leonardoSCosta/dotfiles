#!/bin/sh

sudo apt install flex bison

git clone https://github.com/doxygen/doxygen.git ;
cd doxygen ;
mkdir build;
cd build;
cmake -G "Unix Makefiles" ..;
make;
sudo make install;

sudo apt install doxygen-gui;
