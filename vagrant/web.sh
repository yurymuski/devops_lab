#!/bin/bash


sudo yum install httpd -y;
sudo yum install -y httpd-devel.x86_64;
cd /usr/local/;
sudo mkdir mod_jk;
cd mod_jk/;
sudo wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz;
sudo gzip -d tomcat-connectors-1.2.41-src.tar.gz;
sudo tar xvf tomcat-connectors-1.2.41-src.tar ;
cd tomcat-connectors-1.2.41-src/native/;
sudo ./configure --with-apxs=/usr/sbin/apxs;
sudo make && sudo make install;
sudo cp -f /vagrant/sources/httpd.conf /etc/httpd/conf/httpd.conf;
sudo cp -f /vagrant/sources/workers.properties /etc/httpd/conf/workers.properties;
sudo service httpd start;
