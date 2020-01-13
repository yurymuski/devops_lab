current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "yury"
client_key               "#{current_dir}/yury.pem"
chef_server_url          "https://chef-serv/organizations/yury-org"
cookbook_path            ["#{current_dir}/../cookbooks"]



