#!/bin/bash

# docker pull "node:latest";

docker pull "node:10.12.0-stretch"; docker pull "node:10.12.0-slim"; docker pull "node:10.12.0-alpine"; docker pull "node:10.12.0-jessie";

docker images;
