#
# Cookbook Name:: oracle11g
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

default[:oracle][:rdbms12c][:install_files] = ['/media/sf_oracle_kits/12c/28092015/V46095-01_1of2_Database_12_1_0_2_0.zip','/media/sf_oracle_kits/12c/28092015/V46095-01_2of2_Database_12_1_0_2_0.zip']

# Settings related to patching.
default[:oracle][:rdbms12c][:opatch_update_url] = 'https://https-server.example.localdomain/path/to/p6880880_112000_Linux-x86-64.zip'
default[:oracle][:rdbms12c][:latest_patch][:url] = 'https://https-server.example.localdomain/path/to/p16619892_112030_Linux-x86-64.zip'

