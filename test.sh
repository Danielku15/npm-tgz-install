#!/bin/bash

pushd package
echo Updating File in Package
echo "Before Change - $(date)" > ./lib/dependency.txt
echo Repacking
rm -f ./package-1.0.0.tgz
npm pack 
popd

pushd consumer
echo Resetting Consumer
rm -rf node_modules
npm install --force
echo Installed Dependency contains
cat ./node_modules/package/lib/dependency.txt
popd


pushd package
echo Updating File in Package a second time
echo "After Change - $(date)" > ./lib/dependency.txt
echo Repacking
rm -f ./package-1.0.0.tgz
npm pack 
popd

pushd consumer
echo Reinstalling second time
rm -rf node_modules
npm install --force
echo Installed Dependency contains
cat ./node_modules/package/lib/dependency.txt
popd
