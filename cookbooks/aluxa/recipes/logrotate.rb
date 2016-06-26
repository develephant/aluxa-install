###############################################################################
# Logrotate scripts
###############################################################################
file '/etc/logrotate.d/aluxa' do
  owner 'root'
  group 'root'
  mode '0644'
  content <<-EOF
/home/aluxa/logs/aluxa.log {
  size 5mb
  copytruncate
  create 0700 aluxa aluxa
  dateext
  rotate 3
  compress
}
  EOF
end
