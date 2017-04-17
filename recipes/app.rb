# Cookbook:: project
# Recipe:: app
#
# get project
git "#{node.normal["path"]}" do
  user node.normal["user"]
  group node.normal["user"]
  repository node["app_source"]["url"]
end

#execute "change permission" do
#  user "root"
#  command "chown -R #{node.normal["user"]}:#{node.normal["user"]} #{node.normal["path"]}"
#  action :run
#end

# bundle install
execute "bundle install" do
  cwd node.normal["path"]
  environment({
    "PATH" => "#{node.normal["home"]}/.rbenv/bin:#{node.normal["home"]}/.rbenv/plugins/ruby-build/bin:#{node.normal["home"]}/.rbenv/shims:#{ENV["PATH"]}",
    "HOME" => node.normal["home"]
  })
end

include_recipe "project::puma"

execute "service nginx restart" do
  action :run
end
