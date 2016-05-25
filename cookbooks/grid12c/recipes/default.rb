#
# Cookbook Name:: oracle
# Recipe:: default
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

# Set up and configure the oracle user.
include_recipe 'oracleOSsetup::oracle_user_config'
#
# ## Install dependencies and configure kernel parameters.
include_recipe 'oracleOSsetup::deps_install'
#
# # Setting up kernel parameters
include_recipe 'oracleOSsetup::kernel_params'
#
# # Set up and configure the oracle user.
include_recipe 'oracle12c::oracle_users_profiles'
#

# Baseline install for Grid itself
#
# Configure ASM
#
include_recipe 'grid12c::asm_setup' unless node[:oracle][:grid][:is_installed]

include_recipe 'grid12c::gridbin'   unless node[:oracle][:grid][:is_installed]

# Patching oracle binaries to the latest patch
# Node attribute changes for 12c, if default[:oracle][:rdbms][:dbbin_version] is set to 12c
#phh  include_recipe 'oracle12c::latest_dbpatch' unless node[:oracle][:rdbms][:latest_patch][:is_installed]

