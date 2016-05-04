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
default[:oracle][:grid][:grid_home] = "#{node[:oracle][:ora_base]}/grid"
default[:oracle][:grid][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"
default[:oracle][:grid][:sup_grps] = {'wheel' => 10, 'asmadmin' => 508, 'asmdba' => 505, 'asmoper' => 509, 'dba' => 502}
default[:oracle][:grid][:install_files] = ['/u01/V46096-01_1of2.zip','/u01/V46096-01_2of2.zip']

# Settings specific to the Oracle user.
default[:oracle][:user][:uid] = 592
default[:oracle][:user][:gid] = 501
default[:oracle][:user][:shell] = '/bin/bash'
default[:oracle][:user][:pw_set] = false
default[:oracle][:user][:edb] = 'oracle'
default[:oracle][:user][:edb_item] = 'foo'
default[:oracle][:user][:sup_grps] = {'wheel' => 10, 'oinstall' => 501, 'dba' => 502, 'oper' => 503, 'backupdba' => 504, 'asmdba' => 505, 'dgdba' => 506, 'kmdba' => 507, 'asmadmin' => 508, 'asmoper' => 509}
default[:oracle][:user][:new_grps] = {'oinstall' => 501, 'dba' => 502, 'oper' => 503, 'backupdba' => 504, 'asmdba' => 505, 'dgdba' => 506, 'kmdba' => 507, 'asmadmin' => 508, 'asmoper' => 509}

## Settings specific to the Oracle RDBMS proper.
default[:oracle][:rdbms][:dbbin_version] = '12c'
default[:oracle][:rdbms][:ora_home] = "#{node[:oracle][:ora_base]}/product/11204/dbhome_1"
default[:oracle][:rdbms][:ora_home_12c] = "#{node[:oracle][:ora_base]}/12R1"
default[:oracle][:rdbms][:is_installed] = false
default[:oracle][:rdbms][:install_info] = {}
default[:oracle][:rdbms][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"
default[:oracle][:rdbms][:response_file_url] = ''
default[:oracle][:rdbms][:db_create_template] = 'default_template.dbt'

# Oracle dependencies for 12c
default[:oracle][:rdbms][:deps_12c] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc',
                                   'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio',
                                   'libaio-devel', 'libXext', 'libXtst', 'libX11', 'libXau', 'libxcb', 'libXi', 'make', 'sysstat']

# Oracle environment for 12c
default[:oracle][:rdbms][:env_12c] = {
  'ORACLE_BASE' => node[:oracle][:ora_base],
  'ORACLE_HOME' => node[:oracle][:rdbms][:ora_home_12c],
  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:ora_base]}/dba/bin:#{node[:oracle][:rdbms][:ora_home_12c]}/bin:#{node[:oracle][:rdbms][:ora_home_12c]}/OPatch"}

# Oracle environment for 11g
default[:oracle][:rdbms][:env] = {'ORACLE_BASE' => node[:oracle][:ora_base],
                                  'ORACLE_HOME' => node[:oracle][:rdbms][:ora_home],
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:ora_base]}/dba/bin:#{node[:oracle][:rdbms][:ora_home]}/bin:#{node[:oracle][:rdbms][:ora_home]}/OPatch"}
#
#
#
#default[:oracle][:rdbms][:install_files] = ['/media/sf_oracle_kist/11g/linux.x64_11gR2_database_1of2.zip','/media/sf_oracle_kist/11g/linux.x64_11gR2_database_1of2.zip']
#default[:oracle][:rdbms][:install_files] = ['/home/paul/Downloads/V46095-01_1of2.zip','/home/paul/Downloads/V46095-01_2of2.zip']

# Passwords set by createdb.rb for the default open database users.
# By order of appearance, those are: SYS, SYSTEM and DBSNMP.
# The latter is for the OEM agent.
default[:oracle][:rdbms][:sys_pw] = 'sys_pw_goes_here'
default[:oracle][:rdbms][:system_pw] = 'system_pw_goes_here'
default[:oracle][:rdbms][:dbsnmp_pw] = 'dbsnmp_pw_goes_here'

# Settings related to patching.
#default[:oracle][:rdbms][:opatch_update_url] = 'https://https-server.example.localdomain/path/to/p6880880_112000_Linux-x86-64.zip'
#default[:oracle][:rdbms][:latest_patch][:url] = 'https://https-server.example.localdomain/path/to/p16619892_112030_Linux-x86-64.zip'

