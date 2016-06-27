#
# Cookbook Name:: aluxa
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
apt_update 'update cache daily'

# install git
package 'git'

#download tmp
directory '/tmp/aluxa' do
  owner 'root'
  group 'root'
  mode '775'
end

include_recipe 'aluxa::aluxa_user'
include_recipe 'aluxa::install'
include_recipe 'aluxa::aluxa_server'
include_recipe 'aluxa::mongodb'
# include_recipe 'aluxa::selfsigned'
include_recipe 'aluxa::letsencrypt'
include_recipe 'aluxa::logrotate'
