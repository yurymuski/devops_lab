#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#adding jenkins repo
execute 'adding jenkins repo' do
  command "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  not_if { File.exist? "/etc/yum.repos.d/jenkins.repo" } 
end


include_recipe "java"
include_recipe "tomcat"
include_recipe "nginx"

#installing required packages
package ["git", "unzip", "jenkins"]

#installing custom jenkins port (from Role Attributes) 
template '/etc/sysconfig/jenkins' do
  source "jenkins.erb"
  mode 0700
  owner 'root'
  group 'root'
  variables({
    'jenkins_port' => node['jenkins_port']
  })
end


#adding jobs and plugins to jenkins
remote_directory "/var/lib/jenkins" do
source 'jenkins'
owner 'jenkins'
group 'jenkins'
mode 0755
action :create
end


#adding jenkins user to tomcat group to deploy app
group 'tomcat' do
  action :modify
  members 'jenkins'
  append true
end


execute 'jenkins home chown' do
  command "chown -R jenkins:jenkins /var/lib/jenkins"
end


#start jenkins service
service 'jenkins' do
  action [ :enable, :start ]
end

