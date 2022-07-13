#!/bin/bash
# ------------------------------------------------------------


apt-get update -y; apt-get install -y traceroute;

traceroute --max-hops=30 --wait=1 --tcp 'example.com';


# ------------------------------------------------------------