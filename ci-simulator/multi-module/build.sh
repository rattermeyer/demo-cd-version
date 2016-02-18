#!/bin/sh
. ./job.properties

# increment build number and recreate properties file
BUILD_NUMBER=$((BUILD_NUMBER+1))
echo "BUILD_NUMBER=${BUILD_NUMBER}" > job.properties
echo "GIT_URL=${GIT_URL}" >> job.properties
rm -fr workspace
git clone ${GIT_URL} workspace

cd workspace/multi-module
GIT_COMMIT_SHORT=`git rev-parse --short HEAD`
echo "GIT_COMMIT=${GIT_COMMIT_SHORT}"

export TAGVERSION="${BUILD_NUMBER}-${GIT_COMMIT_SHORT}"

# setting the new version. 
# Attention: needs -N switch to handle multi module project correctly
mvn -Pcd-version -N validate
mvn clean install

cd -
