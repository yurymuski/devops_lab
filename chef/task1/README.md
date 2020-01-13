# chef_courses
download and install chef client  
https://downloads.chef.io/chef-client/redhat/  
and chef dk  
https://downloads.chef.io/chef-dk/redhat/  
  
  
cd ~/chef_cookbooks/nginx/  
bersks init .  
yum install git  
berks init   
berks package  
tar -xf /root/chef_cookbooks/nginx/cookbooks-1473757980.tar.gz -C /root/  
cd ~/cookbooks/  
cp -rf ./ ~/chef_cookbooks/  
  
Edit  
[/root/.chef/solo.rb](solo.rb)  
[/root/.chef/runlist.json](runlist.json)  
  
  
chef-solo -c /root/.chef/solo.rb  
service nginx status => OK  
