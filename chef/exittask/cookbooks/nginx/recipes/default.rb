#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#installing service
package "nginx" do
  action :install
end

#adding virtual conf to nginx
template "/etc/nginx/conf.d/virt.conf" do
  source "virt.erb"
  variables({
  'nginx_port' => node['nginx_port'],
  'jenkins_port' => node['jenkins_port'],
  'tomcat_port' => node['tomcat_port']
})
end

#starting service
service 'nginx' do
  action :start
end
