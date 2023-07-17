#!/bin/sh
set -e

LOG_FILE=".running.log"

# Execute the 010-build-kernel.sh script
echo "Running 010-build-kernel.sh..."
./kernel-script/010-build-kernel.sh
echo "BUILDKERNEL" >> "$LOG_FILE"

# Reboot the machine
echo "Rebooting the machine..."
reboot -p

# After the machine reboots, check if "BUILDKERNEL" is present in the log file
if grep -q "BUILDKERNEL" "$LOG_FILE"; then
    echo "Continuing with the installation..."
    ./kernel-script/020-install-world.sh
    echo "INSTALLWORD" >> "$LOG_FILE"
else
    echo "Build kernel step failed. Exiting."
    exit 1
fi

# Reboot the machine
echo "Rebooting the machine..."
reboot -p

# After the machine reboots, check if "INSTALLWORD" is present in the log file
if grep -q "INSTALLWORD" "$LOG_FILE"; then
    echo "Continuing with the installation..."
    for subscript in root-scripts/*.sh; do
        echo executing "$subscript";
        $subscript;
    done
    rm -fr "$LOG_FILE"
else
    echo "Build and Install Word step failed. Exiting."
    exit 1
fi