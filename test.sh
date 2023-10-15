#!/bin/bash

pushd package

echo Updating File in Package
echo "Before Change - $(date)" > ./lib/dependency.txt
cat ./lib/dependency.txt

echo Repacking
rm -f ./package-1.0.0.tgz
npm pack
popd

pushd consumer
echo Resetting Consumer
rm -rf node_modules
(npm install --force && echo "Install worked") || (echo "Install failed, retry with removing lock" && rm package-lock.json && npm install --force && echo "Install retry worked")

echo Installed Dependency contains
cat ./node_modules/package/lib/dependency.txt
popd


pushd package
echo Updating File in Package a second time
echo "After Change - $(date)" > ./lib/dependency.txt
cat ./lib/dependency.txt

echo Repacking
rm -f ./package-1.0.0.tgz
npm pack 
popd

pushd consumer
echo Reinstalling second time
rm -rf node_modules
(npm install --force && echo "Install worked") || (echo "Install failed, retry with removing lock" && rm package-lock.json && npm install --force && echo "Install retry worked")

echo Installed Dependency contains
cat ./node_modules/package/lib/dependency.txt
popd

echo Manually cleaning cache
npm cache clean --force

pushd consumer
echo Reinstalling third time
rm -rf node_modules
(npm install --force && echo "Install worked") || (echo "Install failed, retry with removing lock" && rm package-lock.json && npm install --force && echo "Install retry worked")

echo Installed Dependency contains
cat ./node_modules/package/lib/dependency.txt
popd
