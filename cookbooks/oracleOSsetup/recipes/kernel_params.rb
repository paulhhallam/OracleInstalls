#
# Cookbook Name:: oracle
# Recipe:: kernel_params
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
## Configure kernel parameters for Oracle RDBMS.
#

puts "#### Creating SWAPFS"
ruby_block "create_swapfs" do
  block do
    file = Chef::Util::FileEdit.new("/etc/fstab")
    file.insert_line_if_no_match("tmpfs  /dev/shm  /tmpfs  rw,exec,size=#{node['system']['mem']}g 0 0", "tmpfs  /dev/shm  /tmpfs  rw,exec,size=#{node['system']['mem']}g 0 0")
    file.write_file
  end
end

puts "#### RELOAD SYSCTL"
bash 'sysctl_reload' do
  code 'source /etc/init.d/functions && apply_sysctl'
  action :nothing
end

directory '/etc/sysctl.d' do
  mode '0755'
end

cookbook_file '/etc/sysctl.d/ora_params' do
  mode '0644'
  notifies :run, 'bash[sysctl_reload]', :immediately
end

service 'ntpd' do
  action [ :stop, :disable ]
end
execute 'move_ntp_pid' do
  command 'mv /etc/ntp.conf /etc/ntp.conf.orig'
  only_if { File.exists?("/etc/ntp.conf") }
end
execute 'remove_ntp_pid' do
  command 'rm /var/run/ntpd.pid'
  only_if { File.exists?("/var/run/ntpd.pid") }
end

service 'avahi-daemon' do
  action [ :stop, :disable ]
end
