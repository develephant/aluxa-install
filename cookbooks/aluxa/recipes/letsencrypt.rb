###############################################################################
# Let's Encrypt - certbot
###############################################################################
remote_file '/usr/local/bin/certbot-auto' do
  source 'https://dl.eff.org/certbot-auto'
  owner 'root'
  group 'root'
  mode '0776'
end

cron 'check for renew' do
  minute '17'
  hour '3'
  day '*'
  command "/usr/local/bin/certbot-auto renew -t --agree-tos --quiet"
end

# bash 'run letsencrypt' do
#   cwd '/usr/local/bin'
#   code <<-EOF
#     export ASSUME_YES=1
#     ./certbot-auto certonly -q -t --standalone --agree-tos --email #{node['letsencrypt']['email']} -d #{node['letsencrypt']['domain']}
#   EOF
# end
