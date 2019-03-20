#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Update Source List
include_recipe "apt"

apt_update "update" do
  action :update
end

bash "jre-install" do
  code "sudo apt-get install default-jre -y"
end

bash "wget_get" do
  code "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add"
end

package "apt-transport-https" do
  action :install
end

bash "elastic_get" do
  code "echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list"
end

apt_update "update" do
  action :update
end

package "elasticsearch" do
  action :install
end

file "/etc/elasticsearch/elasticsearch.yml" do
  action :delete
end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml"
  notifies :restart, "service[elasticsearch]"
end

link '/etc/elasticsearch/elasticsearch.yml' do
  to 'elasticsearch.yml'
end


service "elasticsearch" do
  action [:enable, :start]
end






# # Install java runtime environment.
# package "openjdk-8-jdk" do
#   action :install
# end
#
# # Install transport-https
# package 'apt-transport-https' do
#    action :install
#  end
#
#  # Add elasticsearch key
#  bash "add-key" do
#    code "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -"
#  end
#
# # Get elasticsearch
#  apt_repository "elasticsearch" do
#    uri "https://artifacts.elastic.co/packages/5.x/apt"
#    action :add
#  end
#
#  # Update Source List
#  apt_update "update" do
#    action :update
#  end
#
#  # Install elasticsearch
# package "elasticsearch" do
#   action :install
# end
#
# # Replace config File
# file("/etc/elasticsearch/elasticsearch.yml") do
#   action :delete
# end
#
# template("/etc/elasticsearch/elasticsearch.yml") do
#   source "elasticsearch.yml.erb"
# end
#
# # Start elasticsearch
# service "elasticsearch" do
#   action [:enable, :start]
# end
