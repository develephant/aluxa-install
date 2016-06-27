default['letsencrypt']['email'] = 'email@domain.com'

default['letsencrypt']['domain'] = "#{node['aluxa']['host']}"

default['letsencrypt']['ssl_cert'] = "/etc/letsencrypt/live/#{node['aluxa']['host']}/fullchain.pem"
default['letsencrypt']['ssl_key'] = "/etc/letsencrypt/live/#{node['aluxa']['host']}/privkey.pem"
default['letsencrypt']['ssl_trusted'] = "/etc/letsencrypt/live/#{node['aluxa']['host']}/chain.pem"
