#!/usr/bin/env bash

# Clean up previous image
rm -f busybox.img

# Create busybox.img and copy initial files
dd if=/dev/zero of=busybox.img bs=1M count=32
mkfs.ext2 -F busybox.img

debugfs -w busybox.img <<EOF
cd /
mkdir bin
mkdir sbin
mkdir etc
mkdir etc/init.d
mkdir dev
mkdir proc
mkdir sys
mkdir tmp
mkdir usr
mkdir mnt
mkdir usr/bin
mkdir usr/sbin
mkdir proc/sys
mkdir proc/kernel
cd bin
write /scratch/mperotti/processor/temp/rivec/deps/busybox/busybox busybox
cd /
ln bin/busybox bin/sh
ln bin/busybox bin/mount
ln bin/busybox bin/mountpoint
ln bin/busybox bin/mkdir
ln bin/busybox sbin/init
cd /
write /scratch/mperotti/processor/temp/rivec/deps/busybox/rootfs/init init
quit
EOF

# Copy the programs if present
apps=("_axpy" "_jacobi-2d" "_canneal" "_blackscholes" "_lavaMD" "_somier" "_streamcluster" "_swaptions" "_particlefilter" "_pathfinder")

# Loop through each script
for name in "${apps[@]}"; do
    script="./${name}.sh"

    # Check if the script exists and is executable
    if [[ -x "$script" ]]; then
        echo
        echo "Executing $script..."
        echo
        "$script"
        echo
    else
        echo "info: $script does not exist or is not executable."
    fi
done
