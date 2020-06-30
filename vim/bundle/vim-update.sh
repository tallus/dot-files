#!/bin/bash
for REPO in $(ls -d */);do
    cd $REPO
    git pull
    cd ../
done

