#!/usr/bin/bash

tee /etc/apt/sources.list.d/xenial.list > /dev/null <<EOF 
deb http://dk.archive.ubuntu.com/ubuntu/ xenial main 
deb http://dk.archive.ubuntu.com/ubuntu/ xenial universe 
deb http://dk.archive.ubuntu.com/ubuntu/ xenial-updates universe 
EOF

apt-get update && apt-get install -y libmysqlclient20 libmysqlclient-dev && rm -rf /var/lib/apt/lists/*
