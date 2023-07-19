# Intro

This is a personalization of the [ducan-bayne's](https://gitlab.com/duncan-bayne/freebsd-setup) work on based

freebsd-setup is a collection of scripts designed to be run on a MacBookPro 8.1 with 13.2-STABLE installation.  

The end result is a Xmonad environment with Emacs, NeoVim etc. that also works well for Jails for Web navigation

## Installation
1. Perform an installation of FreeBSD 13.0:
    1. Install
        * doc, 
        * lib32, 
        * ports, 
        * src.
    2. Create an Auto (ZFS) filesystem.
    3. Choose to start 
        * sshd, 
        * ntpd, 
        * powerd and 
        * dumpdev on start.
    4. As a security precaution, choose:
        * clear ~/tmp~ on start, 
        * randomise PIDs.
    5. Finally, install the FreeBSD Handbook.
2. Once booted, as root:
    1. Configure the network by:
    ```bash
        bsdconfig
    ```
    2. Install git with:
    ```bash
        pkg install -y git
    ```
    3. Clone this repo
    ```bash
        cd /root 
        git clone https://github.com/carlosalbertofilho/mkFreebsdServer
        cd /mkFreebsdServer
    ```
3. Compile and Install Person Kernel
    1. Build the custom kernel
    ```bash
        ./install.sh
    ```
    the system will restart after that!
    2. Build and Install the new word
    ```bash
        ./install.sh
    ```
    the system will restart after that!
    3. Config and install packager
    ```bash
        ./install.sh
    ```
    the system done!