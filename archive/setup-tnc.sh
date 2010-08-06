#!/bin/sh

if [ -z "$JAVA_HOME" ]; then
   JAVA_HOME=/usr/lib/jvm/java-6-sun/
fi
export JAVA_HOME;

if [ -z "$TOMCAT_HOME"]; then
   TOMCAT_HOME=/lifeoptions/apps/tomcat
fi

apt-get install libapr1-dev libssl-dev build-essential

cd /tmp
tar -xzf ${TOMCAT_HOME}/bin/tomcat-native.tar.gz

dir=`find -maxdepth 1 -type d -name "tomcat-native*"`

cd $dir/jni/native

./configure --with-apr=/usr && make && make install

