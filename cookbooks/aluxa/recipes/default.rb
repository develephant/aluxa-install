#
# Cookbook Name:: aluxa
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
apt_update 'update cache daily'

# install git
package 'git'

#download dirs
directory '/tmp/aluxa' do
  owner 'root'
  group 'root'
  mode '775'
end

# pull core
git '/usr/local/aluxa' do
  repository node['aluxa']['repo']
  revision 'master'
  user 'root'
  group 'root'
  action :sync
end
