#!/bin/bash

### Kill the previous container if it exists
docker kill robogals
docker rm robogals

### Builds a docker container
docker build . -t robogals
docker run -i -p 5000:5000 --name robogals -td robogals 