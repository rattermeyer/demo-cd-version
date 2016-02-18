#!/bin/sh
. ./job.properties

# increment build number and recreate properties file
BUILD_NUMBER=$((BUILD_NUMBER+1))
echo "BUILD_NUMBER=${BUILD_NUMBER}" > job.properties
echo "GIT_URL=${GIT_URL}" >> job.properties
rm -fr workspace
git clone ${GIT_URL} workspace

cd workspace/independent-utility
GIT_COMMIT_SHORT=`git rev-parse --short HEAD`
echo "GIT_COMMIT=${GIT_COMMIT_SHORT}"

export TAGVERSION="${BUILD_NUMBER}-${GIT_COMMIT_SHORT}"
mvn -Pcd-version validate
mvn clean install

cd -
