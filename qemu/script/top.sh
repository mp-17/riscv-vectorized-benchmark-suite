#!/usr/bin/env bash
cd ..
make qemu-all
cd qemu
./script/create_img.sh
./script/qemu.sh
