#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#installing packages
package ["tomcat","tomcat-webapps"]

#adding custom port
template '/etc/tomcat/server.xml' do
  source "server.erb"
  mode 0664
  owner 'tomcat'
  group 'tomcat'
  variables({
    'tomcat_port' => node['tomcat_port']
  })
end

#starting service
service 'tomcat' do
  action [ :enable, :restart ]
end



