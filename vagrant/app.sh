#!/bin/bash

sudo yum install -y java;
cd /home/vagrant/;
mkdir tomcat;
cd tomcat/;
sudo wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.3/bin/apache-tomcat-8.5.3.tar.gz;
sudo gzip -d apache-tomcat-8.5.3.tar.gz;
sudo tar xvf apache-tomcat-8.5.3.tar ;
sudo mv apache-tomcat-8.5.3 tomcat;
cd /home/vagrant/tomcat/tomcat/bin/;
./startup.sh ;
