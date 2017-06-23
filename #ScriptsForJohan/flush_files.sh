#!/bin/bash

scp -o StrictHostKeyChecking=no  -r output s0139858@student.mosaic.uantwerpen.be:~/out/$(hostname) || exit 1
rm output/*
