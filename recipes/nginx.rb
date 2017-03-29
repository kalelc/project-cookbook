# Cookbook:: project
# Recipe:: nginx
#
# install nginx
package "nginx"

# configure nginx with application
template "#{node['nginx']['sites_available']}/default" do
  source 'nginx/default.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    root: node['nginx']['root'],
    server: node['nginx']['socket'],
    list_ports: node['nginx']['list_ports'],
    server_name: node['nginx']['server_name'],
    logs: node['nginx']['logs'],
    keepalive_timeout: node['nginx']['keepalive_timeout'],
    proxy_read_timeout: node['nginx']['proxy_read_timeout'],
    proxy_send_timeout: node['nginx']['proxy_send_timeout']
  )
end

template "#{node['nginx']['path']}/nginx.conf" do
  source 'nginx/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

