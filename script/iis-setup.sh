#!/usr/bin/env bash

export dir=/usr/scratch/tokyo/mperotti/processor/temp/rivec/deps/install/glib
export LD_LIBRARY_PATH=$dir/lib64:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$dir/lib64/pkgconfig:$PKG_CONFIG_PATH
export PATH=$dir/bin:$PATH
