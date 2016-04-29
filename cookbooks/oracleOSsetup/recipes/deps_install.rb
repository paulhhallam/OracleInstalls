#
# Cookbook Name:: oracle12c
# Recipe:: deps_install
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
# Install Oracle RDBMS' dependencies.
#
# get the oracle public repo
remote_file "/etc/yum.repos.d/public-yum-ol7.repo" do
  source "http://public-yum.oracle.com/public-yum-ol7.repo" 
end
#
# Install the rpm's from the oracle public repo
#
package "oracle-rdbms-server-12cR1-preinstall" do
  package_name "oracle-rdbms-server-12cR1-preinstall"
  action :install
end
#
# Update the OS to ensure all rpm's are compatible
#
bash "update OS" do
  code <<-EOH
    yum update -y
  EOH
end
#
#node[:oracle][:rdbms][:deps].each do |dep|
#  yum_package dep
#end
#
