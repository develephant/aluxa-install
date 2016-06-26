###############################################################################
# ALUXA install
###############################################################################
# pull core
git node['core']['root'] do
  repository node['aluxa']['repo']
  revision 'master'
  user 'root'
  group 'root'
  action :sync
end
###############################################################################
# ALUXA logging
###############################################################################
directory node[:nginx][:log_dir] do
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
  mode '0760'
end

file "#{node[:nginx][:log_file]}" do
  action :touch
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
  mode '0664'
end

###############################################################################
# ALUXA user skills link
###############################################################################
directory node[:core][:skills] do
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
  mode '0755'
end

link '/home/aluxa/skills' do
  to '/usr/local/aluxa/skills'
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
end

###############################################################################
# ALUXA demo skill
###############################################################################
directory '/usr/local/aluxa/skills/hello' do
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
  mode '0744'
end

remote_directory "#{node[:core][:skills]}/hello" do
  source node[:install][:skill_tpl_dir]
  recursive true
  owner 'aluxa'
  group 'aluxa'
  mode '0755'
  files_owner node[:aluxa][:user]
  files_group node[:aluxa][:group]
  files_mode '0664'
end

###############################################################################
# ALUXA server tools
###############################################################################
cookbook_file "#{node[:install][:bin_dir]}/aluxa" do
  source node[:install][:aluxa_bin]
  owner node[:aluxa][:user]
  group node[:aluxa][:group]
  mode '0744'
end

###############################################################################
# ALUXA links
###############################################################################
link "#{node[:install][:bin_dir]}/nginx" do
  to node[:install][:nginx_bin]
  owner 'root'
  group 'root'
  mode '0744'
end

link "#{node[:install][:bin_dir]}/luajit" do
  to node[:install][:luajit_bin]
  owner 'root'
  group 'root'
  mode '0744'
end

link "#{node[:install][:bin_dir]}/luarocks" do
  to node[:install][:luarocks_bin]
  owner 'root'
  group 'root'
  mode '0744'
end
