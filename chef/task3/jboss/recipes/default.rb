#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user node['jboss']['user'] do
  home node['jboss']['home']
  system true
  shell '/bin/bash'
end

group node['jboss']['group'] do
  action :create
end



remote_file '/tmp/jboss.zip' do
  source node['jboss']['url']
  owner node['jboss']['user']
  group node['jboss']['group']
  mode '0755'
  action :create
end

include_recipe "java"

package 'unzip' do
  action :install
end


execute 'extract jboss' do
  command "unzip /tmp/jboss.zip -d #{node['jboss']['path']}"
  not_if { ::File.directory? "#{node['jboss']['home']}" }
end


remote_file '/tmp/testweb.zip' do
  source node['jboss']['app_url']
  owner node['jboss']['user']
  group node['jboss']['group']
  mode '0755'
  action :create
end

# bash 'extract app' do
# code 'unzip /tmp/testweb.zip -d /opt/jboss-6.1.0.Final/server/default/deploy'
# end

execute 'extract app' do
  command "unzip -o /tmp/testweb.zip -d #{node['jboss']['app_dir']}"
end


template '/etc/init.d/jboss' do
  source "jboss.erb"
  mode 0775
  owner 'root'
  group 'root'
  variables({
    'user' => node['jboss']['user'],
    'jboss_home' => node['jboss']['home']
  })
end

template "#{node['jboss']['app_dir']}/hudson/hudson.xml" do
  source "hudson.erb"
  mode 0775
  variables({
    'engine' => data_bag_item('app', 'hudson')['engine']
  })
end


execute 'jboss_folder_chown' do
  command "chown -R #{node['jboss']['user']}:#{node['jboss']['group']} #{node['jboss']['home']}"
end


service 'jboss' do
  init_command "/etc/init.d/jboss"
  supports :restart => true, :status => false, :stop => true, :start => true
  action [ :enable, :start ]
end


