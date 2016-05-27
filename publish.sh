#!/bin/bash

./build.sh
cd _site
git add .
git commit -m "Update to blog"
git push 
