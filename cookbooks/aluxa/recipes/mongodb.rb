###############################################################################
# MongoDB
###############################################################################
bash 'get repo key' do
  cwd node[:core][:root]
  code <<-EOF
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  EOF
end

file '/etc/apt/sources.list.d/mongodb-org-3.2.list' do
  content "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse"
end

apt_update 'force update' do
  action :update
end

package ['mongodb-org','mongodb-org-server','mongodb-org-shell','mongodb-org-mongos','mongodb-org-tools']
