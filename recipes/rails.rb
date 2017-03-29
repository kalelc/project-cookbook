# Cookbook:: project
# Recipe:: rails
#
# rbenv
git "#{node.normal["home"]}/.rbenv" do
  repository node["rails"]["ruby"]["rbenv"]
  user node.normal["user"]
  group group node.normal["user"]
end

execute "rbenv" do
  cwd node.normal["home"]
  command <<-EOH
  echo 'export PATH="#{node.normal["home"]}/.rbenv/bin:$PATH"' >> .bashrc
  echo 'eval "$(rbenv init -)"' >> .bashrc
  exec $SHELL
  EOH
end

# ruby-build
directory "#{node.normal["home"]}/.rbenv/plugins" do
  owner node.normal["user"]
  group node.normal["user"]
  mode '0755'
  action :create
end

git "#{node.normal["home"]}/.rbenv/plugins/ruby-build" do
  repository node["rails"]["ruby"]["ruby_build"]
  user node.normal["user"]
  group node.normal["user"]
end

execute "ruby_build" do
  cwd node.normal["home"]
  command <<-EOH
  echo 'export PATH="#{node.normal["home"]}/.rbenv/plugins/ruby-build/bin:$PATH"' >> .bashrc
  exec $SHELL
  EOH
end

# install rails
execute "ruby_with_rails" do
  user node.normal["user"]
  group node.normal["user"]
  environment({
    "PATH" => "#{node.normal["home"]}/.rbenv/bin:#{node.normal["home"]}/.rbenv/plugins/ruby-build/bin:#{node.normal["home"]}/.rbenv/shims:#{ENV['PATH']}",
    "HOME" => node.normal["home"]
  })

  command <<-EOH
  rbenv install #{node.normal["ruby_version"]} --skip-existing
  rbenv global #{node.normal["ruby_version"]}
  gem install bundler
  gem install rails -v #{node.normal['rails_version']}
  EOH
end

