#!/bin/bash

for i in  $(find $(pwd) -maxdepth 1 -type f  -iname '.*')
do
    ln -sv $i ~
done
