#!/bin/bash


# apt-get -y install nmap

# yum -y install nmap



nmap -T Aggressive -A -v 127.0.0.1 -p 1-65535;

nmap -T Aggressive -A -v 127.0.0.1 -p 80


nmap -p 443,80 --script http-methods localhost;
nmap -p 443,80 --script http-methods 127.0.0.1;

