#!/bin/bash
##Assuming that the dotfiles from startup engineering is already setup
##refer to https://github.com/startup-class/setup.git and 
##see also https://github.com/startup-class/dotfiles for more info
echo "Run this script only once"
echo "If you accidentally ran it more than once then please open the appropriate .bashrc file and remove the additional lines"
source ./dotfiles/.ec2
export BASHRC_LOC=$(readlink -f $HOME/.bashrc)
echo "**********************"
echo "Adding the following line"
echo "source $EC2_CUSTOM/dotfiles/.ec2 >> $BASHRC_LOC"
echo "**********************"
echo "source $EC2_CUSTOM/dotfiles/.ec2" >> $BASHRC_LOC
