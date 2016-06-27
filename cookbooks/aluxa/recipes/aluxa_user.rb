###############################################################################
# Create the `aluxa` admin user
###############################################################################
user node['aluxa']['user'] do
  comment 'Aluxa admin'
  home node['aluxa']['root']
  shell '/bin/bash'
  password node['aluxa']['password']
  manage_home true
end

###############################################################################
# Add `aluxa` to sudo
###############################################################################
group 'sudo' do
  action :modify
  members node['aluxa']['user']
  append true
end
