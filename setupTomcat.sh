#!/bin/sh

echo "Starting Setup"

apt-get update

apt-get install default-jdk

apt-get install tomcat8

apt-get install tomcat8-docs tomcat8-examples tomcat8-admin

systemctl restart tomcat8