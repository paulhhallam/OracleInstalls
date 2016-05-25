#
# Cookbook Name:: oracle
# Attributes::default
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

# System Settings
# System memory size
default[:system][:mem] = '4'
# General Oracle settings.
default[:oracle][:ora_base] = '/u01/app/oracle'
default[:oracle][:grid_base] = '/u01/app/grid'
default[:oracle][:ora_inventory] = '/u01/app/oraInventory'
#ORACLE_BASE /u01/app/12.1.0/grid
#ORA_CRS_HOME /u01/app/12.1.0/grid
#INVENTORY /u01/app/oraInventory

#
# Settings specific to the Grid user.
default[:oracle][:grid][:uid] = 591
default[:oracle][:grid][:gid] = 501
default[:oracle][:grid][:shell] = '/bin/bash'
default[:oracle][:grid][:pw_set] = false
default[:oracle][:grid][:edb] = 'oracle'
default[:oracle][:grid][:edb_item] = 'foo'
default[:oracle][:grid][:grid_home] = "#{node[:oracle][:grid_base]}/12102"
default[:oracle][:grid][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"
default[:oracle][:grid][:sup_grps] = {'wheel' => 10, 'oinstall' => 501, 'asmadmin' => 508, 'asmdba' => 505, 'asmoper' => 509, 'dba' => 502, 'bckpdba' => 504, 'vboxsf' => 978}
default[:oracle][:grid][:install_files] = ['/u01/V46096-01_1of2.zip','/u01/V46096-01_2of2.zip']

# Settings specific to ASM setup
default[:oracle][:grid][:asm_installed] = false
default[:oracle][:grid][:discover_disks] = true
default[:oracle][:grid][:add_disks] = {}
# default[:oracle][:grid][:sd_volumes] = {'sdb1','sdc1','sdd1'}
default[:oracle][:grid][:sd_volumes] = {}

# Settings specific to the Oracle user.
default[:oracle][:user][:uid] = 592
default[:oracle][:user][:gid] = 501
default[:oracle][:user][:shell] = '/bin/bash'
default[:oracle][:user][:pw_set] = false
default[:oracle][:user][:edb] = 'oracle'
default[:oracle][:user][:edb_item] = 'foo'
default[:oracle][:user][:sup_grps] = {'wheel' => 10, 'oinstall' => 501, 'dba' => 502, 'oper' => 503, 'bckpdba' => 504, 'asmdba' => 505, 'dgdba' => 506, 'kmdba' => 507, 'asmadmin' => 508, 'asmoper' => 509, 'vboxsf' => 978}
#default[:oracle][:user][:new_grps] = {'oinstall' => 501, 'dba' => 502, 'oper' => 503, 'backupdba' => 504, 'asmdba' => 505, 'dgdba' => 506, 'kmdba' => 507, 'asmadmin' => 508, 'asmoper' => 509}
default[:oracle][:user][:new_grps] = {'oinstall' => 501, 'dba' => 502, 'oper' => 503, 'bckpdba' => 504, 'asmdba' => 505, 'dgdba' => 506, 'kmdba' => 507, 'asmadmin' => 508, 'asmoper' => 509}

## Settings specific to the Oracle 11g RDBMS.
default[:oracle][:rdbms11g][:dbbin_version] = '11g'
default[:oracle][:rdbms11g][:ora_home] = "#{node[:oracle][:ora_base]}/product/11204/dbhome_1"
default[:oracle][:rdbms11g][:is_installed] = false
default[:oracle][:rdbms11g][:os_installed] = false
default[:oracle][:rdbms11g][:install_info] = {}
default[:oracle][:rdbms11g][:response_file_url] = ''
default[:oracle][:rdbms11g][:db_create_template] = 'default_template.dbt'

# Oracle environment for 11g
default[:oracle][:rdbms11g][:env] = {
  'ORACLE_BASE' => node[:oracle][:ora_base],
  'ORACLE_HOME' => node[:oracle][:rdbms11g][:ora_home],
  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:ora_base]}/dba/bin:#{node[:oracle][:rdbms11g][:ora_home]}/bin:#{node[:oracle][:rdbms11g][:ora_home]}/OPatch"}


# Settings specific to the Oracle 12c RDBMS.
default[:oracle][:rdbms12c][:dbbin_version] = '12c'
default[:oracle][:rdbms12c][:ora_home] = "#{node[:oracle][:ora_base]}/product/12102/dbhome_1"
default[:oracle][:rdbms12c][:is_installed] = false
default[:oracle][:rdbms12c][:os_installed] = false
default[:oracle][:rdbms12c][:install_info] = {}
#default[:oracle][:rdbms12c][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"
default[:oracle][:rdbms12c][:response_file_url] = ''
default[:oracle][:rdbms12c][:db_create_template] = 'default_template.dbt'

# Oracle dependencies for 12c
default[:oracle][:rdbms12c][:deps] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc',
  'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio',
  'libaio-devel', 'libXext', 'libXtst', 'libX11', 'libXau', 'libxcb', 'libXi', 'make', 'sysstat']

# Oracle environment for 12c
default[:oracle][:rdbms12c][:env] = {
  'ORACLE_BASE' => node[:oracle][:ora_base],
  'ORACLE_HOME' => node[:oracle][:rdbms12c][:ora_home],
  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:ora_base]}/dba/bin:#{node[:oracle][:rdbms12c][:ora_home]}/bin:#{node[:oracle][:rdbms12c][:ora_home]}/OPatch"}

# Passwords set by createdb.rb for the default open database users.
# By order of appearance, those are: SYS, SYSTEM and DBSNMP.
# The latter is for the OEM agent.
default[:oracle][:rdbms11g][:sys_pw] = 'Changeme3'
default[:oracle][:rdbms11g][:system_pw] = 'Changeme3'
default[:oracle][:rdbms11g][:dbsnmp_pw] = 'Changeme3'
default[:oracle][:rdbms12c][:sys_pw] = 'Changeme3'
default[:oracle][:rdbms12c][:system_pw] = 'Changeme3'
default[:oracle][:rdbms12c][:dbsnmp_pw] = 'Changeme3'

# Settings related to patching.
#default[:oracle][:rdbms][:opatch_update_url] = 'https://https-server.example.localdomain/path/to/p6880880_112000_Linux-x86-64.zip'
#default[:oracle][:rdbms][:latest_patch][:url] = 'https://https-server.example.localdomain/path/to/p16619892_112030_Linux-x86-64.zip'

