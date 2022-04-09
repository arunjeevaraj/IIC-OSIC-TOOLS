#!/bin/bash

source scl_source enable gcc-toolset-9

set -x

# Build atalanta
install_atalanta () {
	cd /tmp
	git clone https://github.com/hsluoyz/Atalanta.git atalanta
	cd atalanta
	git checkout 12d405311c3dc9f371a9009bb5cdc8844fe34f90
	make -j$(nproc)
	cp atalanta /usr/local/bin
	cd ..
	cp -R atalanta /usr/local/share
}
install_atalanta

# Build binutils-gold (for Swift)
install_binutils_gold () {
	cd /tmp
	wget https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.xz
	tar xf binutils-2.38.tar.xz
	cd binutils-2.38
	./configure --enable-gold
	make -j$(nproc)
	make install
}
install_binutils_gold

# Install Swift
install_swift () {
	cd /tmp
	wget https://download.swift.org/swift-5.6-release/centos8-$(arch)/swift-5.6-RELEASE/swift-5.6-RELEASE-centos8-$(arch).tar.gz	
	tar xf swift-5.6-RELEASE-centos8-$(arch).tar.gz
	cp -rn swift-5.6-RELEASE-centos8-$(arch)/* /
}
install_swift
