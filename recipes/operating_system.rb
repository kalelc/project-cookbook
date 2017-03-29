#
# Cookbook:: project
# Recipe:: operating_system
#

# create swap
bash "create swap file #{node['operating_system']['swapfile_name']}" do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=#{node['operating_system']['swapfile_name']} bs=1M count=#{node['operating_system']['swapfile_size_mb']}
    mkswap #{node['operating_system']['swapfile_name']}
    chown root:root #{node['operating_system']['swapfile_name']}
    chmod 0600 #{node['operating_system']['swapfile_name']}
  EOC
  creates node['operating_system']['swapfile_name']
end

mount 'swap' do
  action :enable
  device node['operating_system']['swapfile_name']
  fstype 'swap'
end

bash 'activate all swap devices' do
  user 'root'
  code 'swapon -a'
end

