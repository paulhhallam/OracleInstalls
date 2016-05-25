#
# Cookbook Name:: oracleOSsetup
#
# Recipe:: oracle_user_profiles
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
# Set up the ORACLE users profile
#
puts "#### ORACLE12C ORACLE USER PROFILES"
template "/home/oracle/.bash_profile" do
  action :create
  source 'ora_profile_12c.erb'
  owner 'oracle'
  group 'oinstall'
end

#
# Set up the GRID users profile
#
puts "#### ORACLE12C GRID USER PROFILES"
template "/home/grid/.bash_profile" do
  action :create
  source 'ora_grid_profile.erb'
  owner 'grid'
  group 'oinstall'
end

