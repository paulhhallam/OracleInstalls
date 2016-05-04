#
#
## Cookbook Name:: oracle
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

# Configure Oracle user, install the RDBMS's dependencies, configure
# kernel parameters, install the binaries and apply latest patch.

# Set up and configure the oracle user.
#phh# include_recipe 'oracleOSsetup::oracle_user_config'

## Install dependencies and configure kernel parameters.
#phh# include_recipe 'oracleOSsetup::deps_install'

# Setting up kernel parameters
#phh# include_recipe 'oracleOSsetup::kernel_params'

# Baseline install for Oracle itself
#phh# include_recipe 'oracle11g::dbbin' unless node[:oracle][:rdbms][:is_installed]

## Patching oracle binaries to the latest patch
#phh#include_recipe 'oracle11g::latest_dbpatch' unless node[:oracle][:rdbms][:latest_patch][:is_installed]

# Create the databases
include_recipe 'oracle11g::createdb'
