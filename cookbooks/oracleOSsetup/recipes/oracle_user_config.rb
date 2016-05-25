#
# Cookbook Name:: oracleOSsetup
#
# Recipe:: oracle_user_config
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
## Create and configure the oracle users and groups. 
#

#
# Create all the oracle groups. 
#
puts "#### Creating Oracle Groups"
node[:oracle][:user][:new_grps].each_key do |grp|
  group grp do
    gid node[:oracle][:user][:new_grps][grp]
  end
end

#
# Create the grid user.
#
puts "#### Creating GRID USER"
user 'grid' do
  uid node[:oracle][:grid][:uid]
  gid node[:oracle][:grid][:gid]
  shell node[:oracle][:grid][:shell]
  comment 'Oracle Grid Administrator'
  supports :manage_home => true
end

#
# Configure the grid user groups.
#
puts "#### Configure GRID Groups"
node[:oracle][:grid][:sup_grps].each_key do |grp|
  group grp do
    members ['grid']
    append true
  end
end

#
# Create the oracle user.
#
puts "#### Create Oracle User"
user 'oracle' do
  uid node[:oracle][:user][:uid]
  gid node[:oracle][:user][:gid]
  shell node[:oracle][:user][:shell]
  comment 'Oracle Administrator'
  supports :manage_home => true
end

#
# Configure the oracle user groups.
# 
puts "#### Configure Oracle Groups"
node[:oracle][:user][:sup_grps].each_key do |grp|
  group grp do
    members ['oracle']
    append true
  end
end

yum_package File.basename(node[:oracle][:user][:shell])

#
# Set up the ORACLE users profile
#
puts "#### Setup oracle profile"
template "/home/oracle/.bash_profile" do
  action :create
  source 'ora_profile.erb'
  owner 'oracle'
  group 'oinstall'
end

#
# Set up the GRID users profile
#
puts "#### Setup grid profile"
template "/home/grid/.bash_profile" do
  action :create
  source 'ora_grid_profile.erb'
  owner 'grid'
  group 'oinstall'
end
#
#        # Color setup for ls.
#execute 'gen_dir_colors' do
#  command '/usr/bin/dircolors -p > /home/oracle/.dir_colors'
#  user 'oracle'
#  group 'oinstall'
#  cwd '/home/oracle'
#  creates '/home/oracle/.dir_colors'
#  only_if {node[:oracle][:user][:shell] != '/bin/bash'}
#end

#
# Set the grid user's password.
#
puts "#### Set grid password"
unless node[:oracle][:grid][:pw_set]
  ora_pw = 'Changeme3'
  # Note that output formatter will display the password on your terminal.
  execute 'change_grid_user_pw' do
    command "echo grid:#{ora_pw} | /usr/sbin/chpasswd"
  end
  ruby_block 'set_pw_attr' do
    block do
      node.set[:oracle][:grid][:pw_set] = true
    end
    action :create
  end
end
                                  
#
# Set the oracle user's password.
#
puts "#### Set Oracle Password"
unless node[:oracle][:user][:pw_set]
  ora_pw = 'Changeme3'
  # Note that output formatter will display the password on your terminal.
  execute 'change_oracle_user_pw' do
    command "echo oracle:#{ora_pw} | /usr/sbin/chpasswd"
  end
  ruby_block 'set_pw_attr' do
    block do
      node.set[:oracle][:user][:pw_set] = true
    end
    action :create
  end
end

# Set resource limits for the oracle and grid users.
# partially no longer required as oracle-rdbms-server-12cR1-preinstall installation covers the oracle user.
puts "#### SET Security Limits"
cookbook_file '/etc/security/limits.d/99-grid.conf' do
  mode '0644'
  source 'grid_limits'
end
#
#file '/etc/security/limits.d/20-nproc.conf' do
#  content 'grid              hard    nofile  63536'
#end
#

puts "#### Set ULIMITS"
ruby_block "insert_grid_ulimits" do
  block do
    file = Chef::Util::FileEdit.new("/etc/security/limits.d/20-nproc.conf")
    file.insert_line_if_no_match("grid     hard    nofile  65536", "grid     hard    nofile  65536")
    file.write_file
  end
end

#
# Set up SSH for oracle
#
puts "#### SETUP Oracle SSH"
bash "oracle-ssh-passwordless" do
  user 'oracle'
  cwd '/home/oracle'
  code <<-EOH
    ssh-keygen -q -N '' -f /home/oracle/.ssh/id_rsa
    cd .ssh
    cat id_rsa.pub > authorized_keys
  EOH
end

#
# Set up SSH for grid
#
puts "#### SETUP GRID SSH"
bash "grid-ssh-passwordless" do
  user 'grid'
  cwd '/home/grid'
  code <<-EOH
    ssh-keygen -q -N '' -f /home/grid/.ssh/id_rsa
    cd .ssh
    cat id_rsa.pub > authorized_keys
  EOH
end

#
#Creating $ORACLE_BASE and the install directory.
#
puts "#### Create BASE AND INSTALL DIRS"
[node[:oracle][:ora_base], node[:oracle][:grid_base], node[:oracle][:grid][:install_dir]].each do |dir|
  directory dir do
    owner 'grid'
    group 'oinstall'
    mode '0755'
    action :create
    recursive true
  end
end

#
# This oraInst.loc specifies the standard oraInventory location.
puts "#### SETUP ORAINST"
file "#{node[:oracle][:ora_base]}/oraInst.loc" do
  owner "grid"
  group 'oinstall'
  content "inst_group=oinstall\ninventory_loc=#{node[:oracle][:ora_inventory]}\n"
end

directory node[:oracle][:ora_inventory] do
  owner "grid"
  group 'oinstall'
  mode '0755'
  action :create
end
#
# Filesystem template.
#
template "#{node[:oracle][:grid][:install_dir]}/db11R23.rsp" do
  owner 'grid'
  group 'oinstall'
  mode '0644'
end
#
# Filesystem template.
#
template "#{node[:oracle][:grid][:install_dir]}/db12c.rsp" do
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end
#
#
