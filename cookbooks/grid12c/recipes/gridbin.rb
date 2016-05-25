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
#[node[:oracle][:ora_base]].each do |dirb|
#  directory dirb do
directory "/u01" do
    owner 'grid'
    group 'oinstall'
    mode '0777'
    action :create
end

directory "/u01/app" do
    owner 'grid'
    group 'oinstall'
    mode '0755'
    action :create
end

directory "#{node[:oracle][:grid_base]}" do
    owner 'grid'
    group 'oinstall'
    mode '0755'
    action :create
end

directory "#{node[:oracle][:ora_base]}" do
    owner 'oracle'
    group 'oinstall'
    mode '0755'
    action :create
end

# Creating $ORACLE_BASE and the install directory.
#[node[:oracle][:ora_base], node[:oracle][:grid][:install_dir]].each do |dir|
#  directory dir do
directory "#{node[:oracle][:grid][:install_dir]}" do
    owner 'grid'
    group 'oinstall'
    mode '0755'
    action :create
end

# We need unzip to expand the install files later on.
yum_package 'unzip'

#
#node[:oracle][:grid][:install_files].each do |zip_file|
#  execute "unzip_oracle_media_file_#{zip_file}" do
#    command "unzip -o #{zip_file}"
#    user "grid"
#    group 'oinstall'
#    cwd node[:oracle][:grid][:install_dir]
#    not_if  ::File.exists?('#{node[:oracle][:grid][:install_dir]}grid/runcluvfy.sh') 
#  end
#end

execute "unzip_oracle_media_files" do
    node[:oracle][:grid][:install_files].each do |zip_file|
      command "unzip -o #{zip_file}"
      user "grid"
      group 'oinstall'
      cwd node[:oracle][:grid][:install_dir]
    end
    not_if  {::File.exist?('#{node[:oracle][:grid][:install_dir]}grid/runcluvfy.sh')}
end

puts "###### now do runcluvfy"
execute 'test_grid_installer' do
  user "grid"
  group "oinstall"
  command "#{node[:oracle][:grid][:install_dir]}/grid/runcluvfy.sh stage -pre crsinst -n $HOSTNAME -fixupnoexec > #{node[:oracle][:grid][:install_dir]}/grid/cluvfy.log"
  ignore_failure true
 returns 0
end

#
# NOW CHECK RESOLV.CONF
# RUNCLUVFY SHOULD HAVE FAILED
# RUNINSTALLER USING RESPONSE FILE TO "INSTALL AND CONFIGURE ORACLE GRID INFRASTRUCTURE FOR A STANDALONE SERVER"
#

bash "install grid" do
  user 'grid'
  code <<-EOH5
     #{node[:oracle][:grid][:install_dir]}/grid/runInstaller -silent -showProgress -waitforcompletion ORACLE_HOSTNAME=ambari5 INVENTORY_LOCATION=/u01/app/oraInventory SELECTED_LANGUAGES=en oracle.install.option=HA_CONFIG  ORACLE_BASE=/u01/app/grid ORACLE_HOME=/u01/app/grid/12102 oracle.install.asm.OSDBA=asmdba oracle.install.asm.OSOPER=asmoper oracle.install.asm.OSASM=asmadmin oracle.install.crs.config.autoConfigureClusterNodeVIP=false oracle.install.asm.diskGroup.name=DATA oracle.install.asm.diskGroup.redundancy=EXTERNAL oracle.install.asm.diskGroup.AUSize=1 oracle.install.asm.diskGroup.disks=/dev/oracleasm/disks/DISK0,/dev/oracleasm/disks/DISK1,/dev/oracleasm/disks/DISK2,/dev/oracleasm/disks/DISK3 oracle.install.asm.diskGroup.diskDiscoveryString=/dev/oracleasm/disks oracle.install.asm.SYSASMPassword=Change321me oracle.install.asm.monitorPassword=Change321me
EOH5
end

cookbook_file "/u01/app/grid/12102/grid_second_response_file.rsp" do
  source 'grid_2.rsp'
  owner 'grid'
  group 'oinstall'
  mode '0755'
end
#/u01/app/oracle/product/12.1.0/grid/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/home/grid/Documents/grid_stand_alone.rsp

# RAN MANUALLY THIS WORKS
# /media/sf_oracle_kits/12c/28092015/grid/runInstaller -silent -showProgress -waitforcompletion ORACLE_HOSTNAME=ambari5 INVENTORY_LOCATION=/u01/app/oraInventory SELECTED_LANGUAGES=en oracle.install.option=HA_CONFIG  ORACLE_BASE=/u01/app/grid ORACLE_HOME=/u01/app/grid/12102 oracle.install.asm.OSDBA=asmdba oracle.install.asm.OSOPER=asmoper oracle.install.asm.OSASM=asmadmin oracle.install.crs.config.autoConfigureClusterNodeVIP=false oracle.install.asm.diskGroup.name=DATA oracle.install.asm.diskGroup.redundancy=EXTERNAL oracle.install.asm.diskGroup.AUSize=1 oracle.install.asm.diskGroup.disks=/dev/oracleasm/disks/DISK0,/dev/oracleasm/disks/DISK1,/dev/oracleasm/disks/DISK2,/dev/oracleasm/disks/DISK3 oracle.install.asm.diskGroup.diskDiscoveryString=/dev/oracleasm/disks oracle.install.asm.SYSASMPassword=Change321me oracle.install.asm.monitorPassword=Change321me
#
# ..................................................   100% Done.
# Successfully Setup Software.
# As install user, execute the following script to complete the configuration.
# 	1. /u01/app/oracle/product/12.1.0/grid/cfgtoollogs/configToolAllCommands RESPONSE_FILE=<response_file>
#
# 	Note:
# 		1. This script must be run on the same host from where installer was run. 
# 		2. This script needs a small password properties file for configuration assistants that require passwords (refer to install guide documentation).
#
#$ /u01/app/oracle/product/12.1.0/grid/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/home/grid/Documents/grid_stand_alone.rsp
#
