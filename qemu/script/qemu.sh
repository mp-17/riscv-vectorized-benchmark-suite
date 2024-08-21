#!/usr/bin/env bash

qemu=/usr/scratch/tokyo/mperotti/processor/temp/rivec/deps/install/qemu/bin/qemu-system-riscv64
linux=/usr/scratch/tokyo/mperotti/processor/temp/rivec/deps/linux/arch/riscv/boot/Image
busybox=./busybox.img

$qemu -cpu rv64,v=true -machine virt -kernel $linux -append "root=/dev/vda ro console=ttyS0 init=/init" -drive file=$busybox,format=raw,id=hd0,if=none -device virtio-blk-device,drive=hd0 -nographic
