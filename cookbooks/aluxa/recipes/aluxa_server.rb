#nginx
template "#{node[:nginx][:conf]}/nginx.conf" do
  source 'conf/nginx.erb'
  mode '0644'
end

template "#{node[:nginx][:conf]}/aluxa_server.conf" do
  source 'conf/aluxa_server.erb'
  mode '0644'
end
