#!/bin/bash

PREFIX=/usr/local
DESTDIR=$HOME/opt

export PATH=${DESTDIR}${PREFIX}/bin:$PATH
export LIBRARY_PATH=${DESTDIR}${PREFIX}/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=${DESTDIR}${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH


