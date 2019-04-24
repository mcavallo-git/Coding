#!/bin/bash

# Solves error: RTNETLINK answers: Cannot assign requested address

sudo ip addr add 192.168.2.1/24 dev eth2;
sudo ip addr add 192.168.0.190/24 dev eth2;

