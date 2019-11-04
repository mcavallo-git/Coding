#!/bin/bash

curl -ssL "https://sync.mcavallo.com/sh?$(date +'%s.%N')" | bash;
