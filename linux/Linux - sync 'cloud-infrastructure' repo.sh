#!/bin/bash

curl -sL"https://sync.mcavallo.com/$(date +'%N').sh" | sudo bash -s -- --all;
