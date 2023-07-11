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
    ![bsdconfig](./img/bsdconfig_network.png)
    2. Install git with:
    ```bash
        pkg install -y git
    ```
    3. Clone this repo
    ```bash
        cd /root && git clone https://github.com/carlosalbertofilho/mkFreebsdDesktop
    ```
3. Compile and Install Person Kernel
    1. Build the custom kernel
    ```bash
        ./kernel-script/010-build-kernel.sh
    ```
    the system will restart after that!
    2. Install the custon kernel
    ```bash
        ./kernel-script/020-install-kernel.sh
    ```
    the system will restart after that!
    3. Install world for custon kernel
    ```bash
        ./kernel-script/030-install-world.sh
    ```
    the system will restart after that!