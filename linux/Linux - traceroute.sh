#!/bin/bash
# ------------------------------------------------------------


apt-get update -y; apt-get install -y traceroute;

traceroute 'example.com';

traceroute --max-hops=5 --wait=1 --tcp 'example.com';


# ------------------------------------------------------------