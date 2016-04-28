#
# Cookbook Name:: oracle
# Recipe:: getgridbin
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
## Get and unzip the Oracle Grid binaries.
#

# Creating $ORACLE_BASE and the install directory.
[node[:oracle][:ora_base], node[:oracle][:grid][:install_dir]].each do |dir|
  directory dir do
    owner 'grid'
    group 'oinstall'
    mode '0755'
    action :create
    recursive true
  end
end

# We need unzip to expand the install files later on.
yum_package 'unzip'

#
# We have wget.sh in ~/Downloads which will get the 12.1.0.2 grid software from oracle BUT
# we don't really want to include that at the moment as it has passwords encoded
# For now we'll assume the software is local
# 
node[:oracle][:grid][:install_files].each do |zip_file|
  execute "fetch_oracle_media_#{zip_file}" do
    command "cp /u01/V* ."
    user "grid"
    group 'oinstall'
    cwd node[:oracle][:grid][:install_dir]
  end

  execute "unzip_oracle_media_#{zip_file}" do
    command "unzip -o #{File.basename(zip_file)}"
    user "grid"
    group 'oinstall'
    cwd node[:oracle][:grid][:install_dir]
  end
end

file "#{node[:oracle][:grid][:install_dir]}/V*" do 
  action :delete
end

bash 'clean_installer' do
    cwd "#{node[:oracle][:grid][:install_dir]}"
    code "rm -f V*"
  end

# This oraInst.loc specifies the standard oraInventory location.
file "#{node[:oracle][:ora_base]}/oraInst.loc" do
  owner "grid"
  group 'oinstall'
  content "inst_group=oinstall\ninventory_loc=/opt/oraInventory"
end

directory node[:oracle][:ora_inventory] do
  owner 'grid'
  group 'oinstall'
  mode '0755'
  action :create
end

# Filesystem template.
template "#{node[:oracle][:grid][:install_dir]}/db11R23.rsp" do
  owner 'grid'
  group 'oinstall'
  mode '0644'
end

# Filesystem template.
template "#{node[:oracle][:grid][:install_dir]}/db12c.rsp" do
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

