#!/bin/bash
echo "Prepare CQ Source Code ZIPs for Version $1"
rm -f gradle-wrapper-scripts.zip
rm -f gradle-wrapper-sourcecode.zip
rm -rf gradle
BASEDIR="$(pwd)"
TAG="$1"
if [[ $TAG == [0-9]\.[0-9] ]] ; then TAG="$TAG.0"; fi
cd $BASEDIR/sample
./gradlew wrapper --gradle-version $1
./gradlew wrapper --gradle-version $1
zip $BASEDIR/gradle-wrapper-scripts.zip gradlew gradlew.bat gradle/wrapper/gradle-wrapper.properties
cd ..
git clone --branch "v$TAG" --depth 1 https://github.com/gradle/gradle.git
cd $BASEDIR/gradle/subprojects/wrapper/src/main/java/
zip $BASEDIR/gradle-wrapper-sourcecode.zip -r .
cd $BASEDIR/gradle/subprojects/wrapper/
zip $BASEDIR/gradle-wrapper-sourcecode.zip build.gradle.kts
cd $BASEDIR