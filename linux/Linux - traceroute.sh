#!/bin/bash
# ------------------------------------------------------------


apt-get update -y; apt-get install -y traceroute;

traceroute -m 5 -w 1 -T www.google.com;


# ------------------------------------------------------------