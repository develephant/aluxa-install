#
# Cookbook Name:: aluxa
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
apt_update 'update cache daily'

#download dirs
directory '/tmp/aluxa'

# install git
package ['git']


# pull core


git '/tmp/aluxa/core' do


end

#pull lib
git '/tmp/aluxa/lib' do

end
