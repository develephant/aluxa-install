###############################################################################
# Self-signed certificates
###############################################################################
directory node['certs']['tmp']

bash 'create self-signed certs' do
  cwd node['certs']['tmp']
  code <<-EOF
  openssl genrsa -des3 -passout pass:x -out tmp.pass.key 2048
  openssl rsa -passin pass:x -in tmp.pass.key -out #{node['certs']['name']}.key

  rm tmp.pass.key

  openssl req -new -key #{node['certs']['name']}.key -out tmp.csr \
    -subj "/C=#{node['certs']['country']}/ST=#{node['certs']['state']}/L=#{node['certs']['city']}/O=#{node['certs']['org']}/OU=#{node['certs']['org_unit']}/CN=#{node['certs']['domain']}"

  openssl x509 -req -days 365 -in tmp.csr -signkey #{node['certs']['name']}.key -out #{node['certs']['name']}.crt

  chmod 0644 #{node['certs']['name']}.crt
  chmod 0644 #{node['certs']['name']}.key

  mv #{node['certs']['name']}.crt #{node['certs']['dest']}/.
  mv #{node['certs']['name']}.key #{node['certs']['dest']}/.
  EOF
end

directory node['certs']['tmp'] do
  action :delete
  recursive true
end
