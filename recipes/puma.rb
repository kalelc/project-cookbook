# Cookbook:: project
# Recipe:: puma
#
#folders
node["app"]["puma"]["folders"].each do |dir|
  directory "#{node.normal["path"]}/#{dir}" do
    mode 0755
    owner node.normal["user"]
    group node.normal["user"]
    action :create
    recursive true
  end
end

# puma config file
template "#{node.normal["path"]}/#{node["app"]["puma"]["file"]}" do
  source "puma/puma.rb.erb"
  owner node.normal["user"]
  group node.normal["user"]
  mode 0775
  variables(
    path: node.normal["path"],
    workers: node["app"]["puma"]["workers"],
    threads: node["app"]["puma"]["threads"],
    folders: node["app"]["puma"]["folders"],
    bind: node["app"]["puma"]["bind"],
    pid: node["app"]["puma"]["pid"],
    state: node["app"]["puma"]["state"],
    logs: node["app"]["puma"]["logs"]
  )
end

if !File.exist?("#{node.normal['path']}/sockets/#{node['app']['puma']['bind']}")
  execute "bundle exec puma" do
    cwd node.normal["path"]
    user node.normal["user"]
    group node.normal["user"]
    environment({
      "PATH" => "#{node.normal["home"]}/.rbenv/bin:#{node.normal["home"]}/.rbenv/plugins/ruby-build/bin:#{node.normal["home"]}/.rbenv/shims:#{ENV["PATH"]}",
      "HOME" => node.normal["home"]
    })
    command "bundle exec puma -C #{node["app"]["puma"]["file"]}"
  end
else
  execute "bundle exec pumactl -F #{node['app']['puma']['file']} restart" do
    environment({
      "PATH" => "#{node.normal["home"]}/.rbenv/bin:#{node.normal["home"]}/.rbenv/plugins/ruby-build/bin:#{node.normal["home"]}/.rbenv/shims:#{ENV["PATH"]}",
      "HOME" => node.normal["home"]
    })
    cwd node.normal['path']
    action :run
  end
end
